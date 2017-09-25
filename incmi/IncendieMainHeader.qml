import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 0
    height: 45
    width: parent.width
    Pane {
        height: parent.height - 4
        anchors.fill: parent
        anchors.bottomMargin: 5
        Material.elevation: 1
        Material.background: "#FFFFFF"
        RowLayout {
            x:10
            anchors.fill: parent
            Text {
                id: theight
                color: "#b3000000"
                text: qsTr("Date")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: true
                elide: Text.ElideMiddle
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Rectangle {
                y : 2
                height: parent.height - 4
                color: "#b3000000"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                width: 1
                Layout.fillHeight: true
            }
            Text {
                color: "#b3000000"
                text: qsTr("Heure")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Rectangle {
                y : 2
                height: parent.height - 4
                width: 1
                color: "#b3000000"
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
            }
            Text {
                color: "#b3000000"
                text: qsTr("Adresse")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Rectangle {
                y : 2
                height: parent.height - 4
                width: 1
                color: "#b3000000"
                Layout.fillHeight: true
            }
            Text {
                color: "#b3000000"
                text: qsTr("Ville")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: true
                elide: Text.ElideMiddle
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            }
            Rectangle {
                y : 2
                height: parent.height - 4
                width: 1
                color: "#b3000000"
                Layout.fillHeight: true
            }
            Text {
                color: "#b3000000"
                text: qsTr("Nature")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.verticalCenter: parent.verticalCenter
                Layout.fillWidth: true
                Layout.fillHeight: true
                font.bold: true
                elide: Text.ElideMiddle
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            }
        }
    }
}
