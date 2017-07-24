import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

Rectangle {
    width: 360
    height: 640
    Pane {
        id: header
        width: parent.width
        height: 100
        Layout.minimumHeight: 50
        Layout.fillHeight: true
        Layout.maximumHeight: 100
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
        Material.elevation: 2
        Material.background: colordp
        GridLayout {
            anchors.fill: parent
            Image {
                fillMode: Image.PreserveAspectFit
                source: "Images/ucmu_100h.png"
                Layout.maximumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }
            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: "Incmi"
                font.pointSize: 16
                color: colorlt
                font.bold: true
            }
        }
    }

    RowLayout {
        id: rowLayout
        anchors.bottomMargin: parent.height / 4.5
        anchors.rightMargin: parent.width / 12
        anchors.leftMargin: parent.width / 12
        anchors.topMargin: (parent.height / 4.5) + 100
        spacing: 5
        anchors.fill: parent

        Button {
            Material.foreground: colorlt
            Material.background: colordp
            font.pointSize: 18
            Layout.fillHeight: true
            Layout.fillWidth: true
            text: "Incendie"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                winchange(login);
            }
        }

        Button {
            Material.foreground: colorlt
            Material.background: colordp
            text: "Medical"
            font.pointSize: 18
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                winchange(medimain);
            }
        }
    }


}
