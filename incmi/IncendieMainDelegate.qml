import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width - 10
    height: 45
    property int xd: 1
    property int pad: 10
    property int rpad: 9

    /*

    function formatText(text) {
        var ntext = text.replace(":","/");
        ntext = ntext.replace(":","/");
        return ntext;
    }

    function formatNate(text) {
        var ntext;
        switch(text) {
        case "1":
            ntext = "Leger"
            break;
        case "2":
            ntext = "Moderer"
            break;
        case "3":
            ntext = "Sever"
            break;
        case "":
            ntext = ""
            break;
        }
        return ntext;
    }

    */

    Rectangle {
        color: {
            if (listView.currentIndex == index) {
                return "#e4e4e4"
            }
            else {
                return "white"
            }
        }
        border.color: "grey"
        border.width: 1
        radius: 3
        anchors.fill: parent
        Label {
            id: dat
            height: parent.height;
            x: xd;
            elide: "ElideRight"
            width: ((parent.width - 8) / 5)
            text: date
            leftPadding: pad
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r1
            height: parent.height - rpad*2;
            y: rpad;
            x: dat.x + dat.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: tim
            elide: "ElideRight"
            height: parent.height;
            x: xd + r1.width + r1.x;
            width: ((parent.width - 8) / 5);
            text: time
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r2
            height: parent.height - rpad*2;
            y: rpad;
            x: tim.x + tim.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: adress
            elide: "ElideRight"
            height: parent.height;
            x: xd + r2.width + r2.x;
            width: ((parent.width - 8) / 5);
            text: adresse
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r3
            height: parent.height - rpad*2;
            y: rpad;
            x: adress.x + adress.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: vill
            elide: "ElideRight"
            height: parent.height;
            x: xd + r3.width + r3.x;
            width: ((parent.width - 8) / 5);
            text: ville
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }

        Rectangle {
            id: r4
            height: parent.height - rpad*2;
            y: rpad;
            x: vill.x + vill.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: typ
            elide: "ElideRight"
            height: parent.height;
            x: xd + r4.width + r4.x;
            width: ((parent.width - 8) / 5);
            text: type
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            listView.currentIndex = index;
        }

        onDoubleClicked: {
            getDocImage(filename,"inc");
        }
    }
}
