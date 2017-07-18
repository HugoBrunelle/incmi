import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    width: 1280
    height: 720
    property real wm: 3.76
    property real hm: 3.89
    Component.onCompleted: {
        user.forceActiveFocus();
    }

    function dologin() {
        if (pass.text == settings.spass && user.text == settings.saccount) {
            load.changeComponent(wmain);
        } else
        {
            lab.text = "You have entered a wrong username or password, try again.."
            lab.font.pointSize = 12
        }
    }

    Pane {
        anchors.rightMargin: 340
        anchors.bottomMargin: 185
        anchors.leftMargin: 340
        anchors.topMargin: 185
        anchors.fill: parent
        Material.background: colordp
        Material.elevation: 50
        ColumnLayout {
            anchors.rightMargin: 60
            anchors.leftMargin: 60
            anchors.bottomMargin: 50
            anchors.topMargin: 30
            anchors.fill: parent
            Label {
                id: lab
                text: "Enter your username and password"
                font.italic: true
                Layout.maximumHeight: 120
                bottomPadding: 10
                font.pointSize: 15
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
                elide: Text.ElideRight
            }

            ColumnLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                spacing: 4
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumHeight: 132
                Rectangle {
                    height: 34
                    width: parent.width
                    Layout.maximumHeight: 34
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: user.implicitWidth
                    color: colorlt
                    radius: 6
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    antialiasing: false
                    TextInput {
                        id: user
                        x: 5
                        width: parent.width - 2*x
                        selectByMouse: true
                        text: qsTr("Username")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        KeyNavigation.tab: pass
                        Keys.priority: Keys.BeforeItem
                        Keys.onPressed: {
                            if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                                dologin();
                                event.accepted = true;
                            }
                        }

                        onActiveFocusChanged: {
                            if(user.activeFocus) {
                                if (user.text == "Username") {
                                    user.text = "";
                                }
                            }else {
                                if(user.text == "") {
                                    user.text = "Username";
                                }
                            }
                        }
                    }
                }
                Rectangle {
                    Layout.maximumHeight: 34
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.minimumWidth: pass.implicitWidth
                    height: 34
                    width: parent.width
                    color: colorlt
                    radius: 6
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                    antialiasing: false
                    TextInput {
                        id:pass
                        x: 5
                        width: parent.width - 2*x
                        text: "Password"
                        echoMode: TextInput.Password
                        selectByMouse: true
                        anchors.verticalCenter: parent.verticalCenter
                        font.pointSize: 10
                        KeyNavigation.tab: b
                        Keys.priority: Keys.BeforeItem
                        Keys.onPressed: {
                            if (event.key == Qt.Key_Enter || event.key == Qt.Key_Return) {
                                dologin();
                                event.accepted = true;
                            }
                        }
                        onActiveFocusChanged: {
                            if(pass.activeFocus) {
                                if (pass.text == "Password") {
                                    pass.text = "";
                                }
                            }else {
                                if(pass.text == "") {
                                    pass.text = "Password";
                                }
                            }
                        }
                    }
                }
                Button {
                    id: b
                    text: qsTr("Login")
                    Layout.maximumWidth: 180
                    Layout.maximumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignRight | Qt.AlignTop
                    Material.background: colorp
                    Material.foreground: colorlt
                    KeyNavigation.tab: user
                    onClicked: {
                        dologin();
                    }
                }
            }
        }
    }
}
