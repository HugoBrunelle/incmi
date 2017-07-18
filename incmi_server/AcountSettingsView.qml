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
        width: parent.width - 2*xd
        height: (parent.height / 8) - 2*xd
        Material.background: colorp
        Material.elevation: 5
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
            height: parent.height / 4
            Label {
                id: l1
                x: xd
                y: xd
                text: "Username:"
                font.pointSize: 10
                width: (parent.width/4) - 2*x
                height: (parent.height / 2) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: l2
                x: xd
                y: l1.height + l1.y + 2*xd
                text: "Password:"
                font.pointSize: 10
                width: (parent.width/4) - 2*x
                height: (parent.height / 2) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle{
                x: l1.width + l1.x + xd*2
                y: l1.y
                width: (parent.width*3/4) - 2*xd
                height: (parent.height/2)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
            TextInput {
                id: acc
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                KeyNavigation.tab: pass
                text: settings.saccount
            }
            }
            Rectangle {
                x: l2.width + l2.x + xd*2
                y: l2.y
                width: (parent.width*3/4) - 2*xd
                height: (parent.height/2)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
            TextInput{
                id: pass
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 10
                KeyNavigation.tab: acc
                text: settings.spass
            }
            }
        }
    }

    function save() {
        console.log("Saving");
        settings.saccount = acc.text;
        settings.spass = pass.text;
    }




}
