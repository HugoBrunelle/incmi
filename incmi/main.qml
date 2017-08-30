import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.2
import Qt.labs.settings 1.0
import QtQuick.Controls 2.2
import QtWebSockets 1.1


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
    property string naturedoc: "0"
    property string currentfilename: ""
    property string imgurl: ""
    property variant mess: []

    //Saves the applications setting for what type of user is the admin or not
    Settings {
        id: settings
        //Setting for the type of user. 0 - default, 1 - base, 2 - admin
        property int acess: 0
        property string port: "2565"
        property string host: "192.168.1.147"
        property string name: ""
        property string matricule: ""
        property variant messages: []
    }


    function sendSavedInformation() {
        if (settings.messages.length > 0) {
            if (!msocket.active) {
                msocket.active = true;
            }
        }
    }

    function winchange(win){
        switch (win) {
        case medinventory:

            break;
        }

        currentwindow = win;
        changes = true;
        windowloader.opacity = 0.0;
    }

    function setAccess() {
        if (settings.acess != 0){

        }else{
            windowloader.sourceComponent = login;
        }
    }
    Rectangle {
        anchors.fill: parent
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
                    duration: 275
                    easing.type: Easing.InCubic
                }
                ScriptAction {
                    script: {
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

    Component {
        id:viewer
        DocumentViewer {}
    }

    Component {
        id:pcom
        DocumentPrintViewer {}
    }

    Component {
        id: sets
        SettingsWindow {}
    }

    function getDocImage(filename) {
        currentfilename = filename;
        imgloader.active = true;
    }

    function gToImage() {
          if (imgloader.active) {
                imgloader.item.grabToImage(function(obj) {imageRendered(obj);});
          }
    }

    function imageRendered(obj) {
        if (imgloader.active) {
            imgurl = obj.url;
            imgloader.active = false;
            winchange(viewer);
        }
    }

    Loader {
       id: imgloader
       visible: false
       active: false
       sourceComponent: pcom
    }


    BaseSocket {
        id: msocket
        port: settings.port
        host: settings.host
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                for (var i = 0; i < mess.length; i++) {
                    msocket.sendTextMessage(mess[i]);
                }
                for (var b = mess.length; b > 0; b--) {
                    mess.splice(b-1,1);
                }
                settings.messages = mess;
                msocket.active = false;
                break;
            case WebSocket.Error:
                console.log(errorString);
                break;
            }
        }
    }
}
