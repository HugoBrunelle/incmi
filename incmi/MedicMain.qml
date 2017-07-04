import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    width: 360
    height: 640

    ColumnLayout {
        id: mview
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
                anchors.fill: parent
                Image {
                    Layout.maximumWidth: 150
                    fillMode: Image.PreserveAspectFit
                    source: "Images/ucmu_100h.png"
                    Layout.minimumWidth: 100
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                }

                ColumnLayout {
                    width: 100
                    height: 100
                    Layout.maximumWidth: 500
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Button {
                        text: qsTr("Inventaire")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Material.foreground: colorlt
                        Material.background: colordp
                        onClicked: {
                            winchange(medinventory);
                        }
                    }

                    Button {
                        text: qsTr("Nouveau Dossier")
                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Material.foreground: colorlt
                        Material.background: colordp
                        onClicked: {
                            mview.enabled = false;
                            newdprompt.show();
                        }
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
                    text: qsTr("Retour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(inform);
                    }
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
            anchors.rightMargin: parent.width / 16
            anchors.leftMargin: parent.width / 16
            anchors.bottomMargin: parent.height / 8
            anchors.topMargin: parent.height / 8
            flow: GridLayout.TopToBottom
            columnSpacing: 2
            anchors.fill: parent
            Button {
                text: qsTr("Leger")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Moderer")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                     winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Sever")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    winchange(meddocrs);
                }
            }

            Button {
                text: qsTr("Annuler")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    mview.enabled = true;
                    newdprompt.hide();
                }
            }

        }
    }


}
