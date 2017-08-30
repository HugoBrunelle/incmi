import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3

Item {
    height: 640
    width: 360
    property int spad: 8
    property int ffont: 12
    Rectangle {
        id: body
        x: 0
        y: 0
        width: parent.width
        height: parent.height - footer.height

        Item {
            id: i1
            x: 0
            y: 0
            height: parent.height / 4
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: spad
                color: "white"
                border.color: "grey"
                border.width: 1
                Item {
                    id: ii1
                    x: 0
                    y: spad
                    height: (parent.height / 2) - 2*spad
                    width: parent.width
                    Label {
                        id: clab1
                        x: 0
                        y: 0
                        leftPadding: spad * 2
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text: "Host:"
                        width: parent.width / 3
                    }
                    Rectangle {
                        x: clab1.width + spad
                        width: (parent.width * 2 / 3) - 2*spad
                        height: parent.height - spad
                        y: spad / 2
                        radius: 3
                        border.width: 1
                        border.color: "grey"
                        TextInput {
                            id: t1
                            font.pointSize: ffont
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.leftMargin: spad
                            text: settings.host
                            onTextChanged: {
                                settings.host = text;
                            }
                            KeyNavigation.tab: t2
                        }
                    }
                }
                Item {
                    id: ii2
                    x: 0
                    y: ii1.height + ii1.y + 2*spad
                    height: (parent.height / 2) - 2*spad
                    width: parent.width
                    Label {
                        id: clab2
                        x: 0
                        y: 0
                        leftPadding: spad * 2
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text: "Port:"
                        width: parent.width / 3
                    }
                    Rectangle {
                        x: clab2.width + spad
                        width: (parent.width * 2 / 3) - 2*spad
                        height: parent.height - spad
                        y: spad / 2
                        radius: 3
                        border.width: 1
                        border.color: "grey"
                        TextInput {
                            id: t2
                            font.pointSize: ffont
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.leftMargin: spad
                            text: settings.port
                            onTextChanged: {
                                settings.port = text;
                            }
                            KeyNavigation.tab: t3
                        }
                    }
                }
            }
        }

        Item {
            id: i2
            x: 0
            y: i1.height
            height: parent.height / 4
            width: parent.width
            Rectangle {
                anchors.fill: parent
                anchors.margins: spad
                color: "white"
                border.color: "grey"
                border.width: 1
                Item {
                    id: ii3
                    x: 0
                    y: spad
                    height: (parent.height / 2) - 2*spad
                    width: parent.width
                    Label {
                        id: clab3
                        x: 0
                        y: 0
                        leftPadding: spad * 2
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text: "Nom:"
                        width: parent.width / 3
                    }
                    Rectangle {
                        x: clab3.width + spad
                        width: (parent.width * 2 / 3) - 2*spad
                        height: parent.height - spad
                        y: spad / 2
                        radius: 3
                        border.width: 1
                        border.color: "grey"
                        TextInput {
                            id: t3
                            font.pointSize: ffont
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.leftMargin: spad
                            text: settings.name
                            onTextChanged: {
                                settings.name = text;
                            }
                            KeyNavigation.tab: t4
                        }
                    }
                }
                Item {
                    id: ii4
                    x: 0
                    y: ii3.height + ii3.y + 2*spad
                    height: (parent.height / 2) - 2*spad
                    width: parent.width
                    Label {
                        id: clab4
                        x: 0
                        y: 0
                        leftPadding: spad * 2
                        height: parent.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        text: "Matricule:"
                        width: parent.width / 3
                    }
                    Rectangle {
                        x: clab4.width + spad
                        width: (parent.width * 2 / 3) - 2*spad
                        height: parent.height - spad
                        y: spad / 2
                        radius: 3
                        border.width: 1
                        border.color: "grey"
                        TextInput {
                            id: t4
                            font.pointSize: ffont
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                            anchors.leftMargin: spad
                            text: settings.matricule
                            onTextChanged: {
                                settings.matricule = text;
                            }
                            KeyNavigation.tab: t1
                        }
                    }
                }
            }
        }
    }


    Pane {
        id: footer
        width: 360
        y: body.height
        height: 70
        Material.background: "#0288D1"
        GridLayout {
            anchors.fill: parent
            CButton {
                text: qsTr("Retour")
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.maximumWidth: 150
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "Icons/ic_backspace_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    winchange(inform);
                }
            }
        }
    }
}
