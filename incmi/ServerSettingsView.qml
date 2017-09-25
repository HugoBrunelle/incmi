import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    width: parent.width
    height: parent.height
    Material.accent: colora
    property int xd: 3
    property int pad: 5
    property int textboxheight: 30
    property int footerheight: 55
    property bool hasselection: false
    property bool isnew: false
    property var currentobj
    property var checkedobjects: []

    function ready() {
        setsocket.active = true;
        ld.currentItem.ready();
    }

    function newPerson() {
        isnew = true;
        ld.push(peditor);
    }

    function seeList() {
        clearObjects();
        ld.push(plist);
    }

    function editPerson(jobj) {
        currentobj = jobj
        isnew = false;
        ld.push(peditor);
    }
    function checkRemove() {
        if (checkedobjects.length > 0){
            hasselection = true;
        }else {
            hasselection = false;
        }
    }

    function removeObjects() {
        removePeople();
        checkedobjects = [];
        checkRemove();
    }

    function clearObjects() {
        checkedobjects = [];
        checkRemove();
    }

    function removePeople() {
        var message = JSON.parse('{"messageindex":"15", "items":[]}');
        for (var i = 0; i < checkedobjects.length; i++) {
            message.items.push(checkedobjects[i]);
        }
        mess.push(JSON.stringify(message));
        settings.messages = mess;
        sendSavedInformation();
    }

    function editPeople(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"16"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function addPerson(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"17"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function saveSettings() {
        var message = JSON.parse(serversettingsbase);
        message.sport = port.text;
        message.shost = host.text;
        message.saccount = acc.text;
        message.spass = pass.text;
        message.smpush = mcount.text;
        message.semaccount = eaccount.text;
        message.sempassword = epassword.text;
        message.scnew = csnew.checked;
        message.scedit = csedit.checked;
        message.scremind = csremind.checked;
        message.scadmincommit = csadmincommit.checked;
        message.scremove = csremove.checked;
        message.scbackup = csbackup.checked;
        message = JSON.stringify(message).slice(0,-1) + ',"messageindex":"18"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: setsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            port.text = obj.sport;
            host.text = obj.shost;
            acc.text = obj.saccount;
            pass.text = obj.spass;
            mcount.text = obj.smpush;
            eaccount.text = obj.semaccount;
            epassword.text = obj.sempassword;
            csnew.checked = obj.scnew;
            csedit.checked = obj.scedit;
            csremove.checked = obj.scremove;
            csremind.checked = obj.scremind;
            csadmincommit.checked = obj.scadmincommit;
            csbackup.checked = obj.scbackup;
            setsocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                setsocket.sendTextMessage('{"messageindex": "19"}');
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }

    Flickable {
        id: body
        width: parent.width
        height: parent.height - footer.height
        contentWidth: parent.width
        contentHeight: prect.height + prect.y + 2*pad
        clip: true

        Pane {
            id: title
            x: pad
            y: pad
            width: parent.width - 2*pad
            height: textboxheight
            Material.background: colordp
            Material.elevation: 2
            Label {
                x: pad * 5
                text: "Account and Password Settings"
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
            height: l4.y + l4.height + pad

            Item {
                x: xd
                width: parent.width - 2*x
                y: xd
                height: parent.height - 2*y
                Label {
                    id: l1
                    text: "Username:"
                    y: xd
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Label {
                    id: l2
                    x: xd
                    y: l1.height + l1.y + 2*xd
                    text: "Password:"
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Rectangle{
                    x: l3.width + l3.x + xd
                    y: l1.y
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput {
                        id: acc
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: pass
                    }
                }
                Rectangle {
                    x: l3.width + l3.x + xd
                    y: l2.y
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput{
                        id: pass
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: acc
                    }
                }
                Label {
                    id: l3
                    x: xd
                    y: l2.height + l2.y + 2*xd
                    text: "Server Email Account:"
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Rectangle{
                    y: l3.y
                    x: l3.width + l3.x + xd
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput {
                        id: eaccount
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: pass
                    }
                }
                Label {
                    id: l4
                    x: xd
                    y: l3.height + l3.y + 2*xd
                    text: "Email Password:"
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Rectangle{
                    x: l3.width + l3.x + xd
                    y: l4.y
                    width: parent.width - l3.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput {
                        id: epassword
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: pass
                    }
                }
            }
        }

        Pane {
            id: title2
            x: pad
            y: pad + page.y + page.height
            Material.background: colordp
            Material.elevation: 2
            width: parent.width - 2*pad
            height: textboxheight
            Label {
                x: pad * 5
                text: "Server Settings"
                width: parent.width - 2*x
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
            }
        }

        Item {
            id: page2
            x: xd
            y: xd + title2.y + title2.height
            width: parent.width - 2*x
            height: csbackup.height + csbackup.y + pad

            Item {
                x: xd
                width: parent.width - 2*x
                y: xd
                height: parent.height *4 / 10
                Label {
                    id: l11
                    text: "Host:"
                    y: xd
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Label {
                    id: l22
                    y: l11.height + l11.y + 2*xd
                    text: "Port:"
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Label {
                    id: l33
                    y: l22.height + l22.y + 2*xd
                    text: "Maximum docs to Sync :"
                    x: xd
                    width: implicitWidth
                    height: textboxheight
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    rightPadding: xd*3
                }
                Rectangle {
                    x: l33.width + l33.x + xd*2
                    y: l11.y
                    width: parent.width - l33.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput {
                        id: host
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: port
                    }
                }
                Rectangle{
                    x: l33.width + l33.x + xd*2
                    y: l22.y
                    width: parent.width - l33.width - 3*xd
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
                        KeyNavigation.tab: mcount
                    }
                }
                Rectangle {
                    x: l33.width + l33.x + xd*2
                    y: l33.y
                    width: parent.width - l33.width - 3*xd
                    height: textboxheight
                    color: "white"
                    border.color: "lightgrey"
                    border.width: 1
                    radius: 3
                    TextInput {
                        id: mcount
                        selectByMouse: true
                        anchors.fill: parent
                        anchors.margins: 3
                        anchors.leftMargin: 15
                        verticalAlignment: Text.AlignVCenter
                        KeyNavigation.tab: host
                    }
                }

                CheckBox {
                    id: csnew
                    y: l33.y + l33.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on new Event"
                }
                CheckBox {
                    id: csedit
                    y: csnew.y + csnew.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on event Modified"
                }
                CheckBox {
                    id: csremove
                    y: csedit.y + csedit.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify on event Cancellation"
                }
                CheckBox {
                    id: csremind
                    y: csremove.y + csremove.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Remind prior to event Date"
                }
                CheckBox {
                    id: csadmincommit
                    y: csremind.y + csremind.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Notify admins on doc Commit"
                }
                CheckBox {
                    id: csbackup
                    y: csadmincommit.y + csadmincommit.height + 2 * xd
                    x: parent.width - width- 2*xd
                    width: implicitWidth > parent.width ? parent.width - 2*xd : implicitWidth
                    height: textboxheight
                    text: "Perform automatic data backup"
                }
            }
        }

        Pane {
            id: title3
            x: pad
            y: pad + page2.height + page2.y
            width: parent.width - 2*pad
            height: textboxheight
            Material.background: colordp
            Material.elevation: 2
            Label {
                x: pad * 5
                text: "People Management"
                width: parent.width - 2*x
                height: parent.height
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
            }
        }
        Rectangle {
            id: prect
            x: pad
            width: parent.width - 2*pad
            height: 500
            y: title3.y + title3.height + pad
            border.color: "lightgrey"
            border.width: 1
            StackView {
                anchors.fill: parent
                clip: true
                id: ld
                initialItem: plist
                onBusyChanged:  {
                    if (!busy) {
                        ld.currentItem.ready();
                    }
                }
            }
        }

        Component {
            id: plist
            PeopleListSettings {}
        }

        Component {
            id: peditor
            PeopleEditorSettings {}
        }
    }

    Item {
        id: footer
        width: parent.width
        y: body.height
        height: footerheight
        Rectangle {
            anchors.fill: parent
            anchors.margins: xd
            border.width: 1
            border.color: "grey"
            CButton {
                id: confb
                text: qsTr("Savegarder");
                width: implicitWidth + 20
                x: parent.width - width - 10
                y: parent.anchors.margins
                height: parent.height - 2*parent.anchors.margins
                source: "Icons/ic_play_for_work_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {

                }
            }
        }
    }
}
