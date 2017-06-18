import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls.Material 2.1
import Qt.labs.settings 1.0

Window {

    id: window
    visible: true
    width: wwidth
    height: wheight
    title: qsTr("Inc. Med.")


    //                              All global properties
    property string textcolor: "white"

    //Gets the device screen dimensions, always 0,0 (x,y) for position in android.
    property int wheight: Screen.height
    property int wwidth: Screen.width

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
    Material.accent: Material.LightBlue
    Material.primary: Material.BlueGrey
    //Saves the applications setting for what type of user is the admin or not
    Settings {
        id: accessSetting
        //Setting for the type of user. 0 - default, 1 - base, 2 - admin
        property int acess: 0
    }


    // Window events

    Component.onCompleted:
    {
        mscale = ((640*340)/(Screen.height * Screen.width));
        if (mscale == 0) mscale = 1;
        //fontscale = (wwidth-300)/300;
        console.log(mscale.toString());
        if (accessSetting.acess != 0){
            main.visible = false;
        }else{
            main.visible = true;
        }
        console.log(Screen.height)
        console.log(Screen.width)
    }

    MainForm {
        id: main
        scale: mscale
        anchors.fill: parent
        //calls the alias of the submit button
        submitbut.onClicked: {
            rpassword.state = "hidden"
            //accessSetting.acess = 1;
            //Hide the form and go to the next main, transition slide...
        }

        //calls the alias of the administrator button
        uadmin.onClicked: {
            rpassword.state = "show";
            console.log(rpassword.state.toString());
        }




    }


}
