import QtQuick 2.4
import QtQuick.Window 2.0

Rectangle {
    property alias marea: mArea

    width: window.wwidth
    height: window.height

    color: "blue"


    MouseArea {
        id: mArea
        anchors.fill: parent
        anchors.margins: 0
    }


}
