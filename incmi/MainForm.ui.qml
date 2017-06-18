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
            rightPadding: 0
            leftPadding: 0
            font.family: "Arial"
            font.pointSize: 26 * fontscale
            bottomPadding: padding
            topPadding: padding
            padding: 0
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
            rightPadding: 0
            leftPadding: 0
            bottomPadding: 0
            topPadding: 0
            font.pointSize: 26 * fontscale
            padding: 0
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
        visible: true
        color: colorlp
        border.color: colorb
        border.width: 2.5
        Material.elevation: 40
        anchors.rightMargin: 40
        anchors.leftMargin: 40
        anchors.bottomMargin: 150
        anchors.topMargin: 150
        anchors.fill: parent
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
                font.pointSize: 27 * fontscale
                bottomPadding: 15
                topPadding: 15
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            TextField {
                id: textField
                height: 60
                text: qsTr("")
                font.pointSize: 36 * fontscale
                Material.foreground: colorst
                bottomPadding: 0
                rightPadding: 0
                leftPadding: 0
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.columnSpan: 1
                Layout.rowSpan: 0
                topPadding: 150
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            }

            Button {
                id: subbut
                text: qsTr("Soumettre")
                font.pointSize: 24 * fontscale
                topPadding: -8
                bottomPadding: -8
                padding: 0
                leftPadding: -4
                Material.foreground: colorlt
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Material.background: colordp
            }
        }
    }

}


