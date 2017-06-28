import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width - 10
    height: 45
    Pane {
        Material.elevation: 1
        Material.background: "#F5F5F5"

        anchors.fill: parent
        RowLayout {
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
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
                text: recommendedCount
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
        onClicked: {
            invListView.currentIndex = index;
        }
    }

    Component.onCompleted: {
        if (parseInt(count) < parseInt(recommendedCount)) {
            cc.color = "red";

        }else {
            cc.color = "green";
        }
    }

}
