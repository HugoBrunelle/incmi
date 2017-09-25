import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int pad: 5
    property int checkiheight: 50
    Material.accent: colora

    Connections {
        target: window
        onDoEvents: {
            incsocket.active = true;
        }
    }

    BaseSocket {
        id: incsocket
        host: settings.host
        port: settings.port
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                incsocket.sendTextMessage('{"messageindex":"21"}');
                break;
            }
        }
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++) {
                var item = JSON.parse(obj.items[i]);
                mod.append(item);
            }
            incsocket.active = false;
        }
    }
    ColumnLayout {
        id: mview
        y: pad
        width: parent.width
        height: parent.height
        spacing: 0.5
        ListView {
            clip: true
            id: listView
            x: 0
            y: 0
            headerPositioning: ListView.PullBackHeader
            width: 110
            height: 160
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            header: IncendieMainHeader {}
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: IncendieMainDelegate {}
            model: ListModel {id: mod}
            add: Transition { NumberAnimation { properties: "x"; from: width; duration: 300; easing.type: Easing.OutQuad }}
        }

        Pane {
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                anchors.fill: parent
                CButton {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: implicitWidth + 50
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("Retour")
                    source: "Icons/ic_backspace_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(login);
                    }
                }

                CButton {
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: implicitWidth + 50
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    text: qsTr("Nouveau")
                    source: "Icons/ic_backspace_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(incrapdoc);
                    }
                }
            }
        }
    }
}
