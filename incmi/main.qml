import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0
import QtQuick.Controls 2.1

Window {
    id: window
    height: 640
    width: 360
    visible: true
    title: qsTr("Inc. Med.")


    //                              All global properties
    property string textcolor: "white"
    property var currentwindow
    property string lastrotation
    property bool changes
    property int wheight
    property int wwidth
    property real fontscale: 1
    property real mscale: 1
    property bool landscape: false

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

    //Sets the global color accents and primary


    onHeightChanged: {
        rotate();
    }

    onWidthChanged: {
        rotate;
    }

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


    function orientationToString(o) {
            switch (o) {
            case Qt.PrimaryOrientation:
                return "primary";
            case Qt.PortraitOrientation:
                return "portrait";
            case Qt.LandscapeOrientation:
                return "landscape";
            case Qt.InvertedPortraitOrientation:
                return "inverted portrait";
            case Qt.InvertedLandscapeOrientation:
                return "inverted landscape";
            }
            return "unknown";
        }

    // Do the orientation...
    function rotate() {
        if (Screen.primaryOrientation !== lastrotation)
        {
            if (orientationToString(Screen.primaryOrientation) === "landscape"){
                landscape = true;
            }else if (orientationToString(Screen.primaryOrientation) === "portrait") {
                landscape = false;
            }
        }
        lastrotation = Screen.primaryOrientation
    }

    function setAccess() {
        if (accessSetting.acess != 0){

        }else{
            windowloader.sourceComponent = login;
        }
    }


    // Window events
    Component.onCompleted:
    {
        //Sets rotation values initially
        var orien = Screen.primaryOrientation;
        if (orientationToString(orien) === "landscape") {
            rotate();
        }else
        {
            lastrotation = orien;
        }
        setAccess();
    }

    BackgroundBase {
        anchors.fill: parent
        color: "white"
        // Just to always have a basic window background between loads
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
            id: anime
            SequentialAnimation {
                NumberAnimation {
                    duration: 600
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
        MainForm {
            id: main
            scale: mscale
            anchors.fill: parent
            ubase.onClicked: {
                //set accessSetting
                winchange(inform);

            }
            submitbut.onClicked: {
                rpassword.hide();
                ll.enabled = true;
                //set accessSetting
            }
            uadmin.onClicked: {
                rpassword.show();
                ll.enabled = false;
            }
        }
    }
    // The form between verifying the medical or incendinary database
    Component {
        id: inform
        IntroForm {
            incbutton.onClicked: {
                winchange(login);
            }
            medbutton.onClicked: {
                winchange(medimain);
            }

        }

    }

    // The main medical form.
    Component {
        id: medimain
        MedicMain {
            back.onClicked: {
                winchange(inform);
            }
            inv.onClicked: {
                winchange(medinventory);
            }
            ndossier.onClicked: {
                ndprompt.show();
                medimainll.enabled = false;
            }
            bleger.onClicked: {
                ndprompt.hide();
                medimainll.enabled = true;
            }
            bmoderer.onClicked: {
                winchange(meddocrs);
            }
            bsever.onClicked: {

            }
        }
    }

    Component {
        id: medinventory
        MedViewInventory {
            invback.onClicked: {
                winchange(medimain);
            }
            invadjust.onClicked: {
                winchange(adjinv);
            }
        }
    }

    Component {
        id: adjinv
        MedInvAdjustment {
            adjcancel.onClicked: {
                winchange(medinventory);
            }
            adjsave.onClicked: {
                winchange(medinventory);
                // Show matricule and name
            }
        }
    }

    Component {
        id:meddocrs
        MedDocRapportPremierSoins {
            meddoccancel.onClicked: {
                winchange(medimain);
            }
        }
    }


}
