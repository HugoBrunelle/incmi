import QtQuick 2.0
import QtQuick.Controls 2.1

Item {
    property int xd: 1
    property int fonts: 10
    property int pad: 10
    function checkVisibility() {
        var vis = true;
        if (type == "inv") {
            vis = false;
        }
        return vis;
    }

    function formatDate(text) {
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

    x: xd * 2
    height: 38
    width: parent.width - 2*x
    Rectangle {
        border.color: "lightgrey"
        anchors.fill: parent
        height: parent.height
        width: parent.width
        color: typeview.currentIndex == index ? "gainsboro" : "white"
        anchors.margins: 2
        border.width: 1
        Label {
            id: cod
            height: parent.height;
            x: xd;
            elide: "ElideRight"
            width: type == "docs" ? ((parent.width - 8) / 4) : parent.width;
            text: type == "docs" ? matricule + "::" + filename : "Changement inventaires:  " + matricule + "::" + filename
            leftPadding: pad
            font.pointSize: fonts
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r1
            height: parent.height - 16;
            y: 8;
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
            font.pointSize: fonts
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? formatDate(date) : ""
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r2
            height: parent.height - 16;
            y: 8;
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
            font.pointSize: fonts
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? ville: ""
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            visible: checkVisibility()
            id: r3
            height: parent.height - 16;
            y: 8;
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
            font.pointSize: fonts
            width: ((parent.width - 8) / 4);
            text: type == "docs" ? formatNate(nature) : ""
            horizontalAlignment: Text.AlignHCenter;
            verticalAlignment: Text.AlignVCenter;
        }
    }
    MouseArea {
        anchors.fill: parent
        onClicked: {
            typeview.currentIndex = index;
            if (type == "docs") {
                removeTempImage();
                currentfilename = filename;
                pload.active = true;
            }
        }
    }
}
