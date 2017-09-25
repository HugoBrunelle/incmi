import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: parent.height
    Component.onCompleted: {
        var jobj = JSON.parse(createInventoryServer());
        for (var i = 0; i < jobj.items.length; i++){
            var obj = jobj.items[i];
            mod.append(obj);
        }
    }

    function editInvItem(obj) {
        editInventoryItem(obj);
        mod.setProperty(typeview.currentIndex, "name", obj.name);
        mod.setProperty(typeview.currentIndex, "count", obj.count);
        mod.setProperty(typeview.currentIndex, "rcount", obj.rcount);
        ld.push(nitem);
    }

    function addInvItem(obj){
        mod.append(obj);
        createInventoryItem(obj);
    }

    function removeInvItem(obj) {
        removeInventoryItem(obj);
        mod.remove(typeview.currentIndex, 1);
        typeview.currentIndex = -1;
        ld.push(nitem);

    }

    function cancelEditInvItem() {
        ld.push(nitem);
    }

    function selectItemToEdit(index,obj) {
        typeview.currentIndex = index;
        currentitem = JSON.stringify(obj);
        ld.push(eitem);
    }

    property int xd: 2
    property int listpad: 5
    property string currentitem: inventoryitembase
    Rectangle{
        id: mrect
        x: 15
        y: 15
        height: parent.height -30
        width: parent.width - 30
        Rectangle{
            id: lframe
            x:0
            y:0
            color: "whitesmoke"
            border.color: "grey"
            border.width: 1
            width: parent.width*3 / 5
            height: parent.height
            ListView {
                id: typeview
                interactive: true
                x:listpad
                y:listpad
                clip: true
                width: parent.width - 2*listpad
                height: parent.height - 2*listpad
                model: ListModel {id: mod}
                currentIndex: -1
                delegate: settypedel
            }

            Component {
                id: settypedel
                Item {
                    x: xd
                    height: 38
                    width: parent.width - 2*x
                    Rectangle {
                        property string ttag: tag
                        border.color: "grey"
                        anchors.fill: parent
                        height: parent.height
                        width: parent.width
                        color: typeview.currentIndex == index ? "gainsboro" : "white"
                        anchors.margins: 2
                        border.width: 1
                        Label {
                            id: ld
                            x: 25
                            width: (parent.width / 4)
                            height: parent.height
                            text: name
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        Rectangle{
                            width: 1
                            y: 3*xd
                            height: parent.height - 6*xd
                            x: parent.width * 6 / 8 - 4*xd
                            color: "grey"
                        }

                        Label {
                            id: ld2
                            x: parent.width*6/8 - 2*xd
                            width: parent.width / 8 - xd
                            height: parent.height
                            text: count
                            color: parseInt(count) < parseInt(rcount) ? "red" : "green"
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Rectangle{
                            width: 1
                            y: 3*xd
                            height: parent.height - 6*xd
                            x: parent.width * 7 / 8 - 4*xd
                            color: "grey"
                        }

                        Label {
                            id: ld3
                            x: parent.width * 7 /8 - 2*xd
                            width: parent.width/8 - xd
                            height: parent.height
                            text: rcount

                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (typeview.currentIndex != index){
                                var obj = JSON.parse(inventoryitembase);
                                obj.name = name;
                                obj.count = count;
                                obj.rcount = rcount;
                                obj.tag = tag;
                                selectItemToEdit(index,obj);
                            }
                        }
                    }

                }
            }
        }

        Rectangle{
            x:  lframe.width
            id: rframe
            y:0
            color: "white"
            border.color: "grey"
            border.width: 1
            width: (parent.width*2)/5 - 1
            height: parent.height
            StackView {
                clip: true
                id: ld
                anchors.fill:parent
                initialItem: nitem
            }
        }
    }

    Component {
        id: nitem
        NewInvItem {}
    }

    Component {
        id: eitem
        EditInvItem {}
    }

}
