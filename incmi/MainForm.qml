import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3


Rectangle {
    width: 360
    height: 640
    Material.background: colorlp
    Material.accent: colora
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
            id: gridLayout
            anchors.fill: parent
            Image {
                fillMode: Image.PreserveAspectFit
                source: "Images/ucmu_100h.png"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 100
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
    ColumnLayout {
        id: mview
        anchors.rightMargin: parent.width / 8
        anchors.leftMargin: parent.width / 8
        anchors.bottomMargin: parent.height / 5.5
        anchors.topMargin: parent.height / 5.5 + 100
        anchors.fill: parent
        spacing: 15

        Button {
            y: 160
            height: 59
            text: qsTr("Utilisateur de Base")
            font.family: "Arial"
            font.pointSize: 16
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {

                // Set access settings
                winchange(inform);
            }
        }

        Button {
            height: 60
            text: qsTr("Administrateur")
            Layout.minimumHeight: 0
            font.pointSize: 16
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.foreground: colorlt
            Material.background: colordp
            onClicked: {
                mview.enabled = false;
                acodebox.show();
            }
        }

    }



    Prompt {
        id: acodebox
        x: parent.width / 8
        y: parent.height / 4.5
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.leftMargin: parent.width / 15
            anchors.rightMargin: parent.width / 15
            anchors.bottomMargin: parent.height / 9
            anchors.topMargin: parent.height / 9
            anchors.fill: parent
            spacing: 5

            Label {
                text: qsTr("Enter Access Code")
                fontSizeMode: Text.Fit
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 13
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Material.foreground: colorlt
            }

            Rectangle {
                id: trectmatricule
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.maximumHeight: tfieldMatricule.implicitHeight + 15
                Layout.minimumHeight: tfieldMatricule.implicitHeight
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

            Button {
                text: qsTr("Soumettre")
                Layout.maximumHeight: 50
                Material.foreground: colorlt
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Material.background: colordp
                onClicked: {
                    mview.enabled = true;
                    acodebox.hide();
                }
            }
        }
    }

}


