import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebSockets 1.1
import QtQuick.Controls.Material 2.2

Rectangle {
    property int pad: 5
    property int buttonheight: 35
    property int headerheight: 40
    anchors.fill: parent

    Component.onCompleted: {
        peoplesocket.active = true;
    }

    function checkChanged(condition, obj) {
        var tt = JSON.stringify(obj);
        switch (condition) {
        case true:
            var exists = false;
            for (var i = 0; i < people.length; i++) {
                if (tt == people[i]) exists = true;
            }
            if (!exists) {
                people.push(tt);
            }
            break;
        case false:
            for (var b = people.length; b > 0; b--) {
                if (tt == people[b - 1]) people.splice(b-1,1);
            }
            break;
        }
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: peoplesocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                mod.append(JSON.parse(JSON.stringify(t).slice(0,-1) + ',"ccheck":false}'));
            }
            peoplesocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                peoplesocket.sendTextMessage('{"messageindex": "5"}');
                break;
            case WebSocket.Error:
                peoplesocket.active = false;
                break;
            }
        }
    }


    Item {
        id: header
        width: parent.width
        height: headerheight

        Pane {
            y: pad / 2
            height: parent.height - pad
            width: parent.width - 2*pad
            x: pad
            Material.elevation: 2
            Material.background: colordp
            Label {
                Material.foreground: colorlt
                text: qsTr("Benevoles sur les lieu")
                x: 3*pad
                width: parent.width - 3*pad
                height: implicitHeight
                y: (parent.height - height) / 2
            }
        }
    }

    Item {
        id: body
        height: parent.height - headerheight
        width: parent.width
        y: header.height
        Rectangle {
            anchors.fill: parent
            anchors.margins: pad
            border.width: 1
            border.color: "grey"
        ListView {
            anchors.fill: parent
            anchors.margins: pad
            model: ListModel { id: mod }
            delegate: MemberListDelegate {}
            interactive: true;
            clip: true;
            spacing: 1
        }
        }
    }
}
