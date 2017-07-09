import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0
import QtQuick.Controls 2.1
import QtQuick.LocalStorage 2.0


Window {
    id: window
    height: 640
    width: 360
    visible: true
    title: qsTr("Inc. Med.")

    //                              All global properties
    property var currentwindow
    property bool changes

    /*  Main material color scheme (to be applied to all controls.
        colorb  Border color / seperator /
        colorst Secondary text color
        colort  primary text color
        colorp  primary back color
        colorlp primary light color
        colordp dark primary back color
        colora  accentuated object color (accent)
    */

    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"

    //Saves the applications setting for what type of user is the admin or not
    Settings {
        id: accessSetting
        //Setting for the type of user. 0 - default, 1 - base, 2 - admin
        property int acess: 0
    }

    function winchange(win){
        currentwindow = win;
        changes = true;
        windowloader.opacity = 0.0;
    }

    onActiveChanged: {
        if (!window.active) {
            Qt.quit();
        }
    }

    function setAccess() {
        if (accessSetting.acess != 0){

        }else{
            windowloader.sourceComponent = login;
        }
    }
    Rectangle {
        anchors.fill: parent
        Material.background: colorlt
    }


    // Window events
    Component.onCompleted:
    {
        setAccess();
    }

    Loader {
        id: windowloader
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
                        console.log("End of loader animation")
                        if (windowloader.opacity == 0.0 && changes) {
                            windowloader.sourceComponent = currentwindow;
                            changes = false;
                        }
                    }
                }
            }
        }
    }


    // All different pages (Placed in components so we can dynamically load them and avoid using system ram on cheap devices lol...



    //The fo
    Component {
        id : login
        MainForm { }
    }
    Component {
        id: inform
        IntroForm { }
    }
    Component {
        id: medimain
        MedicMain { }
    }
    Component {
        id: medinventory
        MedViewInventory { }
    }
    Component {
        id: adjinv
        MedInvAdjustment { }
    }
    Component {
        id:meddocrs
        MedDocRapportPremierSoins { }
    }
}
