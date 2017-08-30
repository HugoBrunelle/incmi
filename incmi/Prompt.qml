import QtQuick 2.8
import QtQuick.Window 2.0
import QtQuick.Controls 2.1

Pane {
    id: base
    visible: false
    y: parent.height
    opacity: 1.0
    state: "hidden"

    function checkstate(){
        if (state == "hidden"){
            visible = false;
        }
    }

    function show() {
        visible = true;
        state = "visible"
    }

    function hide() {
        state = "hidden"
    }
    states: [
        State { name: "visible";  PropertyChanges {target: base; y: parent.height / 4.5}},
        State { name: "hidden"; PropertyChanges {target: base; y: parent.height}}
    ]

    transitions: [
        Transition {
            from: "visible"
            to: "hidden"
            SequentialAnimation {
            NumberAnimation { properties: "y"; duration: 300; easing.type: Easing.OutQuad }
            ScriptAction {
                script: checkstate();
            }
            }
        },
        Transition {
            from: "hidden"
            to: "visible"
            SequentialAnimation {
            NumberAnimation { properties: "y"; duration: 300; easing.type: Easing.OutQuad }
            ScriptAction {
                script: checkstate();
            }
            }
        }
    ]

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
