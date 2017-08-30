import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    height: 640
    width: 360
    property int mscale: 1

    Rectangle {
        id: m
        height: parent.height - 70
        width: parent.width
        color: "lightgrey"
        Flickable {
                id: flick
                anchors.fill: parent
                contentWidth: m.width
                contentHeight: m.height

                PinchArea {
                    width: Math.max(flick.contentWidth, flick.width)
                    height: Math.max(flick.contentHeight, flick.height)

                    property real initialWidth
                    property real initialHeight
                    onPinchStarted: {
                        initialWidth = flick.contentWidth
                        initialHeight = flick.contentHeight
                    }

                    onPinchUpdated: {
                        // adjust content pos due to drag
                        flick.contentX += pinch.previousCenter.x - pinch.center.x
                        flick.contentY += pinch.previousCenter.y - pinch.center.y

                        // resize content
                        flick.resizeContent(initialWidth * pinch.scale, initialHeight * pinch.scale, pinch.center)
                    }

                    onPinchFinished: {
                        // Move its content within bounds.
                        flick.returnToBounds()
                    }

                    Rectangle {
                        width: flick.contentWidth
                        height: flick.contentHeight
                        color: "white"
                        Image {
                                anchors.fill: parent
                                fillMode: Image.Stretch
                                source: imgurl
                            MouseArea {
                                anchors.fill: parent
                                onDoubleClicked: {
                                    flick.contentWidth = m.width
                                    flick.contentHeight = m.height
                                }
                            }
                        }
                    }
                }
            }
    }

    Pane {
        width: parent.width
        y: m.height
        height: 70
        Material.background: "#0288D1"
        GridLayout {
            anchors.fill: parent
            CButton {
                text: qsTr("Retour")
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                Layout.maximumWidth: 150
                Layout.fillWidth: true
                Layout.fillHeight: true
                source: "Icons/ic_backspace_white_24dp.png"
                Material.foreground: colorlt
                Material.background: colordp
                onClicked: {
                    winchange(medimain);
                }
            }
        }
    }
}
