import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: 1280
    height: 495
    anchors.margins: 15
    property int xd: 2
    Rectangle{
        x:0
        y:0
        color: "lightgrey"
        border.color: "black"
        border.width: 1
        opacity: 0.2
        width: parent.width*3 / 5
        height: parent.height
    }
    ListView {
        id: typeview
        interactive: true
        x:0
        y:5
        clip: true
        width: parent.width*3 / 5
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
                color: typeview.currentIndex == index ? "whitesmoke" : "white"
                anchors.margins: 2
                border.width: 1
                Label {
                    id: ld
                    x: 25
                    width: (parent.width / 4)
                    height: parent.height
                    text: type
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
                Rectangle{
                    width: 1
                    y: 3*xd
                    height: parent.height - 6*xd
                    x: parent.width * 6 / 8 - 4*xd
                    color: "grey"
                }

                Label {
                    id: ld2
                    x: parent.width*6/8 - 2*xd
                    width: parent.width / 8 - xd
                    height: parent.height
                    text: count
                    color: count < rcount ? "red" : "green"
                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
                Rectangle{
                    width: 1
                    y: 3*xd
                    height: parent.height - 6*xd
                    x: parent.width * 7 / 8 - 4*xd
                    color: "grey"
                }

                Label {
                    id: ld3
                    x: parent.width * 7 /8 - 2*xd
                    width: parent.width/8 - xd
                    height: parent.height
                    text: rcount

                    font.pointSize: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
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
        color: "lightgrey"
        border.color: "black"
        border.width: 1
        opacity: 0.2
        width: (parent.width*2)/5 - 1
        height: parent.height
    }
    Item {
        id: titem
        x: typeview.width + 1
        width: (parent.width*2)/5 - 1
        height: parent.height / 2 - 2

        Pane {
            id: h1
            x: xd * 3
            y: xd * 2
            width: parent.width - 2*x
            height: (parent.height / 6) - 4*xd
            Material.background: colorp
            Material.elevation: 3
            Label {
                anchors.fill: parent
                leftPadding: xd*2
                font.pointSize: 11
                Material.foreground: colorlt
                text: "Current Inventory Item"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }


        Label {
            id: l1
            x: xd
            y: h1.height + h1.y + 2*xd
            text: "Host:"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: l2
            x: xd
            y: l1.height + l1.y + 2*xd
            text: "Port:"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: l3
            x: xd
            y: l2.height + l2.y + 2*xd
            text: "Maximum docs to Sync :"
            font.pointSize: 10
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: l4
            x: xd
            y: l3.height + l3.y + 2*xd
            text: "Fabrication / Numero Series :"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Rectangle {
            x: l1.width + l1.x + xd*2
            y: l1.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                font.pointSize: 9
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: l2.width + l2.x + xd*2
            y: l2.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: l3.width + l3.x + xd*2
            y: l3.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: l4.width + l4.x + xd*2
            y: l4.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            x: (parent.width*3/5)
            width: parent.width*2/5 - 5*xd
            y: l4.height + l4.y
            height: (parent.height/6) - 2*xd
            text: "Sauvegarder"
            Material.foreground: colorlt
            Material.background: colordp
        }
    }
    Item {
        x: typeview.width + 1
        y: titem.y + titem.height + 2
        width: (parent.width*2)/5 - 1
        height: parent.height / 2 - 2
        Pane {
            id: h2
            x: xd * 3
            y: xd * 2
            width: parent.width - 2*x
            height: (parent.height / 6) - 4*xd
            Material.background: colorp
            Material.elevation: 3
            Label {
                anchors.fill: parent
                leftPadding: xd*2
                font.pointSize: 11
                Material.foreground: colorlt
                text: "New Inventory Item"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
            }
        }


        Label {
            id: ll1
            x: xd
            y: h2.height + h2.y + 2*xd
            text: "Host:"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: ll2
            x: xd
            y: ll1.height + ll1.y + 2*xd
            text: "Port:"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: ll3
            x: xd
            y: ll2.height + ll2.y + 2*xd
            text: "Maximum docs to Sync :"
            font.pointSize: 10
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Label {
            id: ll4
            x: xd
            y: ll3.height + ll3.y + 2*xd
            text: "Fabrication / Numero Series :"
            font.pointSize: 9
            width: (parent.width*2/5) - 2*x
            height: (parent.height / 6) - 2*xd
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            rightPadding: xd*3
        }
        Rectangle {
            x: ll1.width + ll1.x + xd*2
            y: ll1.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                font.pointSize: 9
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: ll2.width + ll2.x + xd*2
            y: ll2.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: ll3.width + ll3.x + xd*2
            y: ll3.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }
        Rectangle{
            x: ll4.width + ll4.x + xd*2
            y: ll4.y
            width: (parent.width*3/5) - 5*xd
            height: (parent.height/6)-2*xd
            color: "whitesmoke"
            border.color: "lightgrey"
            border.width: 1
            radius: 9
            TextInput {
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: 9
                anchors.leftMargin: 15
                text: qsTr("Text Field")
                verticalAlignment: Text.AlignVCenter
            }
        }

        Button {
            x: (parent.width*3/5)
            width: parent.width*2/5 - 5*xd
            y: ll4.height + ll4.y
            height: (parent.height/6) - 2*xd
            text: "Ajouter"
            Material.foreground: colorlt
            Material.background: colordp
        }
    }

}

