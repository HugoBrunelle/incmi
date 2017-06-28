import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

Rectangle {
    property alias incbutton: incendie
    property alias medbutton: medical
    width: 360
    height: 640

    RowLayout {
        id: rowLayout
        anchors.bottomMargin: parent.height / 4.5
        anchors.rightMargin: parent.width / 12
        anchors.leftMargin: parent.width / 12
        anchors.topMargin: parent.height / 4.5
        spacing: 5
        anchors.fill: parent

        Button {
            Material.foreground: "white"
            Material.background: colora
            id: incendie
            font.pointSize: 18*fontscale
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "Incendie"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Button {
            Material.foreground: "white"
            Material.background: colora
            id: medical
            text: "Medical"
            font.pointSize: 18 * fontscale
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
