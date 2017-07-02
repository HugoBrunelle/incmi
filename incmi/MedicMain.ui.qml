import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {

    property alias back: cancel
    property alias inv: inventaire
    property alias ndossier: nouveaudossier
    property alias ndprompt: newdprompt
    property alias bleger: blegers
    property alias bmoderer: bmoderers
    property alias bsever: bsevers
    property alias medimainll: columnLayout
    width: 360
    height: 640

    ColumnLayout {
        id: columnLayout
        spacing: 6
        anchors.fill: parent

        Pane {
            width: 360
            height: 140
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 140
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.background: colorp
            Material.elevation: 4
            GridLayout {
                id: gridLayout
                anchors.fill: parent

                Image {
                    Layout.minimumWidth: 100
                    Layout.maximumWidth: 250
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter

                }

                ColumnLayout {
                    id: actionslayout
                    width: 100
                    height: 100
                    Layout.maximumWidth: 500
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    Button {
                        id: inventaire
                        text: qsTr("Inventaire")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Material.foreground: colorlt
                        Material.background: colordp
                    }

                    Button {
                        id: nouveaudossier
                        text: qsTr("Nouveau Dossier")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Material.foreground: colorlt
                        Material.background: colordp
                    }
                }

            }
        }

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
            model: MediViewModel {}
        }
        Pane {
            width: 360
            height: 80
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 80
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            Material.elevation: 4
            GridLayout {
                anchors.fill: parent
                Button {
                    id: cancel
                    text: qsTr("Retour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                }
            }
        }
    }

    Prompt {
        id: newdprompt
        Material.background: Material.Amber
        Material.elevation: 10
        x: parent.width / 12
        y: parent.height / 7
        width: parent.width - 2*x
        height: parent.height - 2*y
        GridLayout {
            anchors.rightMargin: parent.width / 8
            anchors.leftMargin: parent.width / 8
            anchors.bottomMargin: parent.height / 6
            anchors.topMargin: parent.height / 6
            flow: landscape ? GridLayout.LeftToRight : GridLayout.TopToBottom
            anchors.fill: parent
            Button {
                id: blegers
                text: qsTr("Leger")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
            }

            Button {
                id: bmoderers
                text: qsTr("Moderer")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
            }

            Button {
                id: bsevers
                text: qsTr("Sever")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
            }

        }
    }


}
