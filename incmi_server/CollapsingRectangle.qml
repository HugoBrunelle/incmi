import QtQuick 2.0

Rectangle {
    id: base
    function collape() {
        base.height = 0;
    }

    function open(val) {
        base.height = val;
    }
    signal animated()
    Behavior on height {
        SequentialAnimation {
            NumberAnimation {
                duration: 250
                easing: Easing.InOutBack
            }
            ScriptAction {
                script: animated();
            }
        }
    }


}
