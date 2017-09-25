import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width - 10
    height: 45
    Rectangle {
        color: "white"
        border.color: "grey"
        border.width: 1
        radius: 3
        anchors.fill: parent
        RowLayout {
            anchors.rightMargin: 15
            anchors.bottomMargin: 10
            anchors.leftMargin: 15
            anchors.topMargin: 10
            anchors.fill: parent
            spacing: 10
            Text {
                id: mheight
                text: name
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                y : 2
                height: parent.height
                width: 1
                color: "darkgrey"
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }


            Text {
                id: cc
                text: count
                Layout.minimumWidth: 50
                Layout.maximumWidth: 50
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                y : 2
                height: parent.height
                width: 1
                color: "darkgrey"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
            }

            Text {
                text: rcount
                Layout.minimumWidth: 50
                Layout.maximumWidth: 50
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                anchors.verticalCenter: parent.verticalCenter
            }

        }
    }
    MouseArea {
        anchors.fill: parent
        onDoubleClicked: {
            if (settings.isadmin){
                invListView.currentIndex = index;
                itemDoubleClicked(getObj());
            }
        }
    }

    function getObj() {
        var obj = JSON.parse(inventoryitembase);
        obj.count = count;
        obj.rcount = rcount;
        obj.tag = tag;
        obj.name = name;
        return obj;
    }

    Component.onCompleted: {
        if (parseInt(count) < parseInt(rcount)) {
            cc.color = "red";

        }else {
            cc.color = "green";
        }
    }

}
