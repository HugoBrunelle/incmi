import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: 360
    height: 640

    function save(){
        var tsend = JSON.parse('{"messageindex":"4","matricule":"","type":"inv","name":"","filename":"","items":[]}');
        for (var i = 0; i < mod.count; i++) {
            var item = mod.get(i);
            if (parseInt(item.change) != 0) {
                console.log("Adding item to send changes..");
                var temp = JSON.parse('{"count":"","tag":""}');
                temp.tag = item.tag;
                temp.count = (parseInt(item.count) + parseInt(item.change)).toString();
                tsend.items.push(JSON.stringify(temp));
            }
        }
        tsend.name = name.text;
        tsend.matricule = tfieldMatricule.text;
        mess.push(JSON.stringify(tsend));
        settings.messages = mess;
        sendSavedInformation();

    }

    BaseSocket {
        id: adjsocket
        onTextMessageReceived: {
            var obj = JSON.parse(message);
            if (obj.messageindex == "0"){
                //Correct object..
                for (var i = 0; i < obj.items.length; i++) {
                    var item = obj.items[i];
                    mod.append(JSON.parse('{"name":"'+item.name+'","count":"'+item.count+'","change":"0","tag":"'+item.tag+'"}'));
                }
            }
            adjsocket.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                adjsocket.sendTextMessage('{"messageindex": "0"}');
                break;
            }
        }
    }
    Component.onCompleted: {
        adjsocket.active = true;
    }

    ColumnLayout {
        id: mview
        spacing: 0
        anchors.fill: parent
        ListView {
            clip: true
            id: invListView
            x: 0
            y: 0
            width: 110
            height: 160
            orientation: ListView.Vertical
            flickableDirection: Flickable.VerticalFlick
            spacing: 3
            Layout.fillHeight: true
            Layout.fillWidth: true
            delegate: AdjViewDelegate {}
            model: AdjViewModel {id: mod}
            add: Transition { NumberAnimation { properties: "x,y"; from: width; duration: 300; easing.type: Easing.OutQuad }}
        }



        Pane {
            id: pane
            width: 360
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                id: gridLayout
                anchors.fill: parent
                Button {
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmleave.show();
                    }
                }
                Button {
                    text: qsTr("Sauvegarder")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmsave.show();
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmsave
        x: parent.width / 10
        y: parent.height / 4.5
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            RowLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumHeight: 50
                spacing: 2.0
                Label {
                    text: qsTr("Nom:")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pointSize: 12
                    Material.foreground: colorlt
                }
                // Replace with a combobox populated by the matricule
                Rectangle {
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumHeight: tfieldMatricule.implicitHeight + 15
                    Layout.maximumWidth: trectmatricule.width
                    Layout.minimumWidth: trectmatricule.width
                    color: "white"
                    radius:3
                TextInput {
                    id: name
                    text: qsTr("")
                    anchors.fill: parent
                    anchors.leftMargin: 10
                    anchors.margins: 2
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                }
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 50
                spacing: 2.0
                Label {
                    text: qsTr("Matricule:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillHeight: true
                    font.pointSize: 12
                    rightPadding: 15
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Material.foreground: colorlt
                }
                Rectangle {
                    id: trectmatricule
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.maximumHeight: tfieldMatricule.implicitHeight + 15
                    Layout.fillWidth: true
                    color: "white"
                    radius:3
                TextInput {
                    id: tfieldMatricule
                    text: qsTr("")
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: 12
                }
                }
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmsave.hide();
                    }
                }
                Button {
                    text: qsTr("Soumettre")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        save();
                        winchange(medinventory);
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmleave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
                Label {
                    text: qsTr("Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer..")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Material.foreground: colorlt
                    wrapMode: Text.WordWrap
                    Layout.maximumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: 14
                }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 80
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmleave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        winchange(medinventory);
                    }
                }
            }
        }
    }
}
