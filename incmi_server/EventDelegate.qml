import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Item {
    height: 150
    width: parent.width
    property int drectpad: 3
    property string peoples

    Component.onCompleted: {
        for (var i = 0; i < people.count; i++){
            peoples += people.get(i).firstname + " " + people.get(i).lastname + "; ";
        }
        var da = Date.fromLocaleDateString(locale, date, 'dd:M:yyyy');
        ndate.text = da.getDate();
        mydate.text = da.toLocaleDateString(locale, 'MMMM yyyy');
    }

    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent
        border.color: "grey"
        border.width: 1

        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                var obj = JSON.parse(eventitembase);
                for (var i = 0; i < people.count; i++){
                    var ots = people.get(i);
                    var ts = JSON.parse(peoplebase);
                    ts.firstname = ots.firstname;
                    ts.lastname = ots.lastname;
                    ts.email = ots.email;
                    ts.filename = ots.filename;
                    ts.role = ots.role;
                    obj.people.push(JSON.stringify(ts));
                }
                obj.hour = hour;
                obj.date = date;
                obj.lieu = lieu;
                obj.details = details;
                obj.tag = tag;
                ddclicked(obj);
            }
        }


        Label {
            id: ndate
            x:0
            y:0
            height: parent.height
            width: parent.width / 4
            text: "22"
            font.pixelSize: 44
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }

        Label {
            id: mydate
            x: ndate.width
            y: 0
            width: parent.width - ndate.width - dlab.width
            height: parent.height / 6
            topPadding: 5
            text: date
            verticalAlignment: Text.AlignVCenter
            font.family: "Verdana"
            font.underline: false
            font.bold: true
            leftPadding: 10
            font.pointSize: 14
        }

        Label {
            id: dlab
            x: ndate.width
            y: mydate.height
            height: parent.height / 8
            width: (parent.width - ndate.width) / 2
            elide: "ElideRight"
            text: "Heure : " + hour
            font.pointSize: 9
            leftPadding: 10
            verticalAlignment: Text.AlignVCenter
        }

        Label {
            id: llieu
            x: dlab.x + dlab.width
            y: mydate.height
            width: (parent.width - ndate.width) / 2
            elide: "ElideRight"
            height: parent.height / 8
            text: "Lieu : " + lieu
            font.pointSize: 9
            rightPadding: 10
            horizontalAlignment: Text.AlignRight
            verticalAlignment: Text.AlignVCenter
        }

        Rectangle {
            id: drect
            x: ndate.width + drectpad
            y: llieu.y + llieu.height + drectpad
            width: parent.width - ndate.width - 2*drectpad
            height: (parent.height - mydate.height - dlab.height) / 2 - 2*drectpad
            border.color: "silver"
            border.width: 1
            Label {
                anchors.fill: parent
                text: "Details de l'evenements: " + details
                font.pointSize: 9
                wrapMode: Text.WordWrap
                padding: 5
            }
        }
        Rectangle {
            id: prect
            x: ndate.width + drectpad
            y: drect.y + drect.height + drectpad
            width: parent.width - ndate.width - 2*drectpad
            height: (parent.height - mydate.height - dlab.height) / 2 - 2*drectpad
            border.color: "silver"
            border.width: 1
            Label {
                anchors.fill: parent
                text: "Membres: " + peoples
                font.pointSize: 9
                wrapMode: Text.WordWrap
                padding: 5
            }
        }
    }
}
