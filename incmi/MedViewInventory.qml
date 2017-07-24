import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: 360
    height: 640
    BaseSocket {
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

    ColumnLayout {
        id: columnLayout
        spacing: 8
        anchors.fill: parent
        ListView {
            clip: true
            id: invListView
            x: 0
            y: 0
            headerPositioning: ListView.PullBackHeader
            width: 110
            height: 160
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            header: MedInvViewHeader {}
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: MedInvViewDelegate {}
            model: MedInvViewModel { id: mod}
            add: Transition { NumberAnimation { properties: "x,y"; from: width; duration: 300; easing.type: Easing.OutQuad }}
            Component.onCompleted: {
                invsocket.active = true;
            }
        }

        Pane {
            width: 360
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                anchors.fill: parent
                Button {
                    text: qsTr("Retour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(medimain);
                    }
                }
                Button {
                    text: qsTr("+ Inventaire")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(adjinv);
                    }
                }
            }
        }
    }

}
