import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: 580
    height: 431
    property int xd: 5

    Pane {
        id: title
        x: xd
        y: xd
        Material.background: colorp
        Material.elevation: 5
        width: parent.width - 2*xd
        height: (parent.height / 8) - 2*xd
        Label {
            x: xd * 5
            text: "Account and Password Settings"
            font.pointSize: 14
            width: parent.width - 2*x
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            Material.foreground: colorlt
        }
    }

    Item {
        id: page
        x: xd
        y: xd + title.y + title.height
        width: parent.width - 2*x
        height: (parent.height - title.height ) - 3*xd

        Item {
            x: xd
            width: parent.width - 2*x
            y: xd
            height: parent.height *4 / 10
            Label {
                id: l1
                x: xd
                y: xd
                text: "Host:"
                font.pointSize: 10
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 3) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: l2
                x: xd
                y: l1.height + l1.y + 2*xd
                text: "Port:"
                font.pointSize: 10
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 3) - 2*xd
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
                height: (parent.height / 3) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle {
                x: l1.width + l1.x + xd*2
                y: l1.y
                width: (parent.width*3/5) - 2*xd
                height: (parent.height/3)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: host
                    selectByMouse: true
                    font.pointSize: 10
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: port
                    text: settings.shost
                }
            }
            Rectangle{
                x: l2.width + l2.x + xd*2
                y: l2.y
                width: (parent.width*3/5) - 2*xd
                height: (parent.height/3)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: port
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 10
                    KeyNavigation.tab: mcount
                    text: settings.sport
                }
            }
            Rectangle {
                x: l3.width + l3.x + xd*2
                y: l3.y
                width: (parent.width*3/5) - 2*xd
                height: (parent.height/3)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: mcount
                    selectByMouse: true
                    font.pointSize: 10
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: host
                    text: ""
                }
            }
        }
    }

    function save() {
        settings.sport = port.text;
        settings.shost = host.text;
        settings.smpush = mcount.text;
    }




}
