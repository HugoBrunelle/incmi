import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: parent.height

    property real mscale: sli.position

    function delDocument() {

    }

    function checkVisibility() {
        var vis = false;
        switch (type) {
        case "inv":
            vis = true;
            break;
        case "docs":
            vis = false;
            break;
        }
        return vis;
    }

    function setModel() {
        var message = JSON.parse(createServerChangesList());
        for (var i = 0; i < message.items.length; i++) {
            var item = JSON.parse(message.items[i]);
            mod.append(item);
        }
    }

    function imageRendered(obj) {
        if (pload.active) {
            currentimageurl = obj.url;
            pload.active = false;
        }
    }

    Loader {
        visible: false;
        active: false;
        id: pload;
        sourceComponent: pcom

        onStatusChanged: {
            if (status == Loader.Ready) {
                if (active) {
                    pload.item.grabToImage(function(obj) {imageRendered(obj);});
                }
            }
        }
    }

    Component.onCompleted: {
        setModel();

    }
    property int xd: 2
    Rectangle{
        id: mrect
        anchors.margins: 15
        anchors.fill: parent

        Rectangle{
            x:0
            y:0
            color: "lightgrey"
            border.color: "black"
            border.width: 1
            opacity: 0.2
            width: parent.width/2
            height: parent.height
        }
        ListView {
            id: typeview
            interactive: true
            x:0
            y:5
            clip: true
            width: parent.width/2
            height: parent.height - 20
            model: ListModel {id: mod}
            delegate: DocumentsViewDelegate {}
            onCurrentIndexChanged: {
                // Change the values of the boxes.
            }
        }
        Rectangle{
            x: typeview.width + 1
            y:0
            color: "darkgrey"
            border.color: "grey"
            border.width: 1
            opacity: 0.5
            width: parent.width/2 - 1
            height: parent.height
        }
        Item {
            id: titem
            x: typeview.width + 1
            width: parent.width/2 - 1
            height: parent.height - 1

            Pane {
                id: h1
                x: xd * 3
                y: xd * 2
                width: parent.width - 2*x
                height: (parent.height / 10) - 4*xd
                Material.background: colorp
                Material.elevation: 3
                Label {
                    anchors.fill: parent
                    leftPadding: xd*2
                    font.pointSize: 11
                    Material.foreground: colorlt
                    text: "Current Document"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }

            Pane {
                x: xd* 10
                y: xd * 10 + h1.height
                width: parent.width - 2*x
                height: parent.height - b.height - h1.height - 18*xd
                Material.background: "whitesmoke"
                Material.elevation: 8
                ScrollView {
                    anchors.fill: parent
                    clip: true
                    contentHeight: rec.height
                    contentWidth: rec.width
                    Rectangle {
                        id: rec
                        width: docpreivew.sourceSize.width * mscale
                        height: docpreivew.sourceSize.height * mscale
                        Image {
                            fillMode: Image.Stretch
                            anchors.fill: parent
                            id: docpreivew
                            source: currentimageurl
                        }
                    }
                }
            }
            Item {
                x: 2.5*xd
                height: (parent.height/10) - 2*xd
                width: parent.width * 1 / 5 - 5*xd
                y: titem.height - height - 2*xd
                Label {
                    id: clab
                    leftPadding: 20
                    font.pointSize: 12
                    text: "Zoom: " + Math.floor(((sli.position/1) * 100)).toString() + "%"
                    width: parent.width
                    height: implicitHeight
                }

                Slider {
                    id: sli
                    y: clab.height
                    height: parent.height - clab.height
                    width: parent.width
                    Material.accent: colora
                    value: 0.5
                }

            }

            Button {
                id : b
                x: (parent.width/5) + 2.5*xd
                width: parent.width*2/5 - 5*xd
                height: (parent.height/10) - 2*xd
                y: titem.height - height - 2*xd
                text: "Exporter"
                Material.foreground: colorlt
                Material.background: colordp

                onClicked: {
                    file.printToPDF(currentimageurl, currentfilename);
                }
            }


            Button {
                id : c
                x: (parent.width*3/5)
                width: parent.width*2/5 - 5*xd
                height: (parent.height/10) - 2*xd
                y: titem.height - height - 2*xd
                text: "Effacer"
                Material.foreground: colorlt
                Material.background: colordp

                onClicked: {
                    mrect.enabled = false;
                    prm.show();
                }
            }
        }
    }

    Prompt {
        id: prm
        anchors.fill: parent
        anchors.topMargin: parent.height /5
        anchors.bottomMargin: parent.height /5
        anchors.leftMargin: parent.width / 3
        anchors.rightMargin: parent.width / 3
        Material.background: colora
        Material.elevation: 6
        Label {
            id: plabel
            x: parent.width /10
            width: parent.width - 2*x
            height: parent.height * 5 /10
            y: parent.height / 5
            text: "Are you certain that you want to delete the current document?"
            wrapMode: Text.WordWrap
            font.pointSize: 16
            Material.foreground: colorlt
        }
        Button {
            y: parent.height - plabel.y * 1.5
            x: parent.width /10
            width: parent.width * 3/ 10
            height: plabel.y
            text: "Oui"
            Material.background: colorp
            Material.foreground: colorlt

            onClicked: {
                delDocument();
            }
        }
        Button {
            y: parent.height - plabel.y * 1.5
            x: parent.width * 3/5
            width: parent.width * 3/ 10
            height: plabel.y
            text: "Non"
            Material.background: colorp
            Material.foreground: colorlt

            onClicked: {
                prm.hide();
                mrect.enabled = true;
            }
        }

    }
}

