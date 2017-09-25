import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
Item {
    height: 3300
    width: 2550
    property int headerfont: 24
    property int tleftpad: 15
    property bool vis: false

    function stoBool(string){
        switch(string.toLowerCase().trim()){
        case "true": case "yes": case "1": return true;
                                 case "false": case "no": case "0": case null: return false;
                                                                    default: return Boolean(string);
        }
    }

    function stoBoolCheck(string) {
        switch(string.toLowerCase().trim()){
        case "true": case "yes": case "1": return Qt.Checked;
                                 case "false": case "no": case "0": case null: return Qt.Unchecked;
                                                                    default: return Qt.Unchecked;
        }
    }

    function checkVisible(nature){
        switch (nature) {
        case "1":
            vis = false;
            break;
        case "2":
            vis = true;
            break;
        }
    }

    BaseSocket {
        id: dsocket
        host: settings.host
        port: settings.port
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                var js = JSON.parse('{"messageindex":"2","filename":""}');
                js.filename = currentfilename;
                dsocket.sendTextMessage(JSON.stringify(js));
                break;
            case WebSocket.Error:
                dsocket.active = false;
                imgloader.active = false;
            }
        }
        onTextMessageReceived: {
            setData(message);
            dsocket.active = false;
        }
    }

    function setData(data) {
        var obj = JSON.parse(data);
        checkVisible(obj.nature);
        var dat = obj.dateint.replace(":","/");
        dat = dat.replace(":","/");
        dateint.text = dat;
        tarriver.text = obj.tarriver;
        tappele.text = obj.tappele;
        tdepart.text = obj.tdepart;
        nomoper.text = obj.nomoper;
        endroit.text = obj.endroit;
        adresse.text = obj.adresse;
        ville.text = obj.ville;
        evautre.text = obj.evautre;
        vnom.text = obj.vnom;
        vprenom.text = obj.vprenom;
        vage.text = obj.vage;
        switch (obj.vsex) {
        case "m":
            vsexm.checked = true;
            break;
        case "f":
            vsexf.checked = true;
            break;
        }
        dat = obj.vnaiss.replace(":","/");
        vnaiss.text = dat.replace(":","/");
        vadresse.text = obj.vadresse;
        vville.text = obj.vville;
        vautre.text = obj.vautre;
        vcodepostal.text = obj.vcodepostal;
        vtelephone.text = obj.vtelephone;
        nabraisson.checked = stoBool(obj.nabraisson);
        nacr.checked = stoBool(obj.nacr);
        nconvulsion.checked = stoBool(obj.nconvulsion);
        ndiabete.checked = stoBool(obj.ndiabete);
        ndouleurt.checked = stoBool(obj.ndouleurt);
        nfaibless.checked = stoBool(obj.nfaibless);
        nhypertermie.checked = stoBool(obj.nhypertermie);
        nhypothermie.checked = stoBool(obj.nhypothermie);
        nintoxication.checked = stoBool(obj.nintoxication);
        nmaltete.checked = stoBool(obj.nmaltete);
        nobstr.checked = stoBool(obj.nobstr);
        ntrauma.checked = stoBool(obj.ntrauma);
        nautre.checked = stoBool(obj.nautre);
        ndescription.text = obj.ndescription;
        if (obj.nature === "2"){
            if (stoBool(obj.epreaction)) {
                epreaction2.checked = true;
            }else {
                epreaction1.checked = true;
            }
            if (stoBool(obj.epvoiesr)) {
                epvoiesr2.checked = true;
            }else {
                epvoiesr1.checked = true;
            }
            if (stoBool(obj.eprespiration)) {
                eprespiration2.checked = true;
            }else {
                eprespiration1.checked = true;
            }
            if (stoBool(obj.eppouls)) {
                eppouls2.checked = true;
            }else {
                eppouls1.checked = true;
            }
            switch (obj.epnivecon) {
            case "0":
                epnivecon1.checked = true;
                break;
            case "1":
                epnivecon2.checked = true;
                break;
            case "2":
                epnivecon3.checked = true;
                break;
            case "3":
                epnivecon4.checked = true;
                break;
            case "4":
                epnivecon5.checked = true;
                break;
            }
            medicaments.text = obj.medicaments;
            alergies1.text = obj.alergies;
            alergies2.text = obj.alergies2;
            ainconnu.checked = stoBool(obj.ainconnu);
            ana.checked = stoBool(obj.ana);
            amavc.checked = stoBool(obj.amavc);
            amcardiaque.checked = stoBool(obj.amcardiaque);
            amdiabete.checked = stoBool(obj.amdiabete);
            amepliepsie.checked = stoBool(obj.amepliepsie);
            amhyperhypo.checked = stoBool(obj.amhyperhypo);
            amautre.checked = stoBool(obj.amautre);
            amdescription.text = obj.amdescription;
            o.text = obj.o;
            p.text = obj.p;
            q.text = obj.q;
            r.text = obj.r;
            s.text = obj.s;
            t.text = obj.t;
        }
        if (obj.nature === "1"){
            descriptionscas.text = obj.descriptioncas;
        }
        gToImage();
    }

    Component.onCompleted: {
        dsocket.active = true;
    }

    Rectangle {
        anchors.fill: parent
        color: "white"

        Item {
            anchors.fill: parent
            anchors.topMargin: parent.height / 14
            anchors.bottomMargin: parent.height / 16
            anchors.leftMargin: parent.width / 17
            anchors.rightMargin: parent.width / 17

            Rectangle {
                id: pagecontent
                anchors.fill: parent
                color: "white"

                Item {
                    id: header
                    x: parent.width / 17
                    y: 50
                    height: (parent.height * 12 /100) - 50
                    width: parent.width - 2*x
                    Image {
                        id: him1
                        x: 0
                        y: 0
                        height: parent.height
                        fillMode: Image.PreserveAspectFit
                        source: "Images/ucmu_full.png"
                        width: parent.width / 5
                    }

                    Item {
                        id: xmid
                        x: him1.x + him1.width
                        y: 0
                        width: parent.width * 3 /5
                        height: parent.height
                        Label {
                            id: hl1
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height / 3
                            text:"Unité Communautaire des Mesure d’urgences"
                            font.pointSize: headerfont
                            verticalAlignment: Text.AlignBottom
                            horizontalAlignment: Text.AlignHCenter
                        }
                        Label {
                            id: hl2
                            x:0
                            y:hl1.y + hl1.height
                            width: parent.width
                            height: parent.height / 3
                            font.pointSize: headerfont
                            text:"Division Médical"
                            verticalAlignment: Text.AlignTop
                            horizontalAlignment: Text.AlignHCenter

                        }
                        Label {
                            id: hl3
                            x:0
                            y:hl2.y + hl2.height
                            width: parent.width
                            height: parent.height / 3
                            font.pointSize: headerfont
                            text:"Rapport de Premiers soins"
                            verticalAlignment: Text.AlignTop
                            horizontalAlignment: Text.AlignHCenter

                        }
                    }
                    Image {
                        id: him2
                        x: xmid.x + xmid.width
                        y: 0
                        height: parent.height
                        width: parent.width / 5
                    }
                }

                Rectangle {
                    id: evesection
                    x: parent.width / 20
                    y:header.y + header.height + 50
                    width: parent.width - 2*x
                    height: parent.height * 120/1000
                    border.color: "grey"
                    border.width: 1
                    Item {
                        id: i0
                        width: parent.width / 3
                        height: parent.height / 6
                        x: parent.width - width
                        y: 0
                        Label {
                            id: clab0
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Date de l’intervention:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: dateint
                            x: clab0.width
                            width: parent.width - clab0.width
                            height: parent.height - 2
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            font.pointSize: headerfont - 4
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab0.width
                            width: parent.width - clab0.width
                            height: 1
                            color: "grey"
                            y: dateint.height + 1
                        }
                    }
                    Rectangle {
                        id: comphead1
                        x: 2
                        y: i0.y + i0.height
                        width: parent.width - 4
                        height: parent.height / 6
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            id: evelabel1
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"EVENEMENTS"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"                        }
                    }

                    Item {
                        id: i1
                        x: 0
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Heure d'appel:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: tappele
                            x: clab.width
                            width: parent.width - clab.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab.width
                            width: parent.width - clab.width
                            height: 1
                            color: "grey"
                            y: tappele.height + 1
                        }
                    }
                    Item {
                        id: i2
                        x: i1.width + i1.x
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab1
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Heure d'arriver:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: tarriver
                            x: clab1.width
                            width: parent.width - clab1.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab1.width
                            width: parent.width - clab1.width
                            height: 1
                            color: "grey"
                            y: tarriver.height + 1
                        }
                    }
                    Item {
                        id: i3
                        x: i2.width + i2.x
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab2
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Heure de depart:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: tdepart
                            x: clab2.width
                            width: parent.width - clab2.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab2.width
                            width: parent.width - clab2.width
                            height: 1
                            color: "grey"
                            y: tdepart.height + 1
                        }
                    }
                    Item {
                        id: i4
                        x: 0
                        y: i3.y + i3.height;
                        width: parent.width
                        height: parent.height / 6
                        Label {
                            id: clab3
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 120
                            height: parent.height
                            text:"Nom de l’événement ou de l’opération:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: nomoper
                            x: clab3.width
                            width: parent.width - clab3.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab3.width
                            width: parent.width - clab3.width
                            height: 1
                            color: "grey"
                            y: nomoper.height + 1
                        }
                    }
                    Item {
                        id: i5
                        x: 0
                        y: i4.y + i4.height;
                        width: parent.width
                        height: parent.height / 6
                        Label {
                            id: clab4
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 120
                            height: parent.height
                            text:"Endroit:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: endroit
                            x: clab4.width
                            width: parent.width - clab4.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab4.width
                            width: parent.width - clab4.width
                            height: 1
                            color: "grey"
                            y: endroit.height + 1
                        }
                    }
                    Item {
                        id: i6
                        x: 0
                        y: i5.y + i5.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab5
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Adresse:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: adresse
                            x: clab5.width
                            width: parent.width - clab5.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab5.width
                            width: parent.width - clab5.width
                            height: 1
                            color: "grey"
                            y: adresse.height + 1
                        }
                    }
                    Item {
                        id: i7
                        x: i6.width + i6.x
                        y: i5.y + i5.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab6
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Ville:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: ville
                            x: clab6.width
                            width: parent.width - clab6.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab6.width
                            width: parent.width - clab6.width
                            height: 1
                            color: "grey"
                            y: ville.height + 1
                        }
                    }
                    Item {
                        id: i8
                        x: i7.width + i7.x
                        y: i5.y + i5.height;
                        width: parent.width / 3
                        height: parent.height / 6
                        Label {
                            id: clab7
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Autre:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: evautre
                            x: clab7.width
                            width: parent.width - clab7.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab7.width
                            width: parent.width - clab7.width
                            height: 1
                            color: "grey"
                            y: evautre.height + 1
                        }
                    }

                }

                Rectangle {
                    id: victimesection
                    x: parent.width / 20
                    y:evesection.y + evesection.height + 50
                    width: parent.width - 2*x
                    height: parent.height * 100/1000
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead2
                        x: 2
                        y: 0
                        width: parent.width - 4
                        height: parent.height / 5
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            id: evelabel2
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"VICTIME"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                        }
                    }
                    Item {
                        id: i9
                        width: parent.width / 2
                        height: parent.height / 5
                        x: 0
                        y: comphead2.y + comphead2.height
                        Label {
                            id: clab8
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 80
                            height: parent.height
                            text:"Nom:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vnom
                            x: clab8.width
                            width: parent.width - clab8.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab8.width
                            width: parent.width - clab8.width
                            height: 1
                            color: "grey"
                            y: vnom.height + 1
                        }
                    }
                    Item {
                        id: i10
                        width: parent.width / 2
                        height: parent.height / 5
                        x: i9.x + i9.width
                        y: comphead2.y + comphead2.height
                        Label {
                            id: clab9
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Prénom:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vprenom
                            x: clab9.width
                            width: parent.width - clab9.width
                            height: parent.height - 2
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                            font.pointSize: headerfont - 4
                        }
                        Rectangle {
                            x: clab9.width
                            width: parent.width - clab9.width
                            height: 1
                            color: "grey"
                            y: vprenom.height + 1
                        }
                    }
                    Item {
                        id: i11
                        width: parent.width / 3
                        height: parent.height / 5
                        x: 0
                        y: i10.y + i10.height
                        Label {
                            id: clab10
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Age:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vage
                            x: clab10.width
                            width: parent.width - clab10.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab10.width
                            width: parent.width - clab10.width
                            height: 1
                            color: "grey"
                            y: vage.height + 1
                        }
                    }
                    Item {
                        id: i12
                        width: parent.width / 3
                        height: parent.height / 5
                        x: i11.width
                        y: i10.y + i10.height
                        Label {
                            id: clab11
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Sex:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        RadioButton {
                            id: vsexm
                            x: clab11.width
                            height: parent.height
                            width: (parent.width - clab11.implicitWidth)/2
                            text: "Masculin"
                            font.pointSize: headerfont - 4
                        }
                        RadioButton {
                            id: vsexf
                            x: vsexm.x + vsexm.width
                            height: parent.height
                            width: (parent.width - clab11.implicitWidth)/2
                            text: "Feminen"
                            font.pointSize: headerfont - 4
                        }
                    }
                    Item {
                        id: i13
                        width: parent.width / 3
                        height: parent.height / 5
                        x: i12.width + i12.x
                        y: i10.y + i10.height
                        Label {
                            id: clab12
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Date de naissance (JJ/MM/AAAA):"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vnaiss
                            x: clab12.width
                            width: parent.width - clab12.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab12.width
                            width: parent.width - clab12.width
                            height: 1
                            color: "grey"
                            y: vnaiss.height + 1
                        }
                    }
                    Item {
                        id: i14
                        width: parent.width / 3
                        height: parent.height / 5
                        x: 0
                        y: i13.y + i13.height
                        Label {
                            id: clab13
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Adresse"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vadresse
                            x: clab13.width
                            width: parent.width - clab13.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab13.width
                            width: parent.width - clab13.width
                            height: 1
                            color: "grey"
                            y: vadresse.height + 1
                        }
                    }
                    Item {
                        id: i15
                        width: parent.width / 3
                        height: parent.height / 5
                        x: i14.x + i14.width
                        y: i13.y + i13.height
                        Label {
                            id: clab14
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Ville:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vville
                            x: clab14.width
                            width: parent.width - clab14.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab14.width
                            width: parent.width - clab14.width
                            height: 1
                            color: "grey"
                            y: vville.height + 1
                        }                    }
                    Item {
                        id: i16
                        width: parent.width / 3
                        height: parent.height / 5
                        x: i15.x + i15.width
                        y: i13.y + i13.height
                        Label {
                            id: clab15
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Ville:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vautre
                            x: clab15.width
                            width: parent.width - clab15.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab15.width
                            width: parent.width - clab15.width
                            height: 1
                            color: "grey"
                            y: vautre.height + 1
                        }
                    }
                    Item {
                        id: i17
                        width: parent.width / 2
                        height: parent.height / 5
                        x: 0
                        y: i16.y + i16.height
                        Label {
                            id: clab16
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 80
                            height: parent.height
                            text:"Code Postal:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vcodepostal
                            x: clab16.width
                            width: parent.width - clab16.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab16.width
                            width: parent.width - clab16.width
                            height: 1
                            color: "grey"
                            y: vcodepostal.height + 1
                        }
                    }
                    Item {
                        id: i18
                        width: parent.width / 2
                        height: parent.height / 5
                        x: i17.x + i17.width
                        y: i16.y + i16.height
                        Label {
                            id: clab17
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Téléphone:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: vtelephone
                            x: clab17.width
                            width: parent.width - clab17.width
                            height: parent.height - 2
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            leftPadding: tleftpad
                        }
                        Rectangle {
                            x: clab17.width
                            width: parent.width - clab17.width
                            height: 1
                            color: "grey"
                            y: vtelephone.height + 1
                        }
                    }

                }

                Rectangle {
                    id: lowersection
                    x: parent.width / 20
                    y: victimesection.y + victimesection.height + 50
                    width: parent.width - 2*x
                    height: parent.height - y - 50
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead3
                        x: 0
                        y: 0
                        width: parent.width
                        height: comphead2.height
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            id: evelabel3
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"INFORMATION / ÉVALUATION PRIMAIRE"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                        }
                    }

                    Rectangle {
                        id: inlowersection
                        x: 0
                        width: parent.width
                        y: comphead3.height
                        height: parent.height - y
                        border.color: "grey"
                        border.width: 1
                        Rectangle {
                            id: col1
                            height: parent.height
                            width: parent.width / 3
                            x: 0
                            border.color: "grey"
                            border.width: 1
                            Rectangle {
                                id: iheader1
                                border.color: "grey"
                                border.width: 1
                                width: parent.width
                                height: parent.height/ 19
                                color: "lightgrey"
                                Label {
                                    x:0
                                    y:0
                                    width: parent.width
                                    height: parent.height
                                    leftPadding: parent.width / 30
                                    text:"Nature du cas"
                                    font.pointSize: headerfont - 4
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                }
                            }
                            Item {
                                id: ir1
                                width: parent.width
                                height: parent.height / 19
                                y: iheader1.height
                                RadioButton {
                                    id: nabraisson
                                    anchors.fill: parent
                                    text: "ABRASSION"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir2
                                width: parent.width
                                height: parent.height / 19
                                y: ir1.height + ir1.y
                                RadioButton {
                                    id: nacr
                                    anchors.fill: parent
                                    text: "ACR / CODE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir3
                                width: parent.width
                                height: parent.height / 19
                                y: ir2.height + ir2.y
                                RadioButton {
                                    id: nconvulsion
                                    anchors.fill: parent
                                    text: "CONVULSION"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir4
                                width: parent.width
                                height: parent.height / 19
                                y: ir3.height + ir3.y
                                RadioButton {
                                    id: ndiabete
                                    anchors.fill: parent
                                    text: "DIABÈTE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir5
                                width: parent.width
                                height: parent.height / 19
                                y: ir4.height + ir4.y
                                RadioButton {
                                    id: ndouleurt
                                    anchors.fill: parent
                                    text: "DOULEUR THORACIQUE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir6
                                width: parent.width
                                height: parent.height / 19
                                y: ir5.height + ir5.y
                                RadioButton {
                                    id: nfaibless
                                    anchors.fill: parent
                                    text: "FAIBLESS"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir7
                                width: parent.width
                                height: parent.height / 19
                                y: ir6.height + ir6.y
                                RadioButton {
                                    id: nhypertermie
                                    anchors.fill: parent
                                    text: "HYPERTHERMIE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir8
                                width: parent.width
                                height: parent.height / 19
                                y: ir7.height + ir7.y
                                RadioButton {
                                    id: nhypothermie
                                    anchors.fill: parent
                                    text: "HYPOTHERMIE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir9
                                width: parent.width
                                height: parent.height / 19
                                y: ir8.height + ir8.y
                                RadioButton {
                                    id: nintoxication
                                    anchors.fill: parent
                                    text: "INTOXICATION"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir10
                                width: parent.width
                                height: parent.height / 19
                                y: ir9.height + ir9.y
                                RadioButton {
                                    id: nmaltete
                                    anchors.fill: parent
                                    text: "MAL DE TÊTE"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir11
                                width: parent.width
                                height: parent.height / 19
                                y: ir10.height + ir10.y
                                RadioButton {
                                    id: nobstr
                                    anchors.fill: parent
                                    text: "OBSTR. VOIES RESP"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir12
                                width: parent.width
                                height: parent.height / 19
                                y: ir11.height + ir11.y
                                RadioButton {
                                    id: ntrauma
                                    anchors.fill: parent
                                    text: "TRAUMA"
                                    font.pointSize: headerfont - 4
                                }
                            }
                            Item {
                                id: ir13
                                width: parent.width
                                height: parent.height / 19
                                y: ir12.height + ir12.y
                                RadioButton {
                                    id: nautre
                                    anchors.fill: parent
                                    text: "AUTRE"
                                    font.pointSize: headerfont - 4
                                }
                            }

                            Rectangle {
                                y: ir13.height + ir13.y + 10
                                height: parent.height - y - 20
                                x: 7
                                width: parent.width - 14
                                border.color: "grey"
                                border.width: 1

                                TextInput {
                                    id: ndescription
                                    anchors.rightMargin: 5
                                    anchors.bottomMargin: 5
                                    anchors.leftMargin: 5
                                    anchors.topMargin: 5
                                    anchors.fill: parent
                                    anchors.margins: 5
                                    font.pointSize: headerfont - 4
                                }
                            }
                        }

                        Rectangle {
                            id: col2
                            height: parent.height
                            visible: vis
                            width: parent.width / 3
                            x: col1.width
                            border.color: "grey"
                            border.width: 1
                            Rectangle {
                                id: topsection1
                                width: parent.width
                                height: parent.height * 13/18
                                border.color: "grey"
                                border.width: 1
                                Rectangle {
                                    id: iheader2
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: iheader1.height
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"Évaluation Primaire"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }

                                Item {
                                    id: i19
                                    width: parent.width
                                    height: (parent.height - iheader2.height) * 3 / 17
                                    y: iheader2.height
                                    Label {
                                        id: clab18
                                        text: "L'"
                                        width: parent.width * 4 /20
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "red"
                                        font.pointSize: headerfont + 2
                                    }
                                    Label {
                                        id: clab19
                                        text: "État de consience"
                                        width: parent.width - clab18.width
                                        height: implicitHeight
                                        leftPadding: 20
                                        x: clab18.width
                                        verticalAlignment: Text.AlignVCenter
                                        font.italic: true
                                        font.pointSize: headerfont - 6
                                    }
                                    RadioButton {
                                        id: epreaction1
                                        width: parent.width - clab18.width
                                        height: (parent.height - clab19.height) / 2
                                        text: "RÉACTION"
                                        x: clab18.width
                                        y: clab19.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epreaction2
                                        width: parent.width - clab18.width
                                        height: (parent.height - clab19.height) / 2
                                        text: "AUCUNE RÉACTION"
                                        x: clab18.width
                                        y: epreaction1.y + epreaction1.height
                                        font.pointSize: headerfont - 4
                                    }
                                }

                                Item {
                                    id: i20
                                    width: parent.width
                                    height: (parent.height - iheader2.height) * 3 / 17
                                    y: i19.y + i19.height
                                    Label {
                                        id: clab20
                                        text: "A"
                                        width: parent.width * 4 /20
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "red"
                                        font.pointSize: headerfont + 2
                                    }
                                    Label {
                                        id: clab21
                                        text: "Voies respiratoires"
                                        width: parent.width - clab20.width
                                        height: implicitHeight
                                        leftPadding: 20
                                        x: clab20.width
                                        verticalAlignment: Text.AlignVCenter
                                        font.italic: true
                                        font.pointSize: headerfont - 6
                                    }
                                    RadioButton {
                                        id: epvoiesr1
                                        width: parent.width - clab20.width
                                        height: (parent.height - clab21.height) / 2
                                        text: "OUVERTES"
                                        x: clab20.width
                                        y: clab21.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epvoiesr2
                                        width: parent.width - clab20.width
                                        height: (parent.height - clab21.height) / 2
                                        text: "OBSTRUÉES"
                                        x: clab20.width
                                        y: epvoiesr1.y + epvoiesr1.height
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: i21
                                    width: parent.width
                                    height: (parent.height - iheader2.height) * 3 / 17
                                    y: i20.y + i20.height
                                    Label {
                                        id: clab22
                                        text: "B"
                                        width: parent.width * 4 /20
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "red"
                                        font.pointSize: headerfont + 2
                                    }
                                    Label {
                                        id: clab23
                                        text: "Respiration"
                                        width: parent.width - clab22.width
                                        height: implicitHeight
                                        leftPadding: 20
                                        x: clab22.width
                                        verticalAlignment: Text.AlignVCenter
                                        font.italic: true
                                        font.pointSize: headerfont - 6
                                    }
                                    RadioButton {
                                        id: eprespiration1
                                        width: parent.width - clab22.width
                                        height: (parent.height - clab23.height) / 2
                                        text: "ADÉQUATE"
                                        x: clab22.width
                                        y: clab23.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: eprespiration2
                                        width: parent.width - clab22.width
                                        height: (parent.height - clab23.height) / 2
                                        text: "INADÉQUATE (<B/MIN)"
                                        x: clab22.width
                                        y: eprespiration1.y + eprespiration1.height
                                        font.pointSize: headerfont - 4
                                    }
                                }

                                Item {
                                    id: i22
                                    width: parent.width
                                    height: (parent.height - iheader2.height) * 3 / 17
                                    y: i21.y + i21.height
                                    Label {
                                        id: clab24
                                        text: "C"
                                        width: parent.width * 4 /20
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "red"
                                        font.pointSize: headerfont + 2
                                    }
                                    Label {
                                        id: clab25
                                        text: "POULS"
                                        width: parent.width - clab24.width
                                        height: implicitHeight
                                        leftPadding: 20
                                        x: clab24.width
                                        verticalAlignment: Text.AlignVCenter
                                        font.italic: true
                                        font.pointSize: headerfont - 6
                                    }
                                    RadioButton {
                                        id: eppouls1
                                        width: parent.width - clab24.width
                                        height: (parent.height - clab25.height) / 2
                                        text: "PRÉSENT"
                                        x: clab24.width
                                        y: clab25.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: eppouls2
                                        width: parent.width - clab24.width
                                        height: (parent.height - clab25.height) / 2
                                        text: "ABSCENT"
                                        x: clab24.width
                                        y: eppouls1.y + eppouls1.height
                                        font.pointSize: headerfont - 4
                                    }
                                }

                                Item {
                                    id: i23
                                    width: parent.width
                                    height: (parent.height - iheader2.height) * 5 / 17
                                    y: i22.y + i22.height
                                    Label {
                                        id: clab26
                                        text: "D"
                                        width: parent.width * 4 /20
                                        height: parent.height
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "red"
                                        font.pointSize: headerfont + 2
                                    }
                                    Label {
                                        id: clab27
                                        text: "Niveau de conscience"
                                        width: parent.width - clab26.width
                                        height: implicitHeight
                                        leftPadding: 20
                                        x: clab26.width
                                        verticalAlignment: Text.AlignVCenter
                                        font.italic: true
                                        font.pointSize: headerfont - 6
                                    }
                                    RadioButton {
                                        id: epnivecon1
                                        width: parent.width - clab26.width
                                        height: (parent.height - clab27.height) / 5
                                        text: "ALERTE"
                                        x: clab26.width
                                        y: clab27.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epnivecon2
                                        width: parent.width - clab26.width
                                        height: (parent.height - clab27.height) / 5
                                        text: "VERBAL"
                                        x: clab26.width
                                        y: epnivecon1.y + epnivecon1.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epnivecon3
                                        width: parent.width - clab26.width
                                        height: (parent.height - clab27.height) / 5
                                        text: "STIMULI VERBAL"
                                        x: clab26.width
                                        y: epnivecon2.y + epnivecon2.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epnivecon4
                                        width: parent.width - clab26.width
                                        height: (parent.height - clab27.height) / 5
                                        text: "STIMULI DOULEUR"
                                        x: clab26.width
                                        y: epnivecon3.y + epnivecon3.height
                                        font.pointSize: headerfont - 4
                                    }
                                    RadioButton {
                                        id: epnivecon5
                                        width: parent.width - clab26.width
                                        height: (parent.height - clab27.height) / 5
                                        text: "RÉACTION"
                                        x: clab26.width
                                        y: epnivecon4.y + epnivecon4.height
                                        font.pointSize: headerfont - 4
                                    }
                                }
                            }

                            Rectangle {
                                id: bottomsection1
                                width: parent.width
                                height: parent.height - topsection1.height
                                y: topsection1.y + topsection1.height
                                border.color: "grey"
                                border.width: 1
                                Rectangle {
                                    id: iheader3
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: iheader1.height
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"Médicaments (M)"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }

                                Rectangle {
                                    y: iheader3.height + 10
                                    height: parent.height - iheader3.height - 20
                                    x: 7
                                    width: parent.width - 14
                                    border.color: "grey"
                                    border.width: 1

                                    TextInput {
                                        id: medicaments
                                        anchors.rightMargin: 5
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        font.pointSize: headerfont - 4
                                    }
                                }
                            }

                        }

                        Rectangle {
                            id: col3
                            height: parent.height
                            visible: vis
                            width: parent.width / 3
                            x: col2.x + col2.width
                            border.color: "grey"
                            border.width: 1
                            Rectangle {
                                id: topsection2
                                height: parent.height * 3 /18
                                width: parent.width
                                border.color: "grey"
                                border.width: 1
                                Rectangle {
                                    id: iheader4
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: iheader1.height
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"Allergies (A)"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }

                                Item {
                                    id: i24
                                    height: (parent.height - iheader4.height) / 2
                                    width: parent.width
                                    y: iheader4.height

                                    TextInput {
                                        id: alergies1
                                        width: parent.width * 2 / 3
                                        height: parent.height - 1
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }

                                    Rectangle {
                                        width: parent.width * 2/ 3
                                        height: 1
                                        y: alergies1.height
                                        color: "grey"
                                    }

                                    RadioButton {
                                        id: ainconnu
                                        width: parent.width - alergies1.width
                                        height: parent.height
                                        x: alergies1.width
                                        text: "?"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: i25
                                    height: (parent.height - iheader4.height) / 2
                                    width: parent.width
                                    y: i24.height + i24.y

                                    TextInput {
                                        id: alergies2
                                        width: parent.width * 2 / 3
                                        height: parent.height - 1
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }

                                    Rectangle {
                                        width: parent.width * 2/ 3
                                        height: 1
                                        y: alergies2.height
                                        color: "grey"
                                    }

                                    RadioButton {
                                        id: ana
                                        width: parent.width - alergies2.width
                                        height: parent.height
                                        x: alergies2.width
                                        text: "N/A"
                                        font.pointSize: headerfont - 4
                                    }
                                }

                            }

                            Rectangle {
                                id: middlesection1
                                height: (parent.height - topsection2.height) / 2
                                width: parent.width
                                y: topsection2.height
                                border.color: "grey"
                                border.width: 1
                                Rectangle {
                                    id: iheader5
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: iheader1.height
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"Antécédents Médicaux"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }
                                Item {
                                    id: il1
                                    y: iheader5.height
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amavc
                                        anchors.fill: parent
                                        text: "AVC"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: il2
                                    y: il1.height + il1.y
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amcardiaque
                                        anchors.fill: parent
                                        text: "CARDIAQUE"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: il3
                                    y: il2.height + il2.y
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amdiabete
                                        anchors.fill: parent
                                        text: "DIABÈTE"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: il4
                                    y: il3.height + il3.y
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amepliepsie
                                        anchors.fill: parent
                                        text: "ÉPLIEPSIE"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: il5
                                    y: il4.height + il4.y
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amhyperhypo
                                        anchors.fill: parent
                                        text: "HYPER/HYPOTENSION"
                                        font.pointSize: headerfont - 4
                                    }
                                }
                                Item {
                                    id: il6
                                    y: il5.height + il5.y
                                    width: parent.width
                                    height: (parent.height - iheader5.height)/9
                                    RadioButton {
                                        id: amautre
                                        anchors.fill: parent
                                        text: "AUTRE:"
                                        font.pointSize: headerfont - 4
                                    }
                                }

                                Rectangle {
                                    y: il6.height + il6.y + 10
                                    height: parent.height - y - 20
                                    x: 7
                                    width: parent.width - 14
                                    border.color: "grey"
                                    border.width: 1

                                    TextInput {
                                        id: amdescription
                                        anchors.rightMargin: 5
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        font.pointSize: headerfont - 4
                                    }
                                }



                            }

                            Rectangle {
                                id: bottomsecition2
                                height: (parent.height - topsection2.height) / 2
                                width: parent.width
                                y: middlesection1.height + middlesection1.y
                                border.color: "grey"
                                border.width: 1
                                Rectangle {
                                    id: iheader6
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: iheader1.height
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"OPQRST"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }

                                Item {
                                    id: i26
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: iheader6.height

                                    Label {
                                        id: clab28
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"O:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: o
                                        x: clab28.width
                                        width: parent.width - clab28.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab28.width
                                        width: parent.width - clab28.width
                                        height: 1
                                        color: "grey"
                                        y: o.height + 1
                                    }

                                }

                                Item {
                                    id: i27
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: i26.height + i26.y

                                    Label {
                                        id: clab29
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"P:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: p
                                        x: clab29.width
                                        width: parent.width - clab29.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab29.width
                                        width: parent.width - clab29.width
                                        height: 1
                                        color: "grey"
                                        y: p.height + 1
                                    }

                                }
                                Item {
                                    id: i28
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: i27.height + i27.y

                                    Label {
                                        id: clab30
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"Q:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: q
                                        x: clab30.width
                                        width: parent.width - clab30.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab30.width
                                        width: parent.width - clab30.width
                                        height: 1
                                        color: "grey"
                                        y: q.height + 1
                                    }

                                }

                                Item {
                                    id: i29
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: i28.height + i28.y

                                    Label {
                                        id: clab31
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"R:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: r
                                        x: clab31.width
                                        width: parent.width - clab31.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab31.width
                                        width: parent.width - clab31.width
                                        height: 1
                                        color: "grey"
                                        y: r.height + 1
                                    }

                                }

                                Item {
                                    id: i30
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: i29.height + i29.y

                                    Label {
                                        id: clab32
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"S:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: s
                                        x: clab32.width
                                        width: parent.width - clab32.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab32.width
                                        width: parent.width - clab32.width
                                        height: 1
                                        color: "grey"
                                        y: s.height + 1
                                    }

                                }

                                Item {
                                    id: i31
                                    height: (parent.height - iheader6.height) / 6
                                    width: parent.width
                                    y: i30.height + i30.y

                                    Label {
                                        id: clab33
                                        x:0
                                        y:0
                                        width: implicitWidth + 50
                                        leftPadding: parent.width / 40
                                        height: parent.height
                                        text:"T:"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                    TextInput {
                                        id: t
                                        x: clab33.width
                                        width: parent.width - clab33.width
                                        height: parent.height - 2
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        leftPadding: tleftpad
                                    }
                                    Rectangle {
                                        x: clab33.width
                                        width: parent.width - clab33.width
                                        height: 1
                                        color: "grey"
                                        y: t.height + 1
                                    }

                                }
                            }
                        }

                        Rectangle {
                            id: col4
                            x: col2.x
                            y:col2.y
                            height: col2.height
                            width: col2.width + col3.width
                            visible: !vis
                            border.color: "Grey"
                            border.width: 1
                            Item {
                                id: i32
                                width: parent.width
                                height: parent.height
                                Rectangle {
                                    id: iheader7
                                    border.color: "grey"
                                    border.width: 1
                                    width: parent.width
                                    height: parent.height/ 19
                                    color: "lightgrey"
                                    Label {
                                        x:0
                                        y:0
                                        width: parent.width
                                        height: parent.height
                                        leftPadding: parent.width / 30
                                        text:"Description du cas"
                                        font.pointSize: headerfont - 4
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                    }
                                }
                                Rectangle {
                                    y: iheader7.height + 10
                                    height: parent.height / 3 - iheader7.height
                                    x: 20
                                    width: parent.width - 40
                                    border.color: "grey"
                                    border.width: 1
                                    TextInput {
                                        id: descriptionscas
                                        anchors.rightMargin: 5
                                        anchors.bottomMargin: 5
                                        anchors.leftMargin: 5
                                        anchors.topMargin: 5
                                        anchors.fill: parent
                                        anchors.margins: 5
                                        font.pointSize: headerfont - 4
                                    }
                                }
                            }

                        }
                    }
                }
            }
        }
    }

}
