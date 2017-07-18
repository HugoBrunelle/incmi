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
            mod.append(JSON.parse('{ "name" : "' + obj.name + '", "count" : "' + obj.count + '", "rcount" : "' + obj.rcount + '", "tag" : "' + obj.tag + '"}'));
        }
    }

    property int xd: 2
    Rectangle{
        id: mrect
        x: 15
        y: 15
        height: parent.height -30
        width: parent.width - 30
        Rectangle{
            x:0
            y:0
            color: "lightgrey"
            border.color: "black"
            border.width: 1
            opacity: 0.2
            width: parent.width*3 / 5
            height: parent.height
        }
        ListView {
            id: typeview
            interactive: true
            x:0
            y:5
            clip: true
            width: parent.width*3 / 5
            height: parent.height - 20
            model: InventoryListModel { id: mod}
            delegate: settypedel

            Component.onCompleted: {
                typeview.currentIndex = 0
            }
        }

        Component {
            id: settypedel
            Item {
                x: xd
                height: 38
                width: parent.width - 2*x
                Rectangle {
                    property string ttag: tag
                    border.color: "lightgrey"
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
                        typeview.currentIndex = index;
                        currentName.text = name;
                        currentCount.text = count;
                        currentRCount.text = rcount;
                        currentTag.text = tag;
                    }
                }

            }
        }
        Rectangle{
            x: typeview.width + 1
            y:0
            color: "lightgrey"
            border.color: "black"
            border.width: 1
            opacity: 0.2
            width: (parent.width*2)/5 - 1
            height: parent.height
        }
        Item {
            id: titem
            x: typeview.width + 1
            width: (parent.width*2)/5 - 1
            height: parent.height / 2 - 2

            Pane {
                id: h1
                x: xd * 3
                y: xd * 2
                width: parent.width - 2*x
                height: (parent.height / 6) - 4*xd
                Material.background: colorp
                Material.elevation: 3
                Label {
                    anchors.fill: parent
                    leftPadding: xd*2
                    font.pointSize: 11
                    Material.foreground: colorlt
                    text: "Current Inventory Item"
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }
            }


            Label {
                id: l1
                x: xd
                y: h1.height + h1.y + 2*xd
                text: "Name:"
                font.pointSize: 9
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: l2
                x: xd
                y: l1.height + l1.y + 2*xd
                text: "Count:"
                font.pointSize: 9
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: l3
                x: xd
                y: l2.height + l2.y + 2*xd
                text: "Recommended Count"
                font.pointSize: 10
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: l4
                x: xd
                y: l3.height + l3.y + 2*xd
                text: "Unique Tag"
                font.pointSize: 9
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle {
                x: l1.width + l1.x + xd*2
                y: l1.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: currentName
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    font.pointSize: 9
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: currentCount
                }
            }
            Rectangle{
                x: l2.width + l2.x + xd*2
                y: l2.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: currentCount
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    font.pointSize: 9
                    anchors.leftMargin: 15
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: currentRCount
                }
            }
            Rectangle{
                x: l3.width + l3.x + xd*2
                y: l3.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: currentRCount
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    font.pointSize: 9
                    anchors.leftMargin: 15
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: nName
                }
            }
            Rectangle{
                x: l4.width + l4.x + xd*2
                y: l4.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: currentTag
                    enabled: false;
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    font.pointSize: 9
                    anchors.leftMargin: 15
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                }
            }

            Button {
                x: (parent.width*3/5)
                width: parent.width*2/5 - 5*xd
                y: l4.height + l4.y
                height: (parent.height/6) - 2*xd
                text: "Sauvegarder"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    var obj = JSON.parse('{"name":"", "count":"", "rcount":"", "tag":""}');
                    obj.name = currentName.text;
                    obj.count = currentCount.text;
                    obj.rcount = currentRCount.text;
                    obj.tag = currentTag.text;
                    editInventoryItem(obj)
                    mod.setProperty(typeview.currentIndex, "name", currentName.text);
                    mod.setProperty(typeview.currentIndex, "count", currentCount.text);
                    mod.setProperty(typeview.currentIndex, "rcount", currentRCount.text);
                    mod.setProperty(typeview.currentIndex, "tag", currentTag.text);
                }
            }

            Button {
                x: (parent.width/5)
                width: parent.width*2/5 - 5*xd
                y: l4.height + l4.y
                height: (parent.height/6) - 2*xd
                text: "Remove"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    mrect.enabled = false;
                    prm.show();
                }
            }
        }
        Item {
            x: typeview.width + 1
            y: titem.y + titem.height + 2
            width: (parent.width*2)/5 - 1
            height: parent.height / 2 - 2
            Pane {
                id: h2
                x: xd * 3
                y: xd * 2
                width: parent.width - 2*x
                height: (parent.height / 6) - 4*xd
                Material.background: colorp
                Material.elevation: 3
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


            Label {
                id: ll1
                x: xd
                y: h2.height + h2.y + 2*xd
                text: "Name"
                font.pointSize: 9
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: ll2
                x: xd
                y: ll1.height + ll1.y + 2*xd
                text: "Count"
                font.pointSize: 9
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Label {
                id: ll3
                x: xd
                y: ll2.height + ll2.y + 2*xd
                text: "Recommended Count"
                font.pointSize: 10
                width: (parent.width*2/5) - 2*x
                height: (parent.height / 6) - 2*xd
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                rightPadding: xd*3
            }
            Rectangle {
                x: ll1.width + ll1.x + xd*2
                y: ll1.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: nName
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    font.pointSize: 9
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: nCount
                }
            }
            Rectangle{
                x: ll2.width + ll2.x + xd*2
                y: ll2.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: nCount
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    font.pointSize: 9
                    anchors.leftMargin: 15
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: nRCount
                }
            }
            Rectangle{
                x: ll3.width + ll3.x + xd*2
                y: ll3.y
                width: (parent.width*3/5) - 5*xd
                height: (parent.height/6)-2*xd
                color: "white"
                border.color: "lightgrey"
                border.width: 1
                radius: 9
                TextInput {
                    id: nRCount
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    font.pointSize: 9
                    anchors.leftMargin: 15
                    text: qsTr("")
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: currentName
                }
            }

            Button {
                x: (parent.width*3/5)
                width: parent.width*2/5 - 5*xd
                y: ll3.height + ll3.y
                height: (parent.height/6) - 2*xd
                text: "Ajouter"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    var obj = JSON.parse('{"name":"", "count":"", "rcount":"", "tag":""}');
                    obj.name = nName.text;
                    obj.count = nCount.text;
                    obj.rcount = nRCount.text;
                    obj.tag = getRandomTag();
                    mod.append(JSON.parse('{ "name" : "' + obj.name + '", "count" : "' + obj.count + '", "rcount" : "' + obj.rcount + '", "tag" : "' + obj.tag + '"}'));
                    createInventoryItem(obj);
                }

            }
        }
    }
    Prompt {
        id: prm
        anchors.fill: parent
        anchors.topMargin: parent.height /5
        anchors.bottomMargin: parent.height /5
        anchors.leftMargin: parent.width / 3
        anchors.rightMargin: parent.width / 3
        Material.background: colora
        Material.elevation: 6
        Label {
            id: plabel
            x: parent.width /10
            width: parent.width - 2*x
            height: parent.height * 5 /10
            y: parent.height / 5
            text: "Are you certain that you want to delete the current document?"
            wrapMode: Text.WordWrap
            font.pointSize: 16
            Material.foreground: colorlt
        }
        Button {
            y: parent.height - plabel.y * 1.5
            x: parent.width /10
            width: parent.width * 3/ 10
            height: plabel.y
            text: "Oui"
            Material.background: colorp
            Material.foreground: colorlt

            onClicked: {
                var obj = JSON.parse('{"name":"", "count":"", "rcount":"", "tag":""}');
                obj.name = currentName.text;
                obj.count = currentCount.text;
                obj.rcount = currentRCount.text;
                obj.tag = currentTag.text;
                removeInventoryItem(obj);
                currentName.text = "";
                currentCount.text = "";
                currentRCount.text = "";
                currentTag.text = "";
                mod.remove(typeview.currentIndex, 1);
                typeview.currentIndex = -1;
                prm.hide();
                mrect.enabled = true;
            }
        }
        Button {
            y: parent.height - plabel.y * 1.5
            x: parent.width * 3/5
            width: parent.width * 3/ 10
            height: plabel.y
            text: "Non"
            Material.background: colorp
            Material.foreground: colorlt

            onClicked: {
                prm.hide();
                mrect.enabled = true;
            }
        }

    }

}

