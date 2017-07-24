import QtQuick 2.8
import QtQuick.Window 2.0
import QtQuick.Controls 2.1

Pane {
    id: base
    visible: false
    opacity: 0.0

    function checkstate(){
        if (opacity == 0.0){
            visible = false;
        }
    }

    function show() {
        visible = true;
        opacity = 1.0;
    }

    function hide() {
        opacity = 0.0;
    }

    Behavior on opacity {
        SequentialAnimation{
        NumberAnimation {
            duration: 240
            easing.type: Easing.Linear
        }
        ScriptAction {
            script: checkstate();
        }
        }
    }
}
