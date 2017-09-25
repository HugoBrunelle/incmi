import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
Item {
    height: 3300
    width: 2550
    property int headerfont: 24
    property int tleftpad: 15
    BaseSocket {
        id: dsocket
        host: settings.host
        port: settings.port
        onStatusChanged: {
            switch(status) {
            case WebSocket.Open:
                var js = JSON.parse('{"messageindex":"22","filename":""}');
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
        tdate.text = obj.date;
        theure.text = obj.time;
        tadresse.text = obj.adresse;
        tville.text = obj.ville;
        ttype.text = obj.type
        for (var i = 0; i < obj.people.length; i++) {
            modpeople.append(JSON.parse(obj.people[i]));
        }
        for (i = 0; i < obj.other.length; i++) {
            modservice.append(JSON.parse(obj.other[i]));
        }
        for (i = 0; i < obj.materiel.length; i++) {
            modmateriel.append(JSON.parse(obj.materiel[i]));
        }
        tfemmes.text = obj.femme;
        thomme.text = obj.homme;
        tenfants.text = obj.enfant;
        peoplesection.height = comphead2.height + peopleview.contentHeight + 100;
        servicessection.height = comphead3.height + serviceview.contentHeight + 100;
        materielsection.height = comphead4.height + materielsection.contentHeight + 100;
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
                            text:"Division Incendie"
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
                            text:"Rapport D'interventions"
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
                    height: parent.height * 100/1000
                    border.color: "grey"
                    border.width: 1
                    Item {
                        id: i0
                        width: parent.width / 3
                        height: parent.height / 5
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
                            id: tdate
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
                            y: tdate.height + 1
                        }
                    }
                    Rectangle {
                        id: comphead1
                        x: 2
                        y: i0.y + i0.height
                        width: parent.width - 4
                        height: parent.height / 5
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
                            text:"INFORMATION GENERAL DU CAS"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"                        }
                    }

                    Item {
                        id: i1
                        x: 0
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 4
                        height: parent.height / 5
                        Label {
                            id: clab
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Heure:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: theure
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
                            y: theure.height + 1
                        }
                    }
                    Item {
                        id: i2
                        x: i1.width + i1.x
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 4
                        height: parent.height / 5
                        Label {
                            id: clab1
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
                            id: tadresse
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
                            y: tadresse.height + 1
                        }
                    }
                    Item {
                        id: i3
                        x: i2.width + i2.x
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 4
                        height: parent.height / 5
                        Label {
                            id: clab2
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
                            id: tville
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
                            y: tville.height + 1
                        }
                    }
                    Item {
                        id: i4
                        x: i3.width + i3.x
                        y: comphead1.y + comphead1.height;
                        width: parent.width / 4
                        height: parent.height / 5
                        Label {
                            id: clab3
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Type:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: ttype
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
                            y: ttype.height + 1
                        }
                    }

                    Rectangle {
                        id: comphead5
                        x: 2
                        y: i4.y + i4.height
                        width: parent.width - 4
                        height: parent.height / 5
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"NOMBRE DE SINISTRER"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"                        }
                    }

                    Item {
                        id: i5
                        x: 0
                        y: comphead5.y + comphead5.height;
                        width: parent.width / 3
                        height: parent.height / 5
                        Label {
                            id: clab5
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Hommes:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: thomme
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
                            y: thomme.height + 1
                        }
                    }
                    Item {
                        id: i6
                        x: i5.width + i5.x
                        y: comphead5.y + comphead5.height;
                        width: parent.width / 3
                        height: parent.height / 5
                        Label {
                            id: clab6
                            x:0
                            y:0
                            width: implicitWidth
                            height: parent.height
                            leftPadding: parent.width / 40
                            text:"Femmes:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: tfemmes
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
                            y: tfemmes.height + 1
                        }
                    }
                    Item {
                        id: i7
                        x: i6.width + i6.x
                        y: comphead5.y + comphead5.height;
                        width: parent.width / 3
                        height: parent.height / 5
                        Label {
                            id: clab7
                            x:0
                            y:0
                            width: implicitWidth
                            leftPadding: parent.width / 40
                            height: parent.height
                            text:"Enfants:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                        }
                        TextInput {
                            id: tenfants
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
                            y: tenfants.height + 1
                        }
                    }
                }

                Rectangle {
                    id: peoplesection
                    x: parent.width / 20
                    y:evesection.y + evesection.height + 50
                    width: parent.width - 2*x
                    height: comphead2.height + peopleview.contentHeight + 100
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead2
                        x: 2
                        width: parent.width - 4
                        height: 60
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"BENEVOLES SUR LES LIEU: "
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                            font.bold: true
                        }
                    }
                    Item {
                        x: 20
                        y: comphead2.y + comphead2.height;
                        width: parent.width - 40
                        height: peopleview.contentHeight;

                        ListView {
                            id: peopleview
                            interactive: false;
                            anchors.fill: parent
                            anchors.leftMargin: 15
                            anchors.rightMargin: 15
                            model: ListModel {id: modpeople}
                            delegate: IncRapportDocumentPrintPeopleDelegate {}
                            currentIndex: -1
                        }
                    }
                }
                Rectangle {
                    id: servicessection
                    x: parent.width / 20
                    y:peoplesection.y + peoplesection.height + 50
                    width: parent.width - 2*x
                    height: comphead3.height + serviceview.contentHeight + 100
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead3
                        x: 2
                        width: parent.width - 4
                        height: 60
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"SERVICES INCENDIE SUR LES LIEUX ET AUTRES SERVICES: "
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                            font.bold: true
                        }
                    }
                    Item {
                        x: 20
                        y: comphead3.y + comphead3.height;
                        width: parent.width - 40
                        height: serviceview.contentHeight;

                        ListView {
                            id: serviceview
                            interactive: false;
                            anchors.fill: parent
                            anchors.leftMargin: 15
                            anchors.rightMargin: 15
                            model: ListModel {id: modservice}
                            delegate: IncRapportDocumentPrintServiceDelegate {}
                            currentIndex: -1
                        }
                    }
                }
                Rectangle {
                    id: materielsection
                    x: parent.width / 20
                    y:servicessection.y + servicessection.height + 50
                    width: parent.width - 2*x
                    height: comphead4.height + materielview.contentHeight + 100
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead4
                        x: 2
                        width: parent.width - 4
                        height: 60
                        border.color: "grey"
                        border.width: 1
                        color: "red"
                        Label {
                            x:0
                            y:0
                            width: parent.width
                            height: parent.height
                            leftPadding: parent.width / 30
                            text:"MATERIEL UTILISER:"
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                            font.bold: true
                        }
                    }
                    Item {
                        x: 20
                        y: comphead4.y + comphead4.height;
                        width: parent.width - 40
                        height: materielview.contentHeight;

                        ListView {
                            id: materielview
                            interactive: false;
                            anchors.fill: parent
                            anchors.leftMargin: 15
                            anchors.rightMargin: 15
                            model: ListModel {id: modmateriel}
                            delegate: IncRapportDocumentPrintMaterielDelegate {}
                            currentIndex: -1
                        }
                    }
                }
            }
        }
    }
}

