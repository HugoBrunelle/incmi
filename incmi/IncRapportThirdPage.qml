import QtQuick 2.9
import QtQuick.Controls 2.2
import QtWebSockets 1.1
import QtQuick.Controls.Material 2.2

Rectangle {
    property int pad: 5
    property int buttonheight: 35
    property int headerheight: 40
    property var checkobjects
    property string otherbase: '{"value":""}'

    anchors.fill: parent

    function remove(index, obj) {
        other.splice(index,1);
        mod.remove(index);
        console.log(other);
    }

    function checkAdd() {
        if (t1.text != "") {
            badd.enabled = true;
        }else {
            badd.enabled = false;
        }
    }

    function add() {
        var obj = JSON.parse(otherbase);
        obj.value = t1.text;
        t1.text = "";
        other.push(JSON.stringify(obj));
        mod.append(obj);
        console.log(other)
    }


    Item {
        id: header
        width: parent.width
        height: badd.y + badd.height + pad
        Pane {
            id: p1
            y: pad
            height: buttonheight
            width: parent.width - 2*pad
            x: pad
            Material.elevation: 2
            Material.background: colordp
            Label {
                Material.foreground: colorlt
                text: qsTr("Services incendie sur les lieux et autres services")
                x: 3*pad
                width: parent.width - 3*pad
                height: implicitHeight
                y: (parent.height - height) / 2
            }
        }
        Label {
            id: lb
            y: r1.y
            x: pad
            text: "Services : "
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: pad + p1.height + p1.y
            width: parent.width - 3*pad - lb.width
            height: buttonheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: t1
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                onTextChanged: {
                    checkAdd();
                }
            }
        }
        Button {
            id: badd
            enabled: checkAdd();
            text: qsTr("Add")
            width: implicitWidth
            height: buttonheight
            y: r1.height + r1.y + pad
            x: parent.width - width - pad
            onClicked: {
                add();
            }
            Material.foreground: colorlt
            Material.background: colordp
        }
    }

    Item {
        id: body
        height: parent.height - header.height
        width: parent.width
        y: header.height
        Rectangle {
            anchors.fill: parent
            anchors.margins: pad
            border.width: 1
            border.color: "grey"
            ListView {
                anchors.fill: parent
                anchors.margins: pad
                model: ListModel { id: mod }
                delegate:
                    Item {
                    width: parent.width
                    height: 38
                    property int pad: 3
                    property string seperatorcolor: "grey"
                    property int seperatorwidth: 1

                    Rectangle {
                        anchors.fill: parent
                        border.color: "lightgrey"
                        border.width: 1
                        MouseArea {
                            anchors.fill: parent
                        }
                        Button {
                            id: rbut
                            x: 3*pad
                            y: pad
                            width: implicitWidth - 10
                            height: parent.height - 2*pad
                            text: qsTr("X")
                            Material.foreground: colorlt
                            Material.background: Material.Red
                            onClicked: {
                                remove(index, getObject());
                            }
                        }
                        Label {
                            text: value
                            x: rbut.width + rbut.x + 4*pad
                            width: parent.width - rbut.width - 3*pad
                            height: implicitHeight
                            y: (parent.height - height) / 2
                        }
                    }

                    function getObject() {
                        var obj = JSON.parse(peoplebase);
                        obj.value = value;
                        return obj
                    }
                }
                interactive: true;
                clip: true;
                spacing: 1
            }
        }
    }
}
