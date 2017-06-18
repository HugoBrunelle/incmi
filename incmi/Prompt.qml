import QtQuick 2.8
import QtQuick.Window 2.0

Rectangle {
    id: base
    visible: true
    opacity: 0.0
    state: "hidden"
    states: [
                State {
                    name: "show"
                    PropertyChanges {
                        target: base;
                        opacity: 1.0}
                    PropertyChanges {
                        target: base;
                        visible: true
                    }
                },
                State {
                    name: "hidden"

                    PropertyChanges {
                        target: base;
                        opacity: 0.0}
                    PropertyChanges {
                        target: base;
                        visible: false
                    }
                }
            ]
    transitions: [
        Transition {
            from: "hidden"
            to: "show"
            SequentialAnimation {
                NumberAnimation {
                    property: "visible"
                    duration: 0
                }
                NumberAnimation {
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
            }
        },
        Transition {
            from: "show"
            to: "hidden"
            SequentialAnimation {
                NumberAnimation {
                    property: "opacity"
                    duration: 400
                    easing.type: Easing.OutBack
                }
                NumberAnimation {
                    property: "visible"
                    duration: 0
                }
            }
        }

    ]

}
