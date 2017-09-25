import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: parent.height

    function ready() {
    }
    ColumnLayout {
        id: mview
        anchors.rightMargin: parent.width / 8
        anchors.leftMargin: parent.width / 8
        anchors.bottomMargin: parent.height / 5.5
        anchors.topMargin: parent.height / 5.5
        anchors.fill: parent
        spacing: 5

        CButton {
            text: qsTr("Intervenant")
            font.family: "Arial"
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.foreground: colorlt
            Material.background: colordp
            source: "Icons/ic_account_box_white_24dp.png"
            onClicked: {
                pressedIntervenant();
            }
        }

        CButton {
            text: qsTr("Administrateur")
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.foreground: colorlt
            Material.background: colordp
            source: "Icons/ic_supervisor_account_white_24dp.png"
            onClicked: {
                mview.enabled = false;
                acodebox.show();
            }
        }

    }





    Prompt {
        id: acodebox
        x: parent.width / 10
        y: parent.height / 4
        width: parent.width * 8 / 10
        height: parent.height / 2
        Behavior on x {
            SequentialAnimation {
                NumberAnimation {
                    duration: 80
                }
                ScriptAction {
                    script: {
                        acodebox.x = Qt.binding(function () {return parent.width/10});
                    }
                }
            }
        }
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                mview.enabled = true;
                acodebox.hide();
            }
        }

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
                id: ld
                text: qsTr("Enter Access Code \n double click to cancel")
                fontSizeMode: Text.Fit
                Layout.fillHeight: true
                Layout.fillWidth: true
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
                    if (tfieldMatricule.text == "incmi2017ar"){
                        mview.enabled = true;
                        acodebox.hide();
                        pressedAdministrateursConfirmed();
                    }else {
                        acodebox.x = parent.width / 2.5
                        ld.text = "Please try again \n double click to cancel"
                    }
                }
            }
        }
    }
}
