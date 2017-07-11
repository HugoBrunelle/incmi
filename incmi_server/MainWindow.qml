import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    width: 1280
    height: 720


    function logmess(message){
        log.child.logconsole.append(message);
    }

    Pane {
        id:header
        width: parent.width
        height: (parent.height/32)*5
        Material.background: colorp
        Material.elevation: 4
        GridLayout {
            anchors.rightMargin: parent.width / 5
            anchors.leftMargin: parent.width / 5
            anchors.fill: parent
            Image {
                Layout.maximumWidth: 200
                fillMode: Image.PreserveAspectFit
                Layout.minimumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }
            Label {
                text: "IncMi Server"
                font.pointSize: 30
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Material.foreground: colorlt

            }

            Image {
                Layout.maximumWidth: 200
                fillMode: Image.PreserveAspectFit
                Layout.minimumWidth: 100
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            }


        }

    }
    Rectangle{
        id: loadrec
        y: header.height + 8
        width: parent.width
        height: (parent.height/32)*22
        StackView {
            id: ld
            anchors.fill: parent
            initialItem: log
        }
    }


    Pane {
        y: loadrec.height + loadrec.y - 8
        width: parent.width
        height: ((parent.height/32)*5)
        Material.background: "#0288D1"
        Material.elevation: 4
        RowLayout {
            id: frlayout
            spacing: 0
            anchors.fill: parent
            Item {
                Layout.minimumWidth: frlayout.width/2
                Layout.maximumWidth: frlayout.width/2
                Layout.fillHeight: true
                Layout.fillWidth: true
                RowLayout{
                    anchors.fill: parent
                    ColumnLayout {
                        Layout.minimumWidth: 150
                        spacing: 0
                        Layout.maximumWidth: 150
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Button {
                            text: qsTr("Start")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            enabled: !senabled
                            Material.foreground: colorlt
                            Material.background: colordp
                            onClicked: {

                            }
                        }
                        Button {
                            text: qsTr("Stop")
                            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            enabled: senabled
                            Material.foreground: colorlt
                            Material.background: colordp
                            onClicked: {

                            }
                        }
                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label {
                            x: 15
                            y: 5
                            id: stlab
                            text: "Server status"
                            font.pointSize: 16
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }

                        Label
                        {
                            y: stlab.implicitHeight + stlab.y + 3
                            x: 30
                            id: statuslabel
                            text: "-- Disabled"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }


                    }
                    Item {
                        Layout.fillHeight: true
                        Layout.fillWidth: true
                        Label {
                            x: 15
                            y: 10
                            id: stip
                            text: "IP: "
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }

                        Label
                        {
                            y: stip.implicitHeight + stip.y + 3
                            x: 15
                            id: stport
                            text: "Port: "
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            Material.foreground: colorlt
                        }


                    }
                }
            }
            Item {
                Layout.maximumWidth: (frlayout.width*3)/8
                Layout.minimumWidth: (frlayout.width*3)/8
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                TabBar {
                    id: tabBar
                    width: parent.width
                    height: parent.height
                    currentIndex: 0
                    contentWidth: parent.width /3
                    contentHeight: parent.height
                    anchors.fill: parent
                    Material.accent: colorlt
                    TabButton {
                        text: qsTr("Log")
                        Material.foreground: "white"
                    }
                    TabButton {
                        text: qsTr("Inventory")
                        Material.foreground: "white"
                    }
                    TabButton {
                        text: qsTr("Documents")
                        Material.foreground: "white"
                    }
                    onCurrentIndexChanged: {
                        switch(tabBar.currentIndex){
                        case 0:
                            ld.push(log);
                            break;
                        case 1:
                            ld.push(inv);
                            break;
                        case 2:
                            ld.push(doc);
                            break;
                        }
                    }
                }

            }
            Item {
                Layout.maximumWidth: (frlayout.width)/8
                Layout.minimumWidth: (frlayout.width)/8
                Layout.fillHeight: true
                Layout.fillWidth: true

                Button {
                    id: obutton
                    x: 15
                    y: parent.height - obutton.height - 5
                    width: parent.width - 30
                    text: qsTr("Options")
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        load.enabled = false;
                        options.show();
                    }
                }

            }
        }
    }

    Component {
        id: log
        LogView { id: lview }
    }
    Component {
        id: inv
        InventoryView {id: linv}
    }
    Component {
        id: doc
        DocumentsView {id: ldoc}
    }








}
