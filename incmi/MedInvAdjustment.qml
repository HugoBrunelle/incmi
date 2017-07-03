import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property alias adjcancel: cancel
    property alias adjsave: save
    width: 360
    height: 640

    ColumnLayout {
        id: columnLayout
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
            model: AdjViewModel {}
        }



        Pane {
            id: pane
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
                id: gridLayout
                anchors.fill: parent

                Button {
                    id: cancel
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                }
                Button {
                    id: save
                    text: qsTr("Sauvegarder")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: colordp
                }
            }
        }
    }
}
