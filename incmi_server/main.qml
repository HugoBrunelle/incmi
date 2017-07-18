import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.0
import Qt.labs.settings 1.0
import FileIO 1.0

ApplicationWindow {
    id: applic
    visible: true
    width: 1280
    height: 720
    title: qsTr("IncMi Server")
    property bool senabled: false;

    Settings {
        id: settings
        property string sport: "443"
        property string shost: "localhost"
        property string saccount: "admin"
        property string spass: "incmi2017"
        property string smpush: "30"
    }


    function logMessage(mess) {
        textboxt += ("\n" + mess);
    }

    Material.accent: colora
    /*
    Connections{
        target: applic
        onActiveChanged: {
            if (!applic.active) {
                Qt.quit();
            }
        }
    }
    */
    property string ipv4: "null"
    property string subnetmask: "null"
    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"
    property string textboxt: ""
    property string invfolder: "invitems"
    property string backupfolder: "backups"
    property string docsfolder: "docs"
    property string invtotal: "invtots.incmi"


    Component.onCompleted: {
        load.sourceComponent = login;
        if (!file.dirExist(invfolder)){
            file.makeDirectory(invfolder);
        }
        if (!file.dirExist(docsfolder)){
            file.makeDirectory(docsfolder);
        }
        file.cd(invfolder);
        var names = file.getFileNames();
        var exists;
        for (var i = 0; i < names.length; i++){
            var f = names[i];
            if (f === invtotal){
                exists = true;
            }
        }

        if (!exists) {
            file.writeFile('{"messageindex": "0","items": []}',invtotal);
        }
        file.resetDirectory();
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
        port: settings.sport == null ? 2565 : settings.sport
        host: settings.shost == "localhost" ? ipv4 : settings.shost
        listen: senabled
        onClientConnected: {
            console.log("client connected");
            webSocket.onTextMessageReceived.connect(function(message) {
                messReceived(message,webSocket)
            });
        }
        onErrorStringChanged: {
            onError(errorString);
        }
    }

    FileIO {
        id: file
    }



    function messReceived(message, socket){
        console.log("received a message");
        logMessage(new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---") + " Message received from client, processing...");
        var jsonobj = JSON.parse(message);
        switch(parseInt(jsonobj.messageindex)){
        case 0:
            //Request Inventory
            socket.sendTextMessage(createInventoryClient());
            break;
        case 1:
            //Request list of latest doc and inv commits
            socket.sendTextMessage(createChangesList());
            break;
        case 2:
            //Request doc information
            socket.sendTextMessage(createDocInformation(jsonobj.filename));
            break;
        case 3:
            //Add document
            socket.sendTextMessage(createDocument(jsonobj));
            break;
        case 4:
            socket.sendTextMessage(appendInventory(jsonobj));
            //Add inventory change
            break;
        case 5:
            logMessage(new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---") + " Client received message succesfully...");
            break;
        }
    }

    function onError(message){
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + " Error Message:: " + message);
    }


    function createInventoryClient() {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending the inventory to client");
        var result;
        if (file.dirExist(invfolder)){
            file.cd(invfolder);
            var b = file.getFileNames();
            for(var i = 0; i < b.length; i++){
                if (b[i] === invtotal){
                    result = file.readFile(b[i]);
                }
            }
        }else {
            file.makeDirectory(invfolder);
        }
        file.resetDirectory();
        return result;
    }
    function createInventoryServer() {
        var result;
        if (file.dirExist(invfolder)){
            file.cd(invfolder);
            var b = file.getFileNames();
            for(var i = 0; i < b.length; i++){
                if (b[i] === invtotal){
                    result = file.readFile(b[i]);
                }
            }
        }else {
            file.makeDirectory(invfolder);
        }
        file.resetDirectory();
        return result;
    }


    function createChangesList() {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending changes list to client");
        var jsobj = JSON.parse('{"messageindex": 1,"items" : []}');
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                //Check the file type to make certain no idiot placed a weird item to fuck the loop
                var ff = fs[i];
                if (ff.split(".")[1] === "incmi"){
                    //An incmi database file, okay to parse...
                    var tobj = JSON.parse(file.readFile(ff));
                    var tpush;
                    switch (tobj.type) {
                    case "inv":
                        tpush ='{ "name": "' + tobj.name + '", "matricule":"' + tobj.matricule + '", "type":"' + tobj.type + ',"filename":"' + ff + '"}';
                        break;

                    case "docs":
                        tpush ='{ "name": "' + tobj.name + '", "date":"' + tobj.date + '", "location":"' + tobj.location +'", "nature":"' + tobj.nature + '", "type":"' + tobj.type +',"filename":"' + ff + '"}';
                        break;
                    }

                    jsobj.items.push(tpush);
                }
            }

        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }


    function createDocInformation(filename) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending doc information for: " + filename + " to client");
        var jsobj;
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename === fs[i]){
                    // The correct file to send the date...
                    jsobj = JSON.parse(file.readFile(filename));
                }
            }
        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }

    function createDocument(jsobj){
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client sent in a new document, processing...");
        var fname;
        var jmess = JSON.parse('{ "messageindex": "5", "error" : "" }')
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            fname = getRandomName() + ".incmi";
            if(file.writeFile(JSON.stringify(jsobj),fname)){
                jmess.message = false;
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client document saved");
            }else{
                jmess.message = true;
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving client document");
            }
        }
        file.resetDirectory();
        return JSON.stringify(jmess);
    }

    function getRandomName() {
        var check = true;
        var name;
        while (check){
            name = Math.floor(Math.random() * 1000000).toString();
            var fs = file.getFileNames();
            for (var i = 0; i < fs.length; i++){
                var spl = fs[i].split(".")[0];
                if (spl === name) {
                    continue;
                }
            }
            check = false;
        }
        return name;
    }

    function appendInventory(jsobj) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client sent in new inventory commit, processing...");
        var result;
        var jmess = JSON.parse('{ "messageindex": "5", "error" : "" }')
        if (file.dirExist(invfolder)){
            file.cd(invfolder);
            var b = file.getFileNames();
            for(var i = 0; i < b.length; i++){
                if (b[i] === invtotal){
                    result = file.readFile(b[i]);
                }
            }
            if (result !== "") {
                var tobj = JSON.parse(result);
                for (var d = 0; d < jsobj.items.length; d++){
                    var ifrom = jsobj.items[d];
                    for (var c = 0; c < tobj.items.length; c++){
                        var isave = tobj.items[c];
                        if (tp.tag === cinvitem.tag) {
                            isave.count = ifrom.count;
                        }
                    }
                }
                if (file.writeFile(JSON.stringify(tobj),invtotal)){
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Saved and added commit from the client");
                } else {
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error adding the commit from the client");
                }
            }
            file.cdUp();
            if (file.dirExist(docsfolder)){
                file.cd(docsfolder);
                fname = getRandomName() + ".incmi";
                if(file.writeFile(JSON.stringify(jsobj),fname)){
                    jmess.message = false;
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client inventory commit saved");
                }else{
                    jmess.message = true;
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving client inventory commit");
                }
            }
        }else {
            file.makeDirectory(invfolder);
        }
        file.resetDirectory();
        return JSON.stringify(jess);
    }

    function createInventoryItem(jobj) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server adding a new inventory item");
        if (file.dirExist(invfolder)) {
            file.cd(invfolder);
            var names = file.getFileNames();
            var exists = false;
            for (var i = 0; i < names.length; i++){
                if (names[i] === invtotal){
                    exists = true;
                }
            }

            if (exists){
                var obj = JSON.parse(file.readFile(invtotal));
                obj.items.push(jobj);
                if (file.writeFile(JSON.stringify(obj),invtotal)){
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server succesfully added new inventory item");
                }
            }
            file.resetDirectory();
        }
    }

    function removeInventoryItem(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server request to remove an inventory item");
        var result = false;
        if (file.dirExist(invfolder)) {
            file.cd(invfolder);
            var names = file.getFileNames();
            var exists = false;
            for (var i = 0; i < names.length; i++) {
                if (names[i] === invtotal){
                    exists = true;
                }
            }
            if (exists) {
                var obj = JSON.parse(file.readFile(invtotal));
                var index = -1;
                for (var b = 0; b < obj.items.length; b++){
                    var item = obj.items[b];
                    console.log(item.tag);
                    console.log(jobj.tag);
                    if (item.tag == jobj.tag){
                        index = b;
                    }
                }
                console.log(index);

                if (index != -1) {
                    obj.items.splice(index, 1);
                    if (file.writeFile(JSON.stringify(obj),invtotal)){
                        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server succesfully removed inventory item");
                        result = true;
                    }
                    else {
                        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server failed to remove inventory item");
                    }
                }
            }
        }
        file.resetDirectory();
        return result;
    }

    function editInventoryItem(jobj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server request to edit an inventory item");
        var result = false;
        if (file.dirExist(invfolder)) {
            file.cd(invfolder);
            var names = file.getFileNames();
            var exists = false;
            for (var i = 0; i < names.length; i++) {
                if (names[i] === invtotal){
                    exists = true;
                }
            }
            if (exists) {
                var obj = JSON.parse(file.readFile(invtotal));
                for (var b = 0; b < obj.items.length; b++){
                    var item = obj.items[b];
                    if (item.tag == jobj.tag){
                        item.name = jobj.name;
                        item.count = jobj.count;
                        item.rcount = jobj.rcount;
                    }
                }
                if (file.writeFile(JSON.stringify(obj),invtotal)){
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server succesfully edited inventory item");
                    result = true;
                }
                else {
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server failed to edit inventory item");
                }
            }
        }
        file.resetDirectory();
        return result;
    }
    function getRandomTag(){
        var tag = Math.floor(Math.random() * 1000000);
        if (file.dirExist(invfolder)) {
            file.cd(invfolder);
            var names = file.getFileNames();
            var exists = false;
            for (var i = 0; i < names.length; i++) {
                if (names[i] === invtotal) {
                    exists = true;
                }
            }

            if (exists) {
                var obj = JSON.parse(file.readFile(invtotal));
                var cont = true;
                while (cont) {
                    var same = false;
                    for (var b = 0; b < obj.items.length; b++) {
                        if (obj.items[b].tag == tag) {
                            tag = Math.floor(Math.random() * 1000000);
                            same = true;
                        }
                    }
                    if (!same) {
                        cont = false;
                    }
                }
            }
        }
        file.resetDirectory();
        return tag;
    }

    function generateDocument(obj) {
        // Generate the document using a QtObject or a component

    }

    function exportDocument(obj) {
        // Export the document to pdf, and ask the server where to save the object
    }
}
