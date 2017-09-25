import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    property string currentInvItem
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height

    function itemDoubleClicked(obj) {
        currentInvItem = JSON.stringify(obj);
        ldview.push(ledit);
    }

    function removeInvItem(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"7"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
        ldview.push(lmain);
    }

    function editInvItem(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"6"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
        ldview.push(lmain);
    }

    function cancelInvEdit() {
        ldview.push(lmain);
    }

    function newInvItem() {
        ldview.push(lnew);
    }

    function cancelNew() {
        ldview.push(lmain);
    }

    function addInvItem(obj) {
        var message = JSON.stringify(obj);
        message = message.slice(0,-1) + ',"messageindex":"8"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
        ldview.push(lmain);
    }

    Component {
        id: lmain
        MedViewInventoryList {}
    }

    Component {
        id: ledit
        MedViewInventoryEdit {}
    }

    Component {
        id: lnew
        MedViewInventoryNew {}
    }

    Connections {
        target: window
        onDoEvents: {
            ldview.currentItem.ready();
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 0.5
        anchors.fill: parent
        StackView {
            id: ldview
            clip: true;
            Layout.fillHeight: true
            Layout.fillWidth: true
            initialItem: lmain
            onBusyChanged: {
                if (!busy) {
                    ldview.currentItem.ready();
                }
            }
        }

        Pane {
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            RowLayout {
                anchors.fill: parent
                CButton {
                    text: qsTr("Retour")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    source: "Icons/ic_backspace_white_24dp.png"
                    onClicked: {
                        winchange(medimain);
                    }
                }
                CButton {
                    text: qsTr("Inventaire")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    source: "Icons/ic_add_circle_white_24dp.png"
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(adjinv);
                    }
                }
            }
        }
    }

}
