import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtWebSockets 1.1
Item {
    height: 3300
    width: 2550
    property int headerfont: 24
    property int tleftpad: 15
    property string dat

    function setData(d) {
        var obj = JSON.parse(d);
        evelabel1.text = evelabel1.text + obj.name + " , MATRICULE: " + obj.matricule;
        for (var i = 0; i < obj.items.length; i++){
            var ob = JSON.parse(obj.items[i]);
            mod.append(ob);
        }
        gToImage();
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
                id: pcontent
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
                            text:"Rapport d'ajustement d'inventaires"
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
                    height: parent.height - header.y - header.height - 100
                    border.color: "grey"
                    border.width: 1
                    Rectangle {
                        id: comphead1
                        x: 2
                        width: parent.width - 4
                        height: 60
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
                            text:"CHANGEMENT APPORTER A L'INVENTAIRES PAR: "
                            font.pointSize: headerfont - 4
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            color: "white"
                            font.bold: true
                        }
                    }
                    Item {
                        id: i1
                        x: 20
                        y: comphead1.y + comphead1.height + 20;
                        width: parent.width - 40
                        height: parent.height - comphead1.y - comphead1.height - 40;

                        ListView {
                            interactive: false;
                            anchors.fill: parent
                            anchors.margins: 15
                            model: ListModel {id: mod}
                            delegate: InvAdjustmentPrintDelegate {}
                            currentIndex: -1
                        }
                    }
                }
            }
        }
    }
}
