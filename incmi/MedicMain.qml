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
    property string bmodel
    Material.accent: colora

    Connections {
        id: c
        target: window
        onDoEvents: {
            medsocket.active = true;
        }
    }

    function setModel() {
        var md = JSON.parse(bmodel);
        for (var i = 0; i < md.items.length; i++) {
            var item = JSON.parse(md.items[i]);
            mod.append(item);
        }
    }

    function checkChanged() {
        mod.clear();
        setModel();
        if (!cdocs.checked){
            for (var b = mod.count; b > 0; b--){
                var objb = mod.get(b - 1);
                if (objb.type == "docs"){
                    mod.remove(b-1);
                }
            }
        }
        if (!cinv.checked){
            for (var c = mod.count; c > 0; c--){
                var obj = mod.get(c - 1);
                if (obj.type == "inv"){
                    mod.remove(c-1);
                }
            }
        }
    }

    BaseSocket {
        id: medsocket
        host: settings.host
        port: settings.port
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                medsocket.sendTextMessage('{"messageindex":"1"}');
                break;
            }
        }
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            bmodel = message;
            for (var i = 0; i < obj.items.length; i++) {
                var item = JSON.parse(obj.items[i]);
                mod.append(item);
            }
            medsocket.active = false;
        }
    }
    Pane {
        id: header
        height: 110
        width: parent.width + 10
        x: - 5
        Material.elevation: 2
        Material.background: colordp
        GridLayout {
            anchors.fill: parent
            Image {
                Layout.maximumWidth: 150
                fillMode: Image.PreserveAspectFit
                source: "Images/ucmu_100h.png"
                Layout.minimumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }

            ColumnLayout {
                width: 100
                height: 100
                Layout.maximumWidth: 300
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                spacing: 0
                CButton {
                    text: qsTr("Inventaire")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    source: "Icons/ic_list_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.elevation: 1
                    onClicked: {
                        winchange(medinventory);
                    }
                }

                CButton {
                    text: qsTr("Nouveau Dossier")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    source: "Icons/ic_line_style_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.elevation: 1
                    onClicked: {
                        mview.enabled = false;
                        newdprompt.show();
                    }
                }
            }

        }
    }



    ColumnLayout {
        id: mview
        y: header.height + pad
        width: parent.width
        height: parent.height - header.height - pad
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
            header: MediViewHeader {}
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: MediViewDelegate {}
            model: ListModel {id: mod}
            add: Transition { NumberAnimation { properties: "x"; from: width; duration: 300; easing.type: Easing.OutQuad }}
        }

        Item {
            Layout.minimumHeight: checkiheight
            Layout.maximumHeight: checkiheight
            Layout.fillHeight: true;
            Layout.fillWidth: true;
            Rectangle {
                anchors.fill: parent
                anchors.margins: 3
                border.color: "grey"
                border.width: 1
                CheckBox {
                    id: cdocs
                    height: parent.height
                    width: implicitWidth
                    x: parent.width - pad - width
                    checked: true
                    text: "Docs"
                    onCheckedChanged: {
                        checkChanged();
                    }
                }

                CheckBox {
                    id: cinv
                    height: parent.height
                    width: implicitWidth
                    x: cdocs.x - width - 2*pad
                    checked: true
                    text: "Inv"
                    onCheckedChanged: {
                        checkChanged();
                    }

                }
            }
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
            GridLayout {
                anchors.fill: parent
                CButton {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
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
            }
        }
    }

    Prompt {
        id: newdprompt
        Material.background: colora
        Material.elevation: 10
        x: parent.width / 12
        y: parent.height / 7
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        GridLayout {
            anchors.rightMargin: parent.width / 16
            anchors.leftMargin: parent.width / 16
            anchors.bottomMargin: parent.height / 6.5
            anchors.topMargin: parent.height / 6.5
            flow: GridLayout.TopToBottom
            columnSpacing: 2
            anchors.fill: parent
            Button {
                text: qsTr("Leger")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    naturedoc = "1";
                    winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Moderer")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                     naturedoc = "2";
                     winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Annuler")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colorp
                onClicked: {
                    mview.enabled = true;
                    newdprompt.hide();
                }
            }

        }
    }


}
