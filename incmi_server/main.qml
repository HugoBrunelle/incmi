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
        property string semaccount
        property string sempassword
        property bool scnew: false
        property bool scedit: false
        property bool scremind: false
        property bool scremove: false
        property bool scadmincommit: false
        property bool scbackup: false

    }


    function logMessage(mess) {
        if (textboxt.length > 12000) {
            textboxt = "";
        }

        textboxt += ("\n" + mess);
    }

    Material.accent: colora
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
    property string incdocfolder: "incd"
    property string docsfolder: "docs"
    property string peoplefolder: "ppl"
    property string invtotal: "invtots.incmi"
    property string eventfolder: "evt"
    property string eventsfilename: "events.incmi"
    property string invbase: '{"messageindex": "0","items": []}'
    property string eventbase: '{"items":[]}'
    property string eventitembase: '{"date":"","hour":"","lieu":"","details":"","people":[],"tag":""}'
    property string peoplebase: '{"firstname":"","lastname":"","email":"","matricule":"","role":"","filename":"","isadmin":"false"}'
    property string changeslistbase: '{"messageindex": 1,"items" : []}'
    property string documentitembase: '{"messageindex":"1","name":"","matricule":"","type":"","filename":"","dateint":"","ville":"","nature":""}'
    property string peoplelistbase: '{"items":[]}'
    property string inventoryitembase: '{"name":"", "count":"", "rcount":"", "tag":""}'
    property string invadjustmentbase: '{"messageindex":"4","matricule":"","type":"inv","name":"","filename":"","items":[]}'
    property string serversettingsbase: '{"sport":"","shost":"","saccount":"","spass":"","smpush":"","semaccount":"","sempassword":"","scnew":"","scedit":"","scremind":"","scremove":"","scadmincommit":"","scbackup":""}'
    property string incdocumentbase: '{"date":"","name":"","matricule":"","time":"","adresse":"","ville":"","type":"","people":[],"other":[],"femme":"","homme":"","enfant":"","materiel":[]}'
    property string incchangeslistbase: '{"date":"","time":"","adresse":"","ville":"","type":"","filename":""}'
    property string incchangesbase: '{"items":[]}'
    property string fname
    property bool iscreated: true

    Component.onDestruction: {
        //Cleanup
        removeTempImage();
    }


    Component.onCompleted: {
        //Load
        load.sourceComponent = wmain;
        if (!file.dirExist(invfolder)){
            file.makeDirectory(invfolder);
        }
        if (!file.dirExist(docsfolder)){
            file.makeDirectory(docsfolder);
        }
        if (!file.dirExist(peoplefolder)){
            file.makeDirectory(peoplefolder);
        }
        if (!file.dirExist(eventfolder)){
            file.makeDirectory(eventfolder);
        }
        if (!file.dirExist(backupfolder)) {
            file.makeDirectory(backupfolder);
        }
        if (!file.dirExist(incdocfolder)) {
            file.makeDirectory(incdocfolder);
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
            file.writeFile(invbase,invtotal);
        }
        file.cdUp();
        file.cd(eventfolder);
        names = file.getFileNames();
        exists = false;
        for (i = 0; i < names.length; i++){
            var b = names[i];
            if (b === eventsfilename){
                exists = true;
            }
        }
        if (!exists) {
            file.writeFile(eventbase,eventsfilename);
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
    Component {
        id: pdocajust
        DocAjustementPrint {
        }
    }

    Component {
        id: pinvadjust
        InvAdjustmentPrint {}
    }

    Component {
        id: pinvent
        InventairePrint {}
    }

    Component {
        id: pincprint
        IncRapportDocumentPrint {}
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
            webSocket.onTextMessageReceived.connect(function(message) {
                messReceived(message,webSocket);
            });
        }
        onErrorStringChanged: {
            onError(errorString);
        }
    }

    Timer {
        id: eventtimer
        triggeredOnStart: false;
        running: false;
        repeat: true;
        onTriggered: {
            interval = 86400000;
            checkForEventsAndEmail();
            doBackup();
        }

    }

    FileIO {
        id: file
    }

    function doBackup() {
        if (settings.scbackup) {
            if (!file.dirExist(backupfolder)) file.makeDirectory(backupfolder);
            var folname = new Date().toLocaleDateString(Qt.locale(),"M_dd_yyyy") + "_bac";
            file.cd(backupfolder);
            while (file.dirExist(folname)) {
                folname += "1";
            }
            if (!file.dirExist(folname)) file.makeDirectory(folname);
            file.resetDirectory();
            doInvBackup(folname);
            doDocsBackup(folname);
            doEventsBackup(folname);
            doPeopleBackup(folname);
            doIncDocsBackup(folname);
        }
    }

    function doDocsBackup(folname) {
        if (file.dirExist(docsfolder)) {
            file.cd(docsfolder);
            var names = file.getFileNames();
            var ffs = []
            for (var i = names.length; i > 0; i--) {
                console.log(names.length + " and this is the count" + i);
                var f = names[i-1];
                if (f.split(".")[1] != "incmi") {
                    names.splice(i-1,1);
                }else {
                    ffs.push(file.readFile(f));
                }
            }
            file.resetDirectory();
            file.cd(backupfolder);
            file.cd(folname);
            file.makeDirectory(docsfolder);
            file.cd(docsfolder);
            for (var b = 0; b < ffs.length; b++) {
                file.writeFile(ffs[b],names[b]);
            }
            file.resetDirectory();
        }
    }

    function doIncDocsBackup(folname) {
        if (file.dirExist(incdocfolder)) {
            file.cd(incdocfolder);
            var names = file.getFileNames();
            var ffs = []
            for (var i = names.length; i > 0; i--) {
                console.log(names.length + " and this is the count" + i);
                var f = names[i-1];
                if (f.split(".")[1] != "incmi") {
                    names.splice(i-1,1);
                }else {
                    ffs.push(file.readFile(f));
                }
            }
            file.resetDirectory();
            file.cd(backupfolder);
            file.cd(folname);
            file.makeDirectory(incdocfolder);
            file.cd(incdocfolder);
            for (var b = 0; b < ffs.length; b++) {
                file.writeFile(ffs[b],names[b]);
            }
            file.resetDirectory();
        }
    }

    function doPeopleBackup(folname) {
        if (file.dirExist(peoplefolder)) {
            file.cd(peoplefolder);
            var names = file.getFileNames();
            var ffs = []
            for (var i = names.length; i > 0; i--) {
                var f = names[i-1];
                if (f.split(".")[1] != "incmi") {
                    names.splice(i-1,1);
                }else {
                    ffs.push(file.readFile(f));
                }
            }
            file.resetDirectory();
            file.cd(backupfolder);
            file.cd(folname);
            file.makeDirectory(peoplefolder);
            file.cd(peoplefolder);
            for (var b = 0; b < ffs.length; b++) {
                file.writeFile(ffs[b],names[b]);
            }
            file.resetDirectory();
        }
    }

    function doEventsBackup(folname) {
        if (file.dirExist(eventfolder)) {
            file.cd(eventfolder);
            var names = file.getFileNames();
            for (var i = 0; i < names.length; i++) {
                var f = names[i];
                if (f == eventsfilename) {
                    var tmp = file.readFile(eventsfilename);
                    file.resetDirectory();
                    file.cd(backupfolder);
                    file.cd(folname);
                    file.makeDirectory(eventfolder);
                    file.cd(eventfolder);
                    file.writeFile(tmp, eventsfilename);
                }
            }
            file.resetDirectory();
        }
    }


    function doInvBackup(folname) {
        if (file.dirExist(invfolder)) {
            file.cd(invfolder);
            var names = file.getFileNames();
            for (var i = 0; i < names.length; i++) {
                var f = names[i];
                if (f == invtotal) {
                    var tmp = file.readFile(invtotal);
                    file.resetDirectory();
                    file.cd(backupfolder);
                    file.cd(folname);
                    file.makeDirectory(invfolder);
                    file.cd(invfolder);
                    file.writeFile(tmp, invtotal);
                }
            }
            file.resetDirectory();
        }
    }

    function sendAdminsCommits(type,cname) {
        if (!pppload.active){
            if (settings.scadmincommit) {
                switch (type) {
                case "docs":
                    pppload.sourceComponent = pdocajust;
                    break;
                case "inv":
                    pppload.sourceComponent = pinvadjust;
                    break;
                case "inc":
                    pppload.sourceComponent = pincprint;
                    break;
                }
                fname = cname.split(".")[0];
                pppload.active = true;
            }
        }
    }

    function imRendered(obj) {
        obj.saveToFile(fname + ".png");
        file.printToPDF(fname);
        var ppl = requestPeopleListServer()
        var pp = []
        for (var i = 0; i < ppl.items.length; i++) {
            var pers = ppl.items[i];
            if (pers.isadmin && pers.email != ""){
                pp.push(pers.email);
            }
        }
        if (settings.semaccount != "" && settings.sempassword != "") {
            if (!iscreated) {
                iscreated = true;
                file.sendEmailWithAttachment(settings.semaccount, settings.sempassword, pp, "Incmi: Document", "The following document has been requested to be emailed",file.getApplicationPath() + "/" + fname + ".pdf");
            }else {
                file.sendEmailWithAttachment(settings.semaccount, settings.sempassword, pp, "Incmi: Commit Added", "The following document has been added to the database",file.getApplicationPath() + "/" + fname + ".pdf");
            }
        }
        pppload.active = false;
    }

    Loader {
        visible: false;
        active: false;
        id: pppload;
        sourceComponent: pdocajust

        onStatusChanged: {
            if (status == Loader.Ready) {
                if (active) {
                    pppload.item.setData(fname);
                    pppload.item.grabToImage(function (obt) {imRendered(obt);});
                }
            }
        }
    }

    function checkForEventsAndEmail(){
        if (settings.scremind) {
            var obj = JSON.parse(requestEventsServer());
            var da = new Date();
            var ev = []
            for (var i = 0; i < obj.items.length; i++){
                var ob = obj.items[i];
                if (ob.date.split(":")[0] == da.getDate() + 1 && ob.date.split(":")[1] == da.getMonth() + 1 && ob.date.split(":")[2] == da.getFullYear()){
                    ev.push(JSON.stringify(ob));
                }
            }
            for (var b = 0; b < ev.length; b++) {
                var e = JSON.parse(ev[b]);
                var ppl = []
                for (var c = 0; c < e.people.length; c++) {
                    var pers = JSON.parse(e.people[c]);
                    if (pers.email != "") ppl.push(pers.email);
                }
                if (settings.semaccount != "" && settings.sempassword != ""){
                    file.sendEmail(settings.semaccount, settings.sempassword, ppl,"Incmi: Rappel d'evenements | " + getDateString(e.date), "Ceci est un rappel que vous avez un evenements qui est ceduler a: " + e.hour + "\n A: " + e.lieu + "\n" + e.details)
                }
            }
        }
    }

    function setServerState(cond) {
        senabled = cond;
        if (cond) {
            var da = new Date();
            var mil = ((da.getHours()*60 + da.getMinutes())*60 + da.getSeconds())*1000 + da.getMilliseconds();
            console.log(mil);
            var val;
            if (mil <= 21600000) {
                val = 21600000 - mil;
            }else {
                val = 86400000 - mil + 21600000;
            }
            eventtimer.interval = val;
            eventtimer.running = true;
            console.log(eventtimer.interval);
        }else {
            eventtimer.running = false;
        }
    }

    function removeTempImage() {
        console.log("Running");
        var items = file.getFileNames();
        for (var i = 0; i < items.length; i++) {
            if (items[i].split(".")[1] == "png") {
                file.removeFile(items[i]);
            }
            if (items[i].split(".")[1] == "pdf") {
                file.removeFile(items[i]);
            }
        }
    }



    function messReceived(message, socket){
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
            socket.sendTextMessage(requestPeopleListClient());
            break;
        case 6:
            socket.sendTextMessage(editInventoryItemClient(jsonobj));
            break;
        case 7:
            socket.sendTextMessage(removeInventoryItemClient(jsonobj));
            break;
        case 8:
            socket.sendTextMessage(createInventoryItemClient(jsonobj));
            break;
        case 9:
            sendDocumentEmailClient(jsonobj.filename);
            break;
        case 10:
            removeDocumentClient(jsonobj.filename);
            break;
        case 11:
            socket.sendTextMessage(requestEventsClient());
            break;
        case 12:
            editEventItemClient(jsonobj);
            break;
        case 13:
            createEventItemClient(jsonobj);
            break;
        case 14:
            removeEventItemClient(jsonobj);
            break;
        case 15:
            removePersonClient(jsonobj);
            break;
        case 16:
            editPersonClient(jsonobj);
            break;
        case 17:
            createPersonClient(jsonobj);
            break;
        case 18:
            appendServerSettingsClient(jsonobj);
            break;
        case 19:
            socket.sendTextMessage(requestServerSettings());
            break;
        case 20:
            createIncendieDocument(jsonobj);
            break;
        case 21:
            socket.sendTextMessage(createIncChangesList());
            break;
        case 22:
            socket.sendTextMessage(createIncDocInformation(jsonobj.filename));
            break;
        case 23:
            sendDocumentEmailClientInc(jsonobj.filename);
            break;
        case 24:
            sendDocumentEmailClientInv();
            break;
        case 25:
            removeIncDocumentClient(jsonobj.filename);
            break;
        }
    }

    function onError(message){
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + " Error Message:: " + message);
    }

    function appendServerSettingsClient(obj) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client has made changes to the server settings.. Appending...");
        settings.sport = obj.sport;
        settings.shost = obj.shost;
        settings.saccount = obj.saccount;
        settings.spass = obj.spass;
        settings.smpush = obj.smpush;
        settings.semaccount = obj.semaccount;
        settings.sempassword = obj.sempassword;
        settings.scnew = obj.scnew;
        settings.scedit = obj.scedit;
        settings.scremove = obj.scremove;
        settings.scremind = obj.scremind;
        settings.scadmincommit = obj.scadmincommit;
        settings.scbackup = obj.scbackup;
    }

    function requestServerSettings() {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending the server settings to client");
        var obj = JSON.parse(serversettingsbase);
        obj.sport = settings.sport;
        obj.shost = settings.shost;
        obj.saccount = settings.saccount;
        obj.spass = settings.spass;
        obj.smpush = settings.smpush;
        obj.semaccount = settings.semaccount;
        obj.sempassword = settings.sempassword;
        obj.scnew = settings.scnew;
        obj.scedit = settings.scedit;
        obj.scremove = settings.scremove;
        obj.scremind = settings.scremind;
        obj.scadmincommit = settings.scadmincommit;
        obj.scbackup = settings.scbackup;
        return JSON.stringify(obj);
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
        var jsobj = JSON.parse(changeslistbase);
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            var fs = file.getFilteredNames("files","time");
            for(var i = 0; i < fs.length && i < parseInt(settings.smpush); i++){
                var ff = fs[i];
                if (ff.split(".")[1] === "incmi"){
                    //An incmi database file, okay to parse...
                    var tobj = JSON.parse(file.readFile(ff));
                    var tpush = JSON.parse(documentitembase);
                    switch (tobj.type) {
                    case "inv":
                        tpush.name = tobj.name;
                        tpush.matricule = tobj.matricule;
                        tpush.type = tobj.type;
                        tpush.filename = ff.split(".")[0];
                        break;

                    case "docs":
                        tpush.name = tobj.name;
                        tpush.matricule = tobj.matricule;
                        tpush.type = tobj.type;
                        tpush.filename = ff.split(".")[0];
                        tpush.ville = tobj.ville;
                        tpush.date = tobj.dateint;
                        tpush.nature = tobj.nature
                        break;
                    }

                    jsobj.items.push(JSON.stringify(tpush));
                }
            }

        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }

    function createIncChangesList() {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending incendie changes list to client");
        var jsobj = JSON.parse(incchangesbase);
        if (file.dirExist(incdocfolder)){
            file.cd(incdocfolder);
            var fs = file.getFilteredNames("files","time");
            for(var i = 0; i < fs.length && i < parseInt(settings.smpush); i++){
                var ff = fs[i];
                if (ff.split(".")[1] === "incmi"){
                    //An incmi database file, okay to parse...
                    var tobj = JSON.parse(file.readFile(ff));
                    var tpush = JSON.parse(incchangeslistbase);
                    tpush.date = tobj.date;
                    tpush.adresse = tobj.adresse;
                    tpush.ville = tobj.ville;
                    tpush.filename = ff.split(".")[0];
                    tpush.time = tobj.time;
                    tpush.type = tobj.type;
                    jsobj.items.push(JSON.stringify(tpush));
                }
            }

        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }

    function createServerChangesList() {
        var jsobj = JSON.parse(changeslistbase);
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            var fs = file.getFilteredNames("files","time");
            for(var i = 0; i < fs.length && i < parseInt(settings.smpush); i++){
                //Check the file type to make certain no idiot placed a weird item to fuck the loop
                var ff = fs[i];
                if (ff.split(".")[1] === "incmi"){
                    //An incmi database file, okay to parse...
                    var tobj = JSON.parse(file.readFile(ff));
                    var tpush = JSON.parse(documentitembase);
                    switch (tobj.type) {
                    case "inv":
                        tpush.name = tobj.name;
                        tpush.matricule = tobj.matricule;
                        tpush.type = tobj.type;
                        tpush.filename = ff.split(".")[0];
                        break;

                    case "docs":
                        tpush.name = tobj.name;
                        tpush.matricule = tobj.matricule;
                        tpush.type = tobj.type;
                        tpush.filename = ff.split(".")[0];
                        tpush.ville = tobj.ville;
                        tpush.date = tobj.dateint;
                        tpush.nature = tobj.nature
                        break;
                    }

                    jsobj.items.push(JSON.stringify(tpush));
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
                if (filename === fs[i].split(".")[0]){
                    // The correct file to send the date...
                    jsobj = JSON.parse(file.readFile(fs[i]));
                }
            }
        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }

    function createIncDocInformation(filename) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Sending doc information for: " + filename + " to client");
        var jsobj;
        if (file.dirExist(incdocfolder)){
            file.cd(incdocfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename === fs[i].split(".")[0]){
                    // The correct file to send the date...
                    jsobj = JSON.parse(file.readFile(fs[i]));
                }
            }
        }
        file.resetDirectory();
        return JSON.stringify(jsobj);
    }

    function sendDocumentEmailClient(filename) {
        var obj = JSON.parse(createDocInformation(filename));
        if (!pppload.active){
            switch (obj.type) {
            case "docs":
                pppload.sourceComponent = pdocajust;
                break;
            case "inv":
                pppload.sourceComponent = pinvadjust;
                break;
            }
            fname = filename.split(".")[0];
            iscreated = false;
            pppload.active = true;
        }
    }

    function sendDocumentEmailClientInc(filename) {
        if (!pppload.active){
            pppload.sourceComponent = pincprint;
            fname = filename.split(".")[0];
            iscreated = false;
            pppload.active = true;
        }
    }

    function sendDocumentEmailClientInv() {
        if (!pppload.active){
            pppload.sourceComponent = pinvent;
            fname = invtotal.split(".")[0];
            iscreated = false;
            pppload.active = true;
        }
    }

    function removeDocumentServer(filename) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is deleting the document: " + filename);
        if (file.dirExist(docsfolder)) {
            file.cd(docsfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename == fs[i].split(".")[0]) {
                    // The correct file to remove...
                    file.removeFile(fs[i]);
                }
            }
        }else {
            file.makeDirectory(docsfolder);
        }
        file.resetDirectory();
    }

    function removeDocumentClient(filename) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is deleting the document: " + filename);
        if (file.dirExist(docsfolder)) {
            file.cd(docsfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename == fs[i].split(".")[0]) {
                    // The correct file to remove...
                    file.removeFile(fs[i]);
                }
            }
        }else {
            file.makeDirectory(docsfolder);
        }
        file.resetDirectory();
    }

    function removeIncDocumentClient(filename) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is deleting the document: " + filename);
        if (file.dirExist(incdocfolder)) {
            file.cd(incdocfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename == fs[i].split(".")[0]) {
                    // The correct file to remove...
                    file.removeFile(fs[i]);
                }
            }
        }else {
            file.makeDirectory(incdocfolder);
        }
        file.resetDirectory();
    }

    function createServerDocInformation(filename) {
        var jsobj;
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename === fs[i].split(".")[0]){
                    // The correct file to send the date...
                    jsobj = file.readFile(fs[i]);
                }
            }
        }
        file.resetDirectory();
        return jsobj;
    }

    function createIncServerDocInformation(filename) {
        var jsobj;
        if (file.dirExist(incdocfolder)){
            file.cd(incdocfolder);
            var fs = file.getFileNames();
            for(var i = 0; i < fs.length; i++){
                if (filename === fs[i].split(".")[0]){
                    // The correct file to send the date...
                    jsobj = file.readFile(fs[i]);
                }
            }
        }
        file.resetDirectory();
        return jsobj;
    }

    function createDocument(jsobj){
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client sent in a new document, processing...");
        var cname;
        var jmess = JSON.parse('{ "messageindex": "5", "error" : "" }')
        if (file.dirExist(docsfolder)){
            file.cd(docsfolder);
            cname = getRandomName() + ".incmi";
            if(file.writeFile(JSON.stringify(jsobj),cname)){
                jmess.message = false;
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client document saved");
            }else{
                jmess.message = true;
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving client document");
            }
        }
        file.resetDirectory();
        sendAdminsCommits(jsobj.type,cname);
        return JSON.stringify(jmess);
    }

    function createIncendieDocument(jsobj){
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client sent in a new document, processing...");
        var cname;
        if (file.dirExist(incdocfolder)){
            file.cd(incdocfolder);
            cname = getRandomName() + ".incmi";
            if(file.writeFile(JSON.stringify(jsobj),cname)){
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client document saved");
            }else{
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving client document");
            }
        }
        file.resetDirectory();
        sendAdminsCommits("inc",cname);
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
        var cname;
        var jess = JSON.parse('{ "messageindex": "5", "didsave" : "" }')
        var jmess = false;
        if (file.dirExist(invfolder)){
            file.cd(invfolder);
            var b = file.getFileNames();
            for(var i = 0; i < b.length; i++){
                if (b[i] == invtotal){
                    result = file.readFile(b[i]);
                }
            }

            if (result !== "") {
                var tobj = JSON.parse(result);
                for (var d = 0; d < jsobj.items.length; d++){
                    var ifrom = JSON.parse(jsobj.items[d]);
                    for (var c = 0; c < tobj.items.length; c++){
                        var isave = tobj.items[c];
                        if (isave.tag == ifrom.tag) {
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
                cname = getRandomName() + ".incmi";
                if(file.writeFile(JSON.stringify(jsobj),cname)){
                    jmess.message = false;
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client inventory commit saved to storage");
                }else{
                    jmess.message = true;
                    logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving client inventory commit to storage");
                }
            }
        }else {
            file.makeDirectory(invfolder);
        }
        jess.didsave = jmess.toString();
        file.resetDirectory();
        sendAdminsCommits(jsobj.type, cname);
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

    function createInventoryItemClient(jobj) {
        logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Client wants to add a new inventory item");
        jobj.tag = getRandomTag();
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
                    if (item.tag == jobj.tag){
                        index = b;
                    }
                }
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

    function removeInventoryItemClient(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client requested to remove an inventory item - Admin accepted.");
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
                    if (item.tag == jobj.tag){
                        index = b;
                    }
                }
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
                    if (parseInt(item.tag) == parseInt(jobj.tag)){
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

    function editInventoryItemClient(jobj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client requested to edit an inventory item - Admin accepted.");
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
                    if (parseInt(item.tag) == parseInt(jobj.tag)){
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
    //
    function requestPeopleListServer() {
        var obj = JSON.parse(peoplelistbase);
        if (file.dirExist(peoplefolder)) {
            file.cd(peoplefolder);
            var files = file.getFileNames();
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if (fl.split(".")[1] == "incmi"){
                    obj.items.push(JSON.parse(file.readFile(fl)));
                }
            }
        }else{
            file.makeDirectory(peoplefolder);
        }
        file.resetDirectory();
        return obj;
    }

    function getDateString(dt) {
        var day = dt.split(":")[0];
        var month = dt.split(":")[1];
        var year = dt.split(":")[2];
        var date = new Date();
        date.setDate(parseInt(day));
        date.setMonth(parseInt(month) - 1);
        date.setYear(parseInt(year));

        return date.toLocaleDateString(locale, "ddd dd MMMM yyyy");
    }

    function sendEmailEventCreated(obj){
        if (settings.scnew) {
            var emails = [];
            for (var i = 0; i < obj.people.length; i++){
                var pers = JSON.parse(obj.people[i]);
                if (pers.email != "") emails.push(pers.email);
            }
            if (settings.semaccount != "" && settings.sempassword != ""){
                file.sendEmail(settings.semaccount, settings.sempassword,emails,"Incmi: Nouvelle evenements | le " + getDateString(obj.date), "L'evenements est ceduler a: " + obj.hour + "\n A: " + obj.lieu + "\n" + obj.details);
            }
        }
    }

    function sendEmailEventEdited(oldobj,newobj) {
        if (settings.scedit) {
            var emails = [];
            for (var i = 0; i < newobj.people.length; i++) {
                var pers = JSON.parse(newobj.people[i]);
                if (pers.email != "") emails.push(pers.email);
            }
            if (settings.semaccount != ""){
                var sb = "";
                if (oldobj.date != newobj.date) {
                    sb += "La date de l'evenements a ete changer. Il etait " + getDateString(oldobj.date) + ". L'evenements est maintenant ceduler pour, " + getDateString(newobj.date) + "\n";
                }
                if (oldobj.hour != newobj.hour) {
                    sb += "La nouvelle heur de l'evenements sera a: " + newobj.hour + "\n";
                }

                if (oldobj.lieu != newobj.lieu) {
                    sb += "L'evenements devait avoir lieu a " + oldobj.lieu + " mais il auras lieu finalement a " + newobj.lieu + "\n\n";
                }
                if (oldobj.details != newobj.details) {
                    sb += "Les details de l'evenements ont ete modifier: \n" + newobj.details;
                }

                file.sendEmail(settings.semaccount, settings.sempassword, emails, "Incmi: Modification d'evenements | " + getDateString(oldobj.date), sb);
            }
        }
    }

    function createEventItemServer(obj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is adding an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        var f = JSON.parse(file.readFile(eventsfilename));
                        f.items.push(JSON.stringify(obj));
                        if (file.writeFile(JSON.stringify(f),eventsfilename)){
                            logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Saved the event succesfully");
                        } else {
                            logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving the event");
                        }
                    }
                }
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
            var d = JSON.parse(file.readFile(tf));
            d.items.push(JSON.stringify(obj));
            file.writeFile(JSON.stringify(d), eventsfilename);
        }
        sendEmailEventCreated(obj);
        file.resetDirectory();
    }

    function createEventItemClient(obj) {
        obj.tag = getRandomTagEvent();
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is adding an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        var f = JSON.parse(file.readFile(eventsfilename));
                        f.items.push(JSON.stringify(obj));
                        if (file.writeFile(JSON.stringify(f),eventsfilename)){
                            logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Saved the event succesfully");
                        } else {
                            logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving the event");
                        }
                    }
                }
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
            var d = JSON.parse(file.readFile(tf));
            d.items.push(JSON.stringify(obj));
            file.writeFile(JSON.stringify(d), eventsfilename);
        }
        sendEmailEventCreated(obj);
        file.resetDirectory();
    }


    function editEventItemServer(obj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is editing an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        exists = true;
                    }
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);
            var f = JSON.parse(file.readFile(eventsfilename));
            for (var b = 0; b < f.items.length; b++){
                var ob = JSON.parse(f.items[b]);
                if (parseInt(ob.tag) == parseInt(obj.tag)){
                    if (obj.date != ob.date || obj.hour != ob.date || obj.details != ob.details){
                        sendEmailEventEdited(ob,obj);
                    }
                    ob.date = obj.date;
                    ob.hour = obj.hour;
                    ob.lieu = obj.lieu;
                    ob.details = obj.details;
                    ob.people = obj.people;
                    f.items.splice(b,1,JSON.stringify(ob));
                }
            }
            if (file.writeFile(JSON.stringify(f),eventsfilename)){
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Saved changes to the event succesfully");
            } else {
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving the changes to the event");
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
        }
        file.resetDirectory();
    }

    function editEventItemClient(obj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is editing an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        exists = true;
                    }
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);
            var f = JSON.parse(file.readFile(eventsfilename));
            for (var b = 0; b < f.items.length; b++){
                var ob = JSON.parse(f.items[b]);
                if (parseInt(ob.tag) == parseInt(obj.tag)){
                    if (obj.date != ob.date || obj.hour != ob.date || obj.details != ob.details){
                        sendEmailEventEdited(ob,obj);
                    }
                    ob.date = obj.date;
                    ob.hour = obj.hour;
                    ob.lieu = obj.lieu;
                    ob.details = obj.details;
                    ob.people = obj.people;
                    f.items.splice(b,1,JSON.stringify(ob));
                }
            }
            if (file.writeFile(JSON.stringify(f),eventsfilename)){
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Saved changes to the event succesfully");
            } else {
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when saving the changes to the event");
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
        }
        file.resetDirectory();
    }

    function sendEmailEventRemoved(obj) {
        if (settings.scremove) {
            if (settings.semaccount != "" && settings.sempassword != "") {
                var emails = []
                for (var i = 0; i < obj.people.length; i++) {
                    var pers = JSON.parse(obj.people[i]);
                    if (pers.email != "") emails.push(pers.email);
                }
                file.sendEmail(settings.semaccount, settings.sempassword, emails, "Incmi: Evenement Annuler | " + getDateString(obj.date), "L'evenements qui etait ceduler pour " + getDateString(obj.date) + " a ete annuler, merci.");
            }
        }
    }

    function removeEventItemServer(obj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is removing an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        exists = true;
                    }
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);
            var f = JSON.parse(file.readFile(eventsfilename));
            for (var b = 0; b < f.items.length; b++){
                var ob = JSON.parse(f.items[b]);
                if (parseInt(ob.tag) == parseInt(obj.tag)){
                    f.items.splice(b,1);
                }
            }
            if (file.writeFile(JSON.stringify(f),eventsfilename)){
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Removed the event succesfully");
            } else {
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when removing the event");
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
        }
        sendEmailEventRemoved(obj);
        file.resetDirectory();
    }

    function removeEventItemClient(obj) {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is removing an event");
        if (file.dirExist(eventfolder)){
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl.split(".")[1] == "incmi"){
                    if (fl == eventsfilename){
                        exists = true;
                    }
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);
            var f = JSON.parse(file.readFile(eventsfilename));
            for (var b = 0; b < f.items.length; b++){
                var ob = JSON.parse(f.items[b]);
                if (parseInt(ob.tag) == parseInt(obj.tag)){
                    f.items.splice(b,1);
                }
            }
            if (file.writeFile(JSON.stringify(f),eventsfilename)){
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Removed the event succesfully");
            } else {
                logMessage((new Date().toLocaleString(locale, "hh:mm:ss ddd yyyy-MM-dd ---")) + "Error when removing event");
            }
        }else{
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase, eventsfilename);
        }
        sendEmailEventRemoved(obj);
        file.resetDirectory();
    }


    function requestPeopleListClient() {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client requested for list of people");
        var obj = JSON.parse(peoplelistbase);
        if (file.dirExist(peoplefolder)) {
            file.cd(peoplefolder);
            var files = file.getFileNames();
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if (fl.split(".")[1] == "incmi"){
                    obj.items.push(JSON.parse(file.readFile(fl)));
                }
            }
        }else{
            file.makeDirectory(peoplefolder);
        }
        file.resetDirectory();
        return JSON.stringify(obj);
    }

    function createPersonServer(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is creating a new member");
        if (!file.dirExist(peoplefolder)) { file.makeDirectory(peoplefolder); }
        file.cd(peoplefolder);
        var fname = getRandomName() + ".incmi";
        jobj.filename = fname;
        file.writeFile(JSON.stringify(jobj),fname);
        file.resetDirectory();
    }

    function createPersonClient(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is creating a new member");
        if (!file.dirExist(peoplefolder)) { file.makeDirectory(peoplefolder); }
        file.cd(peoplefolder);
        var fname = getRandomName() + ".incmi";
        jobj.filename = fname;
        file.writeFile(JSON.stringify(jobj),fname);
        file.resetDirectory();
    }

    function editPersonServer(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is editing an existing member");
        if (!file.dirExist(peoplefolder)) { file.makeDirectory(peoplefolder); }
        file.cd(peoplefolder)
        var fname = jobj.filename
        var files = file.getFileNames();
        for (var i = 0; i < files.length; i++) {
            var f = files[i];
            if (f == fname) {
                file.removeFile(fname);
                var result = file.writeFile(JSON.stringify(jobj),fname);
            }
        }
        file.resetDirectory();
    }

    function editPersonClient(jobj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is editing an existing member");
        if (!file.dirExist(peoplefolder)) { file.makeDirectory(peoplefolder); }
        file.cd(peoplefolder)
        var fname = jobj.filename
        var files = file.getFileNames();
        for (var i = 0; i < files.length; i++) {
            var f = files[i];
            if (f == fname) {
                file.removeFile(fname);
                var result = file.writeFile(JSON.stringify(jobj),fname);
            }
        }
        file.resetDirectory();
    }

    function removePersonServer(objects){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server is removing a member (s)");
        if (!file.dirExist(peoplefolder)) {file.makeDirectory(peoplefolder);}
        file.cd(peoplefolder)
        var files = file.getFileNames();
        for (var i = 0; i < objects.length; i++){
            var tr = JSON.parse(objects[i]);
            for (var b = 0; b < files.length; b++) {
                if (files[b] == tr.filename) {
                    file.removeFile(tr.filename);
                }
            }
        }
        file.resetDirectory();
    }

    function removePersonClient(obj){
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client is removing a member (s)");
        if (!file.dirExist(peoplefolder)) {file.makeDirectory(peoplefolder);}
        file.cd(peoplefolder)
        var files = file.getFileNames();
        for (var i = 0; i < obj.items.length; i++){
            var tr = JSON.parse(obj.items[i]);
            for (var b = 0; b < files.length; b++) {
                if (files[b] == tr.filename) {
                    file.removeFile(tr.filename);
                }
            }
        }
        file.resetDirectory();
    }

    function requestEventsClient() {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Client requested events");
        var obj = JSON.parse(eventbase);
        if (file.dirExist(eventfolder)) {
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl == eventsfilename) {
                    obj = JSON.parse(file.readFile(eventsfilename));
                    exists = true;
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);

        }else {
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase,eventsfilename);
        }
        file.resetDirectory();
        return JSON.stringify(obj);
    }

    function requestEventsServer() {
        logMessage((new Date().toLocaleString(locale,"hh:mm:ss ddd yyyy-MM-dd ---")) + "Server requested events");
        var obj = JSON.parse(eventbase);
        if (file.dirExist(eventfolder)) {
            file.cd(eventfolder);
            var files = file.getFileNames();
            var exists = false;
            for (var i = 0; i < files.length; i++){
                var fl = files[i];
                if(fl == eventsfilename) {
                    obj = JSON.parse(file.readFile(eventsfilename));
                    exists = true;
                }
            }
            if (!exists) file.writeFile(eventbase,eventsfilename);

        }else {
            file.makeDirectory(eventfolder);
            file.cd(eventfolder);
            file.writeFile(eventbase,eventsfilename);
        }
        file.resetDirectory();
        return obj;
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

    function getRandomTagEvent(){
        var tag = Math.floor(Math.random() * 1000000);
        if (file.dirExist(eventfolder)) {
            file.cd(eventfolder);
            var names = file.getFileNames();
            var exists = false;
            for (var i = 0; i < names.length; i++) {
                if (names[i] === eventsfilename) {
                    exists = true;
                }
            }

            if (exists) {
                var obj = JSON.parse(file.readFile(eventsfilename));
                var cont = true;
                while (cont) {
                    var same = false;
                    for (var b = 0; b < obj.items.length; b++) {
                        var ob = JSON.parse(obj.items[b]);
                        if (ob.tag == tag) {
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
}
