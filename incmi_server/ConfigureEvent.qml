import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2



Item {
    property int textboxheight: 35
    property int pad: 3
    property int footerheight: 70
    property bool cansave: false

    Component.onCompleted:  {
        for (var i = 0; i < currentpeople.length; i++){
            var obj = JSON.parse(currentpeople[i]);
            tmembers.text += obj.firstname + " " + obj.lastname + "; ";
        }
        var ob = JSON.parse(currentevent);
        thour.text = currenthour;
        tlieu.text = currentlieu;
        tdetails.text = currentdetails;
    }

    function checkSave() {
        if (thour.text == "" || tdetails.text == "" || tlieu.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function remove(){
        var obj = JSON.parse(eventitembase);
        obj.date = cal.selectedDate.toLocaleDateString(locale,'dd:M:yyyy');
        obj.hour = thour.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.text;
        obj.tag = currenttag;
        removeEvent(obj);
    }
    function save(){
        var tt;
        if (editing){
            tt = currenttag;
        }
        else{
            tt = getRandomTagEvent();
        }
        var obj = JSON.parse(eventitembase);
        obj.date = cal.selectedDate.toLocaleDateString(locale,'dd:M:yyyy');
        obj.hour = thour.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.text;
        obj.tag = tt;
        saveEvent(obj);
    }

    width: parent.width
    height: parent.height
    Item {
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - footerheight
        Label {
            id: dlabel
            x: pad
            y: pad
            text: "Event date: "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            height: textboxheight
        }

        Label {
            id: tdate
            x: pad + dlabel.width + dlabel.x
            y: pad
            text: cal.selectedDate.toDateString()
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 16
            height: textboxheight
        }

        Label {
            y: r1.y
            x: pad
            text: "Heure : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: dlabel.height + dlabel.y + pad * 5
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: thour
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tlieu
                text: ""
                onTextChanged: {
                    currenthour = thour.text;
                    checkSave();
                }
            }
        }
        Label {
            y: r2.y
            x: pad
            text: "Lieu : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r2
            x: lb.x + lb.width + pad
            y: pad + r1.height + r1.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: tlieu
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                KeyNavigation.tab: tdetails
                onTextChanged: {
                    currentlieu = tlieu.text;
                    checkSave();
                }
            }
        }
        Label {
            id: lb
            y: r3.y
            x: pad
            text: "Members invited : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + r2.height + r2.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    dclicked();
                }
            }
            Label {
                id: tmembers
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignTop
                text: ""
                wrapMode: Text.WordWrap
            }

        }
        Label {
            y: r4.y
            x: pad
            text: "Detailes : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r4
            x: lb.x + lb.width + pad
            y: pad + r3.height + r3.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: tdetails
                selectByMouse: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 5
                anchors.leftMargin: 15
                KeyNavigation.tab: thour
                text: ""
                onTextChanged: {
                    currentdetails = tdetails.text;
                    checkSave();
                }
            }
        }
    }


    Item {
        id: footer
        x: pad
        y: parent.height - footer.height - pad
        height: footerheight
        width: parent.width - 2*pad
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width *3/ 4 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: cansave
            text: "Save"
            onClicked: {
                save();
            }
        }
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width / 2 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: editing
            text: "Remove"
            onClicked: {
                remove();
            }
        }
    }
}
