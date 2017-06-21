import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

Rectangle {
    property alias incbutton: incendie
    property alias medbutton: medical
    width: 360
    height: 640

    RowLayout {
        id: rowLayout
        anchors.rightMargin: 50
        anchors.leftMargin: 50
        anchors.bottomMargin: 200
        anchors.topMargin: 200
        spacing: 25
        anchors.fill: parent

        Button {
            id: incendie
            highlighted: false
            rightPadding: 12
            leftPadding: 12
            padding: 250
            bottomPadding: 250
            topPadding: 250
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }

        Button {
            id: medical
            padding: 20
            autoExclusive: false
            checkable: false
            checked: false
            highlighted: false
            leftPadding: 12
            rightPadding: 12
            bottomPadding: 250
            topPadding: 250
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
        }
    }
}
