import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: parent.width
    property int pad: 5
    property var currentpeople: []
    property bool editing: false;
    property string currentevent: eventitembase
    property string currenthour
    property string currentdetails
    property string currentlieu
    property string currenttag


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
        currenttag = obj.tag;
        tabBar.setCurrentIndex(2);
        var dd = Date.fromLocaleDateString(locale, obj.date, 'dd:M:yyyy');
        cal.selectedDate = dd;
    }

    function doneMembers(){
        ld.push(cev);
    }

    function dclicked(obj){
        ld.push(ppl);
    }

    function ddclicked(obj) {
        editEvent(obj);
    }

    function saveEvent(obj){
        switch(editing){
        case true:
            editEventItemServer(obj);
            editing = false;
            break;
        case false:
            createEventItemServer(obj);
            break;
        }
        tabBar.setCurrentIndex(0);
    }

    function removeEvent(obj) {
        removeEventItemServer(obj);
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
            console.log ("checking to remove");
            for (var i = currentpeople.length; i > 0; i--){
                var ot = JSON.parse(currentpeople[i-1]);
                if (ot.filename == obj.filename) {
                    currentpeople.splice(i - 1,1);
                }
            }
            break;
        }
    }

    Item {
        id: lframe
        x: pad
        y: pad
        width: (parent.width * 2 / 3) - pad
        height: parent.height - 2*pad
        Calendar {
            id: cal
            anchors.fill: parent
            onSelectedDateChanged: {

            }
        }
    }

    Item {
        id: rframe
        y: pad
        width: (parent.width / 3) - pad
        height: parent.height - 2*pad
        x: lframe.width + lframe.x

        Rectangle {
            id: rectangle
            color: "#ffffff"
            anchors.fill: parent
            border.color: "grey"
            border.width: 1

            TabBar {
                id: tabBar
                x: pad / 2
                width: parent.width - pad
                y: pad / 2
                height: 50
                font.pointSize: 11
                font.capitalization: Font.SmallCaps
                Material.foreground: colorlt
                Material.background: colordp
                Material.accent: colorlt

                TabButton {
                    text: qsTr("Previous Events")
                }
                TabButton {
                    text: qsTr("Upcoming Events")
                }
                TabButton {
                    text: qsTr("Configure Events")
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

            StackView {
                clip: true
                id: ld
                y: tabBar.y + tabBar.height + pad
                x: pad
                height: parent.height - ld.y - 2*pad
                width: parent.width - 2*pad
                initialItem: prev
            }
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

}
