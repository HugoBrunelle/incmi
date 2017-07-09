import QtQuick 2.0
import QtQuick.Controls.Material 2.0
import QtQuick.Controls 2.2
import Qt.labs.calendar 1.0

Item {
    property alias logconsole: textArea
    width: 1280
    height: 495

        TextArea {
            id: textArea
            text: qsTr("Text Area")
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            wrapMode: Text.WordWrap
            font.pointSize: 10
            anchors.fill: parent
            enabled: false
        }

        ScrollBar {
                  id: vbar
                  hoverEnabled: true
                  active: hovered || pressed
                  orientation: Qt.Vertical
                  size: parent.height / textArea.contentHeight
                  anchors.top: parent.top
                  anchors.right: parent.right
                  anchors.bottom: parent.bottom
              }

        function addline(val){
            textArea.append(val);
        }
}
