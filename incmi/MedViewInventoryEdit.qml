import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
Item {
    property int pad: 5
    property int headerheight: 50
    property int footerheight: 70
    property int textboxheight: 35
    property bool cansave: false
    property bool contentenabled: true
    property int xd: 5

    function ready() {}

    function checkSave() {
        if (tname.text == "" || tcount.text == "" || trcount.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function getObj() {
        var obj = JSON.parse(inventoryitembase);
        obj.name = tname.text;
        obj.count = tcount.text;
        obj.rcount = trcount.text;
        obj.tag = ttag.text;
        return obj;
    }

    function save() {
        var obj = getObj();
        editInvItem(obj);
    }
    function confirmRemove(){
        var obj = getObj();
        removeInvItem(obj);
    }
    function cancel() {
        cancelInvEdit();
    }

    Component.onCompleted: {
        var obj = JSON.parse(currentInvItem);
        tname.text = obj.name;
        tcount.text = obj.count;
        trcount.text = obj.rcount;
        ttag.text = obj.tag;
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
            Material.foreground: colorlt
            text: "Edit Inventory Item"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
        }
    }

    Item {
        id: center
        x: pad
        width: parent.width - pad
        height: parent.height - headerheight - footerheight - 4*pad
        y: header.y + header.height + pad
        enabled: contentenabled

        Label {
            y: pad
            x: pad
            text: "Name : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: pad
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: tname
                selectByMouse: true
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
                id: tcount
                selectByMouse: true
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
            height: r1.height
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + r2.height + r2.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: trcount
                selectByMouse: true
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
        Label {
            y: r4.y
            x: pad
            text: "Unique Tag : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r4
            x: lb.x + lb.width + pad
            y: pad + r3.height + r3.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: ttag
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                enabled: false
            }
        }
    }

    Item {
        id: footer
        x: pad
        y: parent.height - height - pad
        width: parent.width - 2*pad
        height: footerheight
        enabled: contentenabled
        Button {
            id: canbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 3 / 4 - pad
            text: "Cancel"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                cancel();
            }
        }
        Button {
            id: rembut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 1 / 2 - pad
            text: "Remove"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                prm.show();
                contentenabled = false;
            }
        }
        Button {
            id: addbut
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 1 / 4 - pad
            text: "Save"
            Material.background: colordp
            Material.foreground: colorlt
            enabled: cansave
            onClicked: {
                save();
            }
        }

    }
    Prompt {
        id: prm
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            Label {
                text: qsTr("Êtes vous sur de vouloir effacer l'objet d'inventaires?")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
                wrapMode: Text.WordWrap
                Layout.maximumHeight: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        prm.hide();
                        contentenabled = true;
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        confirmRemove();
                    }
                }
            }
        }
    }
}
