import QtQuick 2.8
import QtQuick.Window 2.0

Rectangle {
    id: base
    visible: false
    opacity: 0.0
    onVisibleChanged: {
        if (visible)
        {
           opacity = 1.0;
        }
        else {
           opacity = 0.0;
        }

    }
    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.InSine
        }
    }
}
