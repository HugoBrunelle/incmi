import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1

Item {
    width: parent.width
    height: parent.height
    property int nrectheight: 45
    property int pad: 5

    function ready() {
        invsocket.active = true;
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: invsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            if (obj.messageindex == "0"){
                //Correct object..
                for (var i = 0; i < obj.items.length; i++) {
                    var item = obj.items[i];
                    mod.append(item);
                }
                invsocket.active = false;
            }

        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                invsocket.sendTextMessage('{"messageindex": "0"}');
                break;
            }

        }
    }

    ListView {
        clip: true
        id: invListView
        x: 0
        y: 0
        width: parent.width
        height: settings.isadmin ? parent.height - nrectheight : parent.height
        headerPositioning: ListView.PullBackHeader
        orientation: ListView.Vertical
        flickableDirection: Flickable.VerticalFlick
        header: MedInvViewHeader {}
        spacing: 3
        delegate: MedInvViewDelegate {}
        model: MedInvViewModel { id: mod}
        add: Transition { NumberAnimation { properties: "x"; from: width; duration: 250; easing.type: Easing.OutQuad }}
    }
    Item {
        height: nrectheight
        width: parent.width
        y: parent.height - nrectheight
        visible: settings.isadmin
        Rectangle {
            anchors.fill: parent
            anchors.margins: 3
            border.color: "grey"
            border.width: 1
            CButton {
                id: nb
                width: implicitWidth + 30
                height: parent.height
                x: parent.width - width - pad
                text: "Ajouter"
                source: "Icons/ic_forward_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                onClicked: {
                    newInvItem();
                }
            }
            CButton {
                width: implicitWidth + 30
                height: parent.height
                x: nb.x - width - pad
                text: "Doc. Inventaire"
                source: "Icons/ic_forward_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                onClicked: {
                    getDocImage("","invtot");
                }
            }
        }
    }
}
