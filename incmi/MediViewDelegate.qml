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
    function checkVisibility() {
        var vis = true;
        if (type == "inv") {
            vis = false;
        }
        return vis;
    }

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
            id: cod
            height: parent.height;
            x: xd;
            elide: "ElideRight"
            width: type == "docs" ? ((parent.width - 8) / 4) : parent.width;
            text: type == "docs" ? matricule + "::" + filename : "Changement inventaires:  " + matricule + "::" + filename
            leftPadding: pad
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r1
            height: parent.height - rpad*2;
            y: rpad;
            x: cod.x + cod.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            visible: checkVisibility()
            id: dat
            elide: "ElideRight"
            height: parent.height;
            x: xd + r1.width + r1.x;
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? formatText(date) : ""
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r2
            height: parent.height - rpad*2;
            y: rpad;
            x: dat.x + dat.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            visible: checkVisibility()
            id: lieu
            elide: "ElideRight"
            height: parent.height;
            x: xd + r2.width + r2.x;
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? ville: ""
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r3
            height: parent.height - rpad*2;
            y: rpad;
            x: lieu.x + lieu.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            visible: checkVisibility()
            id: nat
            elide: "ElideRight"
            height: parent.height;
            x: xd + r3.width + r3.x;
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? formatNate(nature) : ""
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
            getDocImage(filename,type);
        }
    }
}
