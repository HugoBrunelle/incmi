import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Item {
    height: parent.height
    width: parent.width
    property int spad: 8
    property int ffont: 12
    property int pad: 5
    property int textboxheight: 30
    property string selectedmember: ""
    property string members: ""
    Material.accent: colora

    function ready() {
        selectedmember = settings.user
        settingssocket.active = true;
    }

    function checkChanged(condition, obj) {
        if (condition) {
            if (selectedmember == JSON.stringify(obj)) return;
            selectedmember = JSON.stringify(obj);
        }else {
            selectedmember = "";
        }
        setData();
    }

    function setData() {
        if (members != "") {
            mod.clear();
            var obj = JSON.parse(members);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                var sign = "false";
                console.log(selectedmember);
                if (selectedmember != ""){
                    var c = JSON.parse(selectedmember)
                    if (c.filename === t.filename) {
                        sign = "true";
                    }
                }
                if (t.isadmin){
                    if (settings.isadmin) mod.append(JSON.parse(JSON.stringify(t).slice(0,-1) + ',"ccheck":'+sign+'}'));
                }else {
                    mod.append(JSON.parse(JSON.stringify(t).slice(0,-1) + ',"ccheck":'+sign+'}'));
                }
            }
        }
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: settingssocket
        onTextMessageReceived: {
            mod.clear();
            var obj = JSON.parse(message);
            console.log(message);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                var sign = "false";
                console.log(selectedmember);
                if (selectedmember != ""){
                    var c = JSON.parse(selectedmember)
                    if (c.filename === t.filename) {
                        sign = "true";
                    }
                }
                if (t.isadmin){
                    if (settings.isadmin) mod.append(JSON.parse(JSON.stringify(t).slice(0,-1) + ',"ccheck":'+sign+'}'));
                }else {
                    mod.append(JSON.parse(JSON.stringify(t).slice(0,-1) + ',"ccheck":'+sign+'}'));
                }
            }
            members = message;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                settingssocket.sendTextMessage('{"messageindex": "5"}');
                break;
            case WebSocket.Error:
                console.log("Error");
                settingssocket.active = false;
                break;
            }
        }
    }

    Rectangle {
        id: body
        x: 0
        y: 0
        width: parent.width
        height: parent.height - footer.height

        Item {
            id: i1
            x: 0
            y: 0
            height:137
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: spad
                border.color: "grey"
                border.width: 1
                Item {
                    anchors.fill: parent
                    anchors.margins: pad
                    Label {
                        id: lb
                        y: pad
                        x: pad
                        text: "Host : "
                        verticalAlignment: Text.AlignVCenter
                        height: r1.height
                    }
                    Rectangle {
                        id: r1
                        x: lb.x + lb.width + pad
                        y: pad
                        width: parent.width - 3*pad - lb.width
                        height: textboxheight
                        color: "white"
                        border.color: "grey"
                        border.width: 1
                        radius: 3
                        TextInput {
                            selectByMouse: true
                            anchors.fill: parent
                            anchors.margins: 3
                            anchors.leftMargin: 15
                            verticalAlignment: Text.AlignVCenter
                            text: settings.host
                            onTextChanged: {
                                settings.host = text;
                            }
                        }
                    }
                    Label {
                        y: r2.y
                        x: pad
                        text: "Port : "
                        verticalAlignment: Text.AlignVCenter
                        height: r1.height
                    }
                    Rectangle {
                        id: r2
                        x: lb.x + lb.width + pad
                        y: pad + r1.height + r1.y
                        width: parent.width - 3*pad - lb.width
                        height: textboxheight
                        color: "white"
                        border.color: "grey"
                        border.width: 1
                        radius: 3
                        TextInput {
                            selectByMouse: true
                            anchors.fill: parent
                            anchors.margins: 3
                            anchors.leftMargin: 15
                            verticalAlignment: Text.AlignVCenter
                            text: settings.port
                            onTextChanged: {
                                settings.port = text;
                            }
                        }
                    }
                    Button {
                        width: implicitWidth
                        x: parent.width - pad - width
                        y: parent.height - textboxheight - 2*pad
                        height: textboxheight + 15
                        Material.background: colordp
                        Material.foreground: colorlt
                        text: "Configure Access"
                        onClicked: {
                            pressedConfigureAccess();
                        }
                    }
                }
            }
        }

        Item {
            id: i2
            x: 0
            y: i1.height
            height: parent.height - i1.height
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: spad
                color: "white"
                border.color: "grey"
                border.width: 1

                ListView {
                    anchors.fill: parent
                    anchors.margins: 5
                    clip: true
                    interactive: true
                    spacing: 1
                    model: ListModel { id: mod}
                    delegate: MemberListDelegate {}
                }

            }
        }
    }


    Rectangle {
        id: footer
        width: parent.width
        y: body.height
        height: 50
        CButton {
            id: confb
            text: qsTr("Confirmer");
            width: implicitWidth + 15
            x: parent.width - width - 10
            height: parent.height - 6
            source: "Icons/ic_play_for_work_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {
                confirmSettings(selectedmember);
            }
        }

        CButton {
            text: qsTr("Conf. Serveur");
            width: implicitWidth + 15
            x: confb.x - width - 2*pad
            height: parent.height - 6
            source: "Icons/ic_play_for_work_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            visible: settings.isadmin
            onClicked: {
                serverSettings();
            }
        }
    }
}
