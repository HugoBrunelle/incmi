import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property alias invback: cancel
    property alias invadjust: ajusInventaire
    width: 360
    height: 640

    ColumnLayout {
        id: columnLayout
        spacing: 8
        anchors.fill: parent

        Pane {
            id: pane
            width: 360
            height: 100
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.elevation: 4
            Material.background: colorp
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
                        id: ajusInventaire
                        text: qsTr("+ Inventaire")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Material.foreground: colorlt
                        Material.background: colora
                    }
                }
            }
        }

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
            model: MedInvViewModel {}
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

}
