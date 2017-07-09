import QtQuick 2.0

Loader {

    property bool changes: false
    property var currentComp

    id: base
    asynchronous: true
    opacity: 0.0
    anchors.fill: parent;
    onStatusChanged: {
        if (status == Loader.Ready) {
            opacity = 1.0;
        }
    }
    Behavior on opacity {
        SequentialAnimation {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InSine
            }
            ScriptAction {
                script: {
                    if (base.opacity == 0.0 && changes) {
                        base.sourceComponent = currentComp;
                        changes = false;
                    }
                }
            }
        }
    }

    function changeComponent(val) {
        currentComp = val;
        changes = true;
        base.opacity = 0.0;
    }
}
