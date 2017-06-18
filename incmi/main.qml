import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0

Window {

    id: window
    visible: true
    title: qsTr("Inc. Med.")


    //                              All global properties
    property string textcolor: "white"
    property var currentwindow
    property bool changes

    //Gets the device screen dimensions, always 0,0 (x,y) for position in android.
    property int wheight
    property int wwidth

    // Default global font size. We have to find a way to change the default font.
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


    // Window events
    Component.onCompleted:
    {
        wwidth = Screen.width
        wheight = Screen.height
        // Calculates the scale based on the window size
        /*
          Basic logic is that we compare the aspect ratio to get a base for the scaling
          we then find the average distance difference of all sides of the window (margins will correct the distance)
          area - area / 4 gives the average distance of each side.. this with the aspect ratio gives us the scaling factor
        */
        var scalefactor = (((wheight/wwidth)-(640/360)) * (((wheight/wwidth) * ((640/360)))/4));
        mscale = 1 + scalefactor;
        fontscale = 1 - (scalefactor * 4);
        if (mscale == 0) mscale = 1;
        // Verifies access to show the correct form.
        if (accessSetting.acess != 0){
            //login.main.visible = false;
        }else{
            windowloader.sourceComponent = login;
        }
        console.log("window height" + wheight.toString());
        console.log("window width" + wwidth.toString());
        console.log("window scale factor" + mscale.toString());
        console.log("text scale factor" + fontscale.toString());
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
    Component {
        id : login
        MainForm {
            id: main
            scale: mscale
            anchors.fill: parent
            //calls the alias of the submit button
            ubase.onClicked: {
                //set accessSetting
                winchange(inform);

            }
            submitbut.onClicked: {
                rpassword.visible = false;
                ll.enabled = true;
                //accessSetting.acess = 1;
            }
            uadmin.onClicked: {
                rpassword.visible = true;
                ll.enabled = false;
                console.log(rpassword.state.toString());
            }
        }
    }

    Component {
        id: inform
        IntroForm {


        }

    }
    // All different windows and their logic
    Component {
        id: medimain
        MedicMain {

        }
    }


}
