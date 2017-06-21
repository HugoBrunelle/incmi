import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0

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
    property color colorp: "#607D8B"
    property color colorlp: "#CFD8DC"
    property color colordp: "#455A64"
    property color colora: "#FF5252"

    //Sets the global color accents and primary
    Material.accent: colora
    Material.primary: colorp

    onHeightChanged: {
        setscales();
        rotate();
    }

    onWidthChanged: {
        rotate;
        setscales();
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



    // Calculates the scale based on the window size
    /*
      Basic logic is that we compare the aspect ratio to get a base for the scaling
      we then find the average distance difference of all sides of the window (margins will correct the distance)
      area - area / 4 gives the average distance of each side.. this with the aspect ratio gives us the scaling factor
    */
    // Verifies access to show the correct form.

    function setscales() {
        var scalefactor = (((wheight/wwidth)-(640/360)) * (((wheight/wwidth) * ((640/360)))/4));
        mscale = 1 + scalefactor;
        fontscale = 1 - (scalefactor * 4);
        if (mscale <= 0) mscale = 1;
        if (fontscale <= 0) fontscale = 0.1;
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
                console.log("landscape");
            }else if (orientationToString(Screen.primaryOrientation) === "portrait") {
                console.log("portrait");
            }
        }
        lastrotation = Screen.primaryOrientation
    }

    function setPortrait() {
        //Do all the portrait modification code necessary here.
    }

    function setLandscape() {
        // Do all the landscape modification code necessary here.


    }

    function setAccess() {
        // Do all the code changes related to the access being set.
        if (accessSetting.acess != 0){

        }else{
            //Load the login form.
            windowloader.sourceComponent = login;
        }
    }


    // Window events
    Component.onCompleted:
    {
        wwidth = Screen.width
        wheight = Screen.height
        //Sets rotation values initially
        var orien = Screen.primaryOrientation
        if (orientationToString(orien) === "landscape") {
            rotate();
        }else
        {
            lastrotation = orien;
        }
        setscales();
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
                    duration: 1000
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
                rpassword.visible = false;
                ll.enabled = true;
                //set accessSetting
            }
            uadmin.onClicked: {
                rpassword.visible = true;
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

            }

        }

    }

    // The main medical form.
    Component {
        id: medimain
        MedicMain {
            id: medmain
        }
    }


}
