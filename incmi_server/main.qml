import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.0
import Qt.labs.settings 1.0
import FileIO 1.0

ApplicationWindow {
    id: mainwindow
    visible: true
    width: 1280
    height: 720
    title: qsTr("IncMi Server")
    property bool senabled: false;

    Settings {
        property string port;
    }



    Material.accent: colora
    Connections{
        target: mainwindow
        onActiveChanged: {
            if (!mainwindow.active) {
                Qt.quit();
            }
        }
    }

    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"


    property string invfolder: "invitems"
    property string backupfolder: "backups"
    property string docsfolder: "docs"
    property string invtotal: "invtots.incmi"

    Component.onCompleted: {
        load.sourceComponent = wmain;
        console.log(file.getCurrentDirName());

        if (file.dirExist(invfolder)){
            file.cd(invfolder);
            var path = file.getCurrentPath();
            var b = file.getFileNames();
            console.log(b.length);
            for(var i = 0; i < b.length; i++){
                file.setSourceDir(b[i]);
                console.log((path + "/" + invfolder + "/" + b[i]).toString());
                var fi = file.readFile(path + "/" + invfolder + "/" + b[i]);
                console.log(fi);
                var jsobj = JSON.parse(fi);
                for(var c = 0; c < jsobj.items.length; c++){
                    var obj = jsobj.items[c];
                    console.log(obj.name + " " + obj.count + " " + obj.rcount);
                }
            }

            console.log("in invfolder");


        }else {
            console.log("Creating inv folder");
            file.makeDirectory(invfolder);
            console.log(file.dirExist(invfolder));
        }
    }


    Rectangle {
        anchors.fill: parent
        color: colorlt
    }

    AsyncQAnimatedLoader {
        id: load
    }

    Component {
        id: wmain
        MainWindow {
            id: cmain
        }
    }

    Component {
        id: login
        LoginWindow {
            id: lmain
        }
    }

    OptionsWindow {
        id: options
        anchors.fill: parent
    }


    WebSocketServer {
        id: server
        port: port == null ? 2345 : port
        listen: senabled

        onClientConnected: {
            webSocket.onTextMessageReceived.connect(messReceived(message,webSocket));
        }
        onErrorStringChanged: {
            onError(errorString);
        }

    }

    function messReceived(message, socket){
        var jsonobj = JSON.parse(message);
        switch(parseInt(jsonobj.messageindex)){
        case 0:
            //Request Inventory
            if (file.dirExist(invfolder)){
                file.cd(invfolder);
                console.log("in invfolder");


            }else {
                console.log("Creating inv folder");
                file.makeDirectory(invfolder);
                console.log(file.dirExist(invfolder));
            }

            break;
        case 1:
            //Request list of latest doc and inv commits
            break;
        case 2:
            //Request doc information
            break;
        case 3:
            //Add document
            break;
        case 4:
            //Add inventory change
            break;
        }
    }

    function onError(message){
        cmain.logmess((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + " Error Message:: " + message);
    }

    FileIO {
        id: file
    }



}
