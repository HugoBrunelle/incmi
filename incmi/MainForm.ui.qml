import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3




BackgroundBase {    
    id: cmain
    Material.background: colorlp
    property alias ubase: utilisateurbase
    property alias uadmin: administrateur
    property alias rpassword: acodebox
    property alias submitbut: subbut
    property alias ll: columnLayout
    property alias form: cmain

    visible: true

    ColumnLayout {
        id: columnLayout
        anchors.rightMargin: parent.width / 8
        anchors.leftMargin: parent.width / 8
        anchors.bottomMargin: parent.height / 5.5
        anchors.topMargin: parent.height / 5.5
        anchors.fill: parent
        spacing: 15

        Button {
            id: utilisateurbase
            y: 160
            height: 59
            text: qsTr("Utilisateur de Base")
            font.family: "Arial"
            font.pointSize: 16
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.foreground: colorlt
            Material.background: colora
        }

        Button {
            id: administrateur
            height: 60
            text: qsTr("Administrateur")
            Layout.minimumHeight: 0
            font.pointSize: 16
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.foreground: colorlt
            Material.background: colora
        }

    }

    Prompt {
        id: acodebox
        x: parent.width / 10
        y: parent.height / 4.5
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: Material.Amber
        //border.color: colorb
        //border.width: 1
        Material.elevation: 8
        ColumnLayout {
            id: columnLayout1
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            anchors.bottomMargin: 10
            anchors.fill: parent
            spacing: 5

            Label {
                id: label
                text: qsTr("Enter Access Code")
                fontSizeMode: Text.Fit
                Layout.fillHeight: true
                font.pointSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            TextField {
                id: textField
                text: qsTr("")
                Layout.maximumHeight: 60
                font.pointSize: 20
                Material.foreground: colorst
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.columnSpan: 1
                Layout.rowSpan: 0
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            Button {
                id: subbut
                text: qsTr("Soumettre")
                Layout.maximumHeight: 100
                Layout.minimumHeight: 50
                font.pointSize: 24
                Material.foreground: colorlt
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Material.background: colordp
            }
        }
    }

}


