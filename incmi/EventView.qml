import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtWebSockets 1.1

Rectangle {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int pad: 5
    property var currentpeople: []
    property bool editing: false;
    property string currentevent: eventitembase
    property string currenthour
    property string currentdetails
    property string currentlieu
    property string currenttag
    property string currentdate: new Date().toLocaleDateString(Qt.locale(),"dd:M:yyyy");


    function reset() {
        editing = false;
        currentevent = eventitembase;
        currentpeople = [];
        currenthour = "";
        currentdetails = "";
        currentlieu = "";
        currenttag = "";
    }

    function editEvent(obj) {
        editing = true;
        currentpeople = obj.people;
        currentevent = JSON.stringify(obj);
        currenthour = obj.hour;
        currentdetails = obj.details;
        currentlieu = obj.lieu;
        currentdate = obj.date
        currenttag = obj.tag;
        tabBar.setCurrentIndex(2);
    }

    function doneMembers(){
        ld.push(cev);
    }

    function dclicked(obj){
        ld.push(ppl);
    }

    function ddclicked(obj) {
        if (settings.isadmin) {
            editEvent(obj);
        }else {

        }
    }

    function saveEvent(obj){
        switch(editing){
        case true:
            editEventItem(obj);
            editing = false;
            break;
        case false:
            createEventItem(obj);
            break;
        }
        tabBar.setCurrentIndex(0);
    }

    function editEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"12"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function createEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"13"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function removeEventItem(obj) {
        var message = JSON.stringify(obj).slice(0,-1) + ',"messageindex":"14"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function removeEvent(obj) {
        removeEventItem(obj);
        tabBar.setCurrentIndex(0);
    }

    function checkChanged(condition, obj) {
        switch (condition) {
        case true:
            var exists = false;
            for (var b = 0; b < currentpeople.length; b++){
                var oi = JSON.parse(currentpeople[b]);
                if (obj.filename == oi.filename) {
                    exists = true;
                }
            }
            if (!exists){
                currentpeople.push(JSON.stringify(obj));
            }
            break;
        case false:
            for (var i = currentpeople.length; i > 0; i--){
                var ot = JSON.parse(currentpeople[i-1]);
                if (ot.filename == obj.filename) {
                    currentpeople.splice(i - 1,1);
                }
            }
            break;
        }
    }

    Component {
        id: prev
        PreviousEvent {}
    }

    Component {
        id: upc
        UpcomingEvent {}
    }

    Component {
        id: cev
        ConfigureEvent {}
    }

    Component {
        id: ppl
        AddMembersEvent {}
    }

    Component.onCompleted:  {
        if (!settings.isadmin) {
            tabBar.removeItem(2);
        }
    }

    Connections {
        target: window
        onDoEvents: {
            ld.currentItem.ready();
        }
    }

    ColumnLayout {
        id: columnLayout
        spacing: 0.5
        anchors.fill: parent
        Item {
            Layout.minimumHeight: tabBar.implicitHeight + 6
            Layout.maximumHeight: tabBar.implicitHeight + 6
            Layout.fillHeight: true
            Layout.fillWidth: true
            Rectangle {
                anchors.fill: parent
                anchors.margins: 3
                TabBar {
                    id: tabBar
                    width: parent.width
                    height: parent.height
                    font.capitalization: Font.SmallCaps
                    font.bold: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    Material.accent: colorlt

                    TabButton {
                        text: qsTr("Precedent")
                    }
                    TabButton {
                        text: qsTr("Future")
                    }
                    TabButton {
                        text: qsTr("Configure")
                    }

                    onCurrentIndexChanged: {
                        switch(tabBar.currentIndex){
                        case 0:
                            reset()
                            ld.push(prev);
                            break;
                        case 1:
                            reset()
                            ld.push(upc);
                            break;
                        case 2:
                            ld.push(cev);
                            break;
                        }
                    }
                }
            }
        }
        Item {
            Layout.fillHeight: true
            Layout.fillWidth: true
            StackView {
                anchors.fill: parent
                anchors.margins: 3
                id: ld
                clip: true;
                initialItem: prev
                onBusyChanged: {
                    if (!busy) {
                        ld.currentItem.ready();
                    }
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
                        winchange(login);
                    }
                }
            }
        }
    }

}
