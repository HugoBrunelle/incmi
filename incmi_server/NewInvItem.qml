import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
Item {
    property int pad: 5
    property int headerheight: 50
    property int footerheight: 70
    property int textboxheight: 35
    property bool cansave: false

    function checkSave() {
        if (tname.text == "" || tcount.text == "" || trcount.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function add() {
        var obj = JSON.parse(inventoryitembase);
        obj.name = tname.text;
        obj.count = tcount.text;
        obj.rcount = trcount.text;
        obj.tag = getRandomTag();
        addInvItem(obj);
        tname.text = "";
        tcount.text = "";
        trcount.text = "";
    }

    function exportInv() {
        if (!pload.active) {
            pload.active = true;
        }
    }

    function imageRendered(obj) {
        if (pload.active) {
            var loc = invtotal.split(".")[0] + ".png";
            obj.saveToFile(loc);
            file.printToPDF(loc.split(".")[0]);
            var path = Qt.openUrlExternally(file.getApplicationPath() + "/" + loc.split(".")[0] + ".pdf");
            Qt.openUrlExternally(path);
            pload.active = false;
        }
    }

    Loader {
        visible: false;
        active: false;
        id: pload;
        sourceComponent: pinvent

        onStatusChanged: {
            if (status == Loader.Ready) {
                if (active) {
                    pload.item.grabToImage(function(obj) {imageRendered(obj);});
                }
            }
        }
    }

    height: parent.height
    width: parent.width
    Pane {
        id: header
        x: pad
        y: pad
        width: parent.width - 2*pad
        height: headerheight
        Material.background: colordp
        Material.elevation: 1
        Label {
            anchors.fill: parent
            leftPadding: xd*2
            font.pointSize: 11
            Material.foreground: colorlt
            text: "New Inventory Item"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

    Item {
        id: center
        y: header.y + header.height + pad
        x: pad
        width: parent.width - pad
        height: parent.height - headerheight - footerheight - 4*pad

        Label {
            y: pad
            x: pad
            text: "Name : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: pad
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: tname
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tcount
                text: ""
                onTextChanged: {
                    checkSave();
                }
            }
        }
        Label {
            y: r2.y
            x: pad
            text: "Count : "
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
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: tcount
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                KeyNavigation.tab: trcount
                onTextChanged: {
                    checkSave();
                }
            }
        }
        Label {
            id: lb
            y: r3.y
            x: pad
            text: "Recommended Count : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + r2.height + r2.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: trcount
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tname
                text: ""
                onTextChanged: {
                    checkSave();
                }
            }
        }
    }

    Item {
        id: footer
        x: pad
        y: parent.height - height - pad
        width: parent.width - 2*pad
        height: footerheight
        Button {
            id: addbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 3 / 4 - pad
            text: "Add"
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                add();
            }
        }
        Button {
            id: exportinvb
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width * 3/ 7 - 2*pad
            x: parent.width / 4 - pad
            text: "Exporter Inv."
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                exportInv();
            }
        }

    }

}
