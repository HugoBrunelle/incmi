import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    height: parent.height
    width: parent.width
    property int pad: 5

    function ready() {
        memberssocket.active = true;
    }

    function checkChanged(condition, obj) {
        switch (condition) {
        case true:
            checkedobjects.push(JSON.stringify(obj));
            checkRemove();
            break;
        case false:
            for (var i = checkedobjects.length -1; i > 0; i--){
                var ot = JSON.parse(checkedobjects[i]);
                if (ot.filename == obj.filename) {
                    checkedobjects.splice(i,1);
                }
            }
            checkRemove();
            break;
        }
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: memberssocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var t = obj.items[i];
                mod.append(obj.items[i]);
            }
            memberssocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                memberssocket.sendTextMessage('{"messageindex": "5"}');
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }


    ListView {
        clip: true
        interactive: true
        spacing: 1
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - buttonfooter.height
        model: ListModel { id: mod}
        delegate: PeopleListDelegate {}
    }

    Item {
        id: buttonfooter
        x: pad
        y: parent.height - buttonfooter.height - pad
        height: 70
        width: parent.width - 2*pad

        Button {
            id: rem
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: implicitWidth
            x: parent.width - width - 2*pad
            text: "Remove"
            enabled: hasselection
            Material.background: colorp
            Material.foreground: colorlt
            onClicked: {
                for (var i = 0; i < checkedobjects.length; i++){
                    var obj = JSON.parse(checkedobjects[i]);
                    for (var b = mod.count - 1; b > -1; b--) {
                        if (mod.get(b).filename == obj.filename) {
                            mod.remove(b);
                        }
                    }
                }
                removeObjects();
            }
        }

        Button {
            id: add
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: implicitWidth
            x: rem.x - width - 2*pad
            text: "Add Person"
            Material.foreground: colorlt
            Material.background: colorp
            onClicked: {
                newPerson();
            }
        }

        Label {
            y: parent.height - implicitHeight - pad
            width: implicitWidth
            x: pad
            text: "To edit a person, double click the item"
            font.pointSize: 8
            font.italic: true
            verticalAlignment: Text.AlignVCenter
        }
    }

}
