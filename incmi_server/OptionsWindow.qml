import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: 1280
    height: 720
    visible: false
    opacity: 0.0
    property int xd: 10
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
                duration: 250
                easing.type: Easing.InSine
            }
            ScriptAction {
                script: checkstate();
            }
        }
    }
    Rectangle {
        anchors.fill: parent
        opacity: 0.42
        color: "black"

    }
    Pane {
        x: parent.width/7
        width: (parent.width*5)/7
        y: parent.height / 8
        height: (parent.height*6)/8
        Material.background: colorlt
        Material.elevation: 5
        Item {
            id: deltem
            x: xd
            y: xd
            width: parent.width - x*2
            height: parent.height - 4*xd - ret.height
            Rectangle{
                x:0
                y:0
                color: "lightgrey"
                border.color: "black"
                border.width: 1
                opacity: 0.2
                width: parent.width / 3
                height: parent.height
            }
            ListView {
                clip: true
                id: typeview
                interactive: false
                x:0
                y:5
                width: parent.width / 3
                height: parent.height - 10
                model: ListModel {
                    id: mod
                    ListElement{
                        type: "Access and Password"
                    }
                    ListElement{
                        type: "Server Settings"
                    }
                    ListElement{
                        type: "People Management"
                    }
                }
                delegate: settypedel

                onCurrentIndexChanged: {
                    switch(typeview.currentIndex){
                    case 0:
                        sview.push(accview,StackView.Immediate);
                        break;
                    case 1:
                        sview.push(servview,StackView.Immediate);
                        break;
                    case 2:
                        sview.push(pplmanview,StackView.Immediate);
                    }
                }
            }

            Component {
                id: settypedel
                Item {
                    x: xd
                    height: 50
                    width: parent.width - 2*x
                    Rectangle {
                        border.color: "lightgrey"
                        anchors.fill: parent
                        height: parent.height
                        width: parent.width
                        color: typeview.currentIndex == index ? "gainsboro" : "white"
                        anchors.margins: 2
                        border.width: 1
                        Label {
                            id: ld
                            x: 25
                            width: parent.width - 50
                            height: parent.height
                            text: type
                            font.pointSize: 10
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            typeview.currentIndex = index;
                        }
                    }

                }
            }
            Rectangle{
                x: typeview.width + 1
                y:0
                color: "lightgrey"
                border.color: "black"
                border.width: 1
                opacity: 0.2
                width: (parent.width*2)/3 - 1
                height: parent.height
            }
            StackView {
                clip: true
                id: sview
                x: typeview.width + 1
                width: (parent.width*2)/3 - 1
                height: parent.height
                initialItem: accview
            }

            Component {
                id: accview
                AcountSettingsView {
                    id: apage
                anchors.fill: parent
                }
            }

            Component {
                id: servview
                ServerSettingsView {
                    id: spage
                anchors.fill: parent
                }
            }

            Component {
                id: pplmanview
                PeopleSettingsView {
                    id: ppage
                    anchors.fill: parent
                }
            }

        }

        Button {
            id: saveb
            width: 150
            height: 45
            x: parent.width - ret.width*2 - xd*6
            y: parent.height - ret.height - xd
            text: "Sauvegarder"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                sview.currentItem.save();
                load.enabled = true;
                options.hide();
            }
        }

        Button {
            id: ret
            width: 150
            height: 45
            x: parent.width - ret.width - xd*3
            y: parent.height - ret.height - xd
            text: "Annuler"
            Material.background: colordp
            Material.foreground: colorlt
            onClicked: {
                load.enabled = true;
                options.hide();
            }
        }
    }

}
