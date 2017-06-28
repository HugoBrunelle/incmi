import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width
    height: 45
    Pane {
        Material.elevation: 1
        Material.background: {
            if (listView.currentIndex == index) {
                return "#e4e4e4"
            }
            else {
                return "#F5F5F5"
            }
        }

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
                text: code
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                y : 2
                height: parent.height
                width: 1
                color: "darkgrey"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: false
            }

            Text {
                text: date
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
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }


            Text {
                text: location
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
                text: nature
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
            listView.currentIndex = index;
        }
    }
}
