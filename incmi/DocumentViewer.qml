import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

Item {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    property int mscale: 1
    property int nrectheight: 45
    property int pad: 5

    Component.onCompleted: {
        switch (currenttype) {
        case "invtot":
            cb.enabled = false;
            break;
        }
    }


    function sendByEmail() {
        var index;
        switch (currenttype) {
        case "docs":
            index = "9";
            break;
        case "inv":
            index = "9";
            break;
        case "inc":
            index = "23";
            break;
        case "invtot":
            index = "24";
            break;
        }
        var message = '{"messageindex":"'+index+'","filename":"' + currentfilename + '"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
    }

    function deleteDocument() {
        var index;
        switch (currenttype) {
        case "docs":
            index = "10";
            break;
        case "inv":
            index = "10";
            break;
        case "inc":
            index = "25";
            break;
        }
        var message = '{"messageindex":"'+index+'","filename":"' + currentfilename + '"}';
        mess.push(message);
        settings.messages = mess;
        sendSavedInformation();
        winchange(medimain);
    }

    function back() {
        switch (currenttype) {
        case "docs":
            winchange(medimain);
            break;
        case "inv":
            winchange(medimain);
            break;
        case "invtot":
            winchange(medinventory);
            break;
        case "inc":
            winchange(incm);
        }
    }

    Rectangle {
        id: m
        height: settings.isadmin ? parent.height - 70 - nrectheight : parent.height - 70
        width: parent.width
        color: "grey"
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
                                fillMode: Image.PreserveAspectFit
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
    Item {
        height: nrectheight
        width: parent.width
        y: parent.height - nrectheight - 70
        visible: settings.isadmin
        Rectangle {
            anchors.fill: parent
            anchors.margins: 3
            border.color: "grey"
            border.width: 1
            CButton {
                id: cb
                width: implicitWidth + 20
                height: parent.height
                x: parent.width - width - pad
                text: "Effacer"
                source: "Icons/ic_forward_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                onClicked: {
                    deleteDocument();
                }
            }
            CButton {
                id: ce
                width: implicitWidth + 20
                height: parent.height
                x: cb.x - width - 2*pad
                text: "Envoyer par Email"
                source: "Icons/ic_forward_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                onClicked: {
                    sendByEmail();
                }
            }
        }
    }

    Pane {
        width: parent.width
        y: parent.height - height
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
                    back();
                }
            }
        }
    }
}
