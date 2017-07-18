import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: parent.height

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

    Component.onCompleted: {


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
            model: InventoryListModel {}
            delegate: settypedel

            onCurrentIndexChanged: {
                // Change the values of the boxes.
            }
        }

        Component {
            id: settypedel
            Item {
                x: xd
                height: 38
                width: parent.width - 2*x
                Rectangle {
                    border.color: "lightgrey"
                    anchors.fill: parent
                    height: parent.height
                    width: parent.width
                    color: typeview.currentIndex == index ? "gainsboro" : "white"
                    anchors.margins: 2
                    border.width: 1
                    Label {
                        id: ld
                        x: xd
                        width: (parent.width / 4) - 3*xd
                        height: parent.height
                        text: type
                        font.pointSize: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                    }
                    Rectangle{
                        width: 1
                        y: 3*xd
                        height: parent.height - 6*xd
                        x: parent.width * 1 / 4
                        color: "grey"
                        visible: checkVisibility()
                    }

                    Label {
                        id: ld2
                        x: parent.width*1/4 - 2*xd
                        width: parent.width / 4 - xd
                        height: parent.height
                        text: count
                        font.pointSize: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        visible: checkVisibility()
                    }
                    Rectangle{
                        width: 1
                        y: 3*xd
                        height: parent.height - 6*xd
                        x: parent.width * 2 / 4
                        color: "grey"
                        visible: checkVisibility()
                    }

                    Label {
                        id: ld3
                        x: parent.width * 2 /4 - 2*xd
                        width: parent.width/4 - xd
                        height: parent.height
                        text: rcount
                        font.pointSize: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        visible: checkVisibility()
                    }
                    Rectangle{
                        width: 1
                        y: 3*xd
                        height: parent.height - 6*xd
                        x: parent.width * 3 / 4
                        color: "grey"
                        visible: checkVisibility()
                    }

                    Label {
                        id: ld4
                        x: parent.width * 3 /4 - 2*xd
                        width: parent.width/4 - xd
                        height: parent.height
                        text: rcount
                        font.pointSize: 10
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignRight
                        visible: checkVisibility()
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        typeview.currentIndex = index;
                    }
                }

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
            }



            Button {
                id : b
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

