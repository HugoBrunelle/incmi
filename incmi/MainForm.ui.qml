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
    property int sy: acodebox.y

    visible: true

    ColumnLayout {
        id: columnLayout
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        anchors.bottomMargin: 120
        anchors.topMargin: 120
        anchors.fill: parent
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        spacing: 15

        Button {
            id: utilisateurbase
            y: 160
            height: 59
            text: qsTr("Utilisateur de Base")
            font.family: "Arial"
            font.pointSize: 26 * fontscale
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.foreground: colorlt
            Material.background: colorp
        }

        Button {
            id: administrateur
            height: 60
            text: qsTr("Administrateur")
            Layout.minimumHeight: 0
            font.pointSize: 26 * fontscale
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.foreground: colorlt
            Material.background: colora
        }

    }

    Prompt {
        id: acodebox
        x: 100
        y: 250
        color: colorlp
        anchors.topMargin: 140
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 140
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
        border.color: colorb
        border.width: 1
        Material.elevation: 40
        anchors.rightMargin: 40
        anchors.leftMargin: 40
        ColumnLayout {
            id: columnLayout1
            anchors.rightMargin: 20
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            anchors.topMargin: 20
            anchors.fill: parent
            spacing: 15

            Label {
                id: label
                text: qsTr("Enter Access Code")
                Layout.fillHeight: true
                font.pointSize: 27 * fontscale
                bottomPadding: 15
                topPadding: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            TextField {
                id: textField
                height: 60
                text: qsTr("")
                Layout.maximumHeight: 150
                font.pointSize: 36 * fontscale
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
                Layout.maximumHeight: 65535
                font.pointSize: 24 * fontscale
                Material.foreground: colorlt
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Material.background: colordp
            }
        }
    }

}


