import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: 580
    height: 431
    property int xd: 3
    property int pad: 5
    property int textboxheight: 30

    Pane {
        id: title
        x: pad
        y: pad
        Material.background: colordp
        Material.elevation: 5
        width: parent.width - 2*pad
        height: (parent.height / 8) - 2*pad
        Label {
            x: pad * 5
            text: "Server Settings"
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
                height: textboxheight
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
                height: textboxheight
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
                height: textboxheight
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle {
                x: l3.width + l3.x + xd*2
                y: l1.y
                width: (parent.width*3/5) - 2*xd
                height: textboxheight
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 3
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
                x: l3.width + l3.x + xd*2
                y: l2.y
                width: (parent.width*3/5) - 2*xd
                height: textboxheight
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 3
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
                height: textboxheight
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 3
                TextInput {
                    id: mcount
                    selectByMouse: true
                    font.pointSize: 10
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: host
                    text: settings.smpush
                }
            }

            CheckBox {
                id: csnew
                x: parent.width - csremove.width - 2*xd
                y: l3.y + l3.height + 2 * xd
                width: csremove.width
                height: textboxheight
                text: "Send an email to members when adding an event"
                checked: settings.scnew
            }
            CheckBox {
                id: csedit
                x: parent.width - csremove.width - 2*xd
                y: csnew.y + csnew.height + 2 * xd
                width: csremove.width
                height: textboxheight
                text: "Send an email to members when an event has been modified"
                checked: settings.scedit
            }
            CheckBox {
                id: csremove
                x: parent.width - csremove.width - 2*xd
                y: csedit.y + csedit.height + 2 * xd
                width: implicitWidth
                height: textboxheight
                text: "Send an email to members when an event has been cancelled"
                checked: settings.scremove
            }
            CheckBox {
                id: csremind
                x: parent.width - csremove.width - 2*xd
                y: csremove.y + csremove.height + 2 * xd
                width: csremove.width
                height: textboxheight
                text: "Remind members by email the day of the event"
                checked: settings.scremind
            }
            CheckBox {
                id: csadmincommit
                x: parent.width - csremove.width - 2*xd
                y: csremind.y + csremind.height + 2 * xd
                width: csremove.width
                height: textboxheight
                text: "Send an email to admins when a change is commited"
                checked: settings.scadmincommit
            }
            CheckBox {
                id: csbackup
                x: parent.width - csremove.width - 2*xd
                y: csadmincommit.y + csadmincommit.height + 2 * xd
                width: csremove.width
                height: textboxheight
                text: "Perform automatic data backup"
                checked: settings.scbackup
            }
        }
    }

    function save() {
        settings.sport = port.text;
        settings.shost = host.text;
        settings.smpush = mcount.text;
        settings.scadmincommit = csadmincommit.checked;
        settings.scedit = csedit.checked;
        settings.scnew = csnew.checked;
        settings.scremove = csremove.checked;
        settings.scremind = csremind.checked;
        settings.scbackup = csbackup.checked;
    }
}
