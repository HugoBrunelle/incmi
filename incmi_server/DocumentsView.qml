import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: parent.height


    property real mscale: sli.position
    property string bmodel
    property string sname
    property string surl

    function delDocument() {
        var file = mod.get(typeview.currentIndex).filename;
        var md = JSON.parse(bmodel);
        for (var i = 0; i< md.items.length; i++){
            var item = JSON.parse(md.items[i]);
            if (item.filename == file){
                md.items.splice(i,1);
            }
        }
        removeDocumentServer(file);
        bmodel = JSON.stringify(md);
        typeview.currentIndex = -1;
        checkChanged();
    }

    function getModel() {
        bmodel = createServerChangesList();
    }

    function setModel() {
        var md = JSON.parse(bmodel);
        for (var i = 0; i < md.items.length; i++) {
            var item = JSON.parse(md.items[i]);
            mod.append(item);
        }
    }

    function imageRendered(obj) {
        if (pload.active) {
            obj.saveToFile(sname + ".png");
            surl = obj.url;
            pload.active = false;
        }
    }

    function checkChanged() {
        mod.clear();
        setModel();
        if (!meddocscheck.checked){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "docs"){
                    mod.remove(b-1);
                }
            }
        }
        if (!invdocscheck.checked){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inv"){
                    mod.remove(c-1);
                }
            }
        }
        //mod = mc;
    }

    function showPreview(type, filename) {
        sname = filename;
        switch (type) {
        case "docs":
            pload.sourceComponent = pdocajust;
            break;
        case "inv":
            pload.sourceComponent = pinvadjust;
            break;
        }
        pload.active = true;
    }

    Loader {
        visible: false;
        active: false;
        id: pload;
        sourceComponent: pdocajust

        onStatusChanged: {
            if (status == Loader.Ready) {
                if (active) {
                    pload.item.setData(sname);
                    pload.item.grabToImage(function(obj) {imageRendered(obj);});
                }
            }
        }
    }

    Component.onCompleted: {
        getModel();
        setModel();
    }
    property int xd: 2
    Rectangle{
        id: mrect
        anchors.margins: 15
        anchors.fill: parent

        Rectangle{
            id: lframe
            color: "whitesmoke"
            border.color: "grey"
            border.width: 1
            width: parent.width/2
            height: parent.height
            ListView {
                id: typeview
                interactive: true
                y: xd
                x: xd
                height: parent.height - 2*xd - lfooter.height
                width: parent.width - 2*xd
                clip: true
                model: ListModel {id: mod}
                currentIndex: -1
                delegate: DocumentsViewDelegate {}
                onCurrentIndexChanged: {
                    if (currentIndex != -1){
                        c.enabled = true;
                    }else {
                        c.enabled = false;
                    }

                    // Change the values of the boxes.
                }
            }

            Item {
                id: lfooter
                width: parent.width - 2*xd
                x: xd
                height: 50
                y: parent.height - lfooter.height - xd
                Rectangle{
                    anchors.fill: parent
                    color: "whitesmoke"
                    border.color: "grey"
                    border.width: 1
                    CheckBox {
                        id: meddocscheck
                        y: xd * 2
                        x: xd * 2
                        width: parent.width / 4 - 4*xd
                        height: parent.height - 4*xd
                        text: "Med Documents"
                        checked: true
                        onCheckedChanged: {
                            checkChanged();
                        }
                    }
                    CheckBox {
                        id: invdocscheck
                        y: xd * 2
                        x: parent.width / 4 + 2*xd
                        width: parent.width / 4 - 4 * xd
                        height: parent.height - 4*xd
                        text: "Inv Documents"
                        checked: true
                        onCheckedChanged: {
                            checkChanged();
                        }

                    }
                }
            }
        }

        Rectangle{
            x: lframe.width + 1
            y:0
            color: "lightgrey"
            border.color: "grey"
            border.width: 1
            width: parent.width/2 - 1
            height: parent.height
            Item {
                id: titem
                anchors.fill: parent
                anchors.margins: 1
                Pane {
                    id: h1
                    x: xd * 3
                    y: xd * 2
                    width: parent.width - 2*x
                    height: 50 - 4*xd
                    Material.background: colordp
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
                                source: surl
                            }
                        }
                    }
                }
                Item {
                    id: cq
                    x: 2.5*xd
                    height: 45 - 2*xd
                    width: parent.width * 1 / 5 - 5*xd
                    y: titem.height - height - 2*xd
                    Image {
                        id: imzoom
                        fillMode: Image.Stretch
                        width: clab.implicitHeight
                        x: 5
                        height: width
                        source: "Icons/ic_zoom_in_black_24dp.png"
                    }

                    Label {
                        id: clab
                        leftPadding: 5
                        font.pointSize: 12
                        text: Math.floor(((sli.position/1) * 100)).toString() + "%"
                        x: imzoom.width + imzoom.x
                        width: parent.width - implicitHeight - 5
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
                    height: 48 - 2*xd
                    y: titem.height - height - 2*xd
                    text: "Exporter"
                    Material.foreground: colorlt
                    Material.background: colordp

                    onClicked: {
                        file.printToPDF(sname);
                        Qt.openUrlExternally(file.getApplicationPath() + "/" + sname + ".pdf");
                    }
                }


                Button {
                    id : c
                    x: (parent.width*3/5)
                    width: parent.width*2/5 - 5*xd
                    height: 48 - 2*xd
                    y: titem.height - height - 2*xd
                    text: "Effacer"
                    Material.foreground: colorlt
                    Material.background: colordp
                    enabled: false;

                    onClicked: {
                        mrect.enabled = false;
                        prm.show();
                    }
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
                prm.hide();
                mrect.enabled = true;
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

