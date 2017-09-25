import QtQuick 2.0
import QtWebSockets 1.1

Item {
    width: parent.width
    height: parent.height

    function ready () {
        preve.active = true;
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: preve
        onTextMessageReceived: {
            var current = new Date();
            var sl = []
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var tobj = JSON.parse(obj.items[i]);
                var dd = Date.fromLocaleDateString(locale, tobj.date, 'dd:M:yyyy');

                if ((dd.getFullYear() - current.getFullYear()) > 0){
                    continue;
                }else if ((dd.getMonth() - current.getMonth()) > 0 && (dd.getFullYear() - current.getFullYear()) > -1) {
                    continue;
                }else if ((dd.getDate() - current.getDate()) > 0 && (dd.getMonth() - current.getMonth()) > -1){
                    continue;
                }

                //Date is before
                var inserted = false;
                for (var b = 0; b < sl.length; b++) {
                    var it = sl[b];
                    var tdate = Date.fromLocaleDateString(locale, it.date, 'dd:M:yyyy');
                    if ((dd.getFullYear() - tdate.getFullYear()) > 0){
                        sl.splice(b,0,tobj);
                        inserted = true;
                        break;
                    }else if ((dd.getMonth() - tdate.getMonth()) > 0 &&(dd.getFullYear() - tdate.getFullYear()) > -1) {
                        sl.splice(b,0,tobj);
                        sl.join();
                        inserted = true;
                        break;
                    }else{
                        if ((dd.getDate() - tdate.getDate()) > 0 && (dd.getMonth() - tdate.getMonth()) > -1){
                            sl.splice(b,0,tobj);
                            sl.join();
                            inserted = true;
                            break;
                        }
                    }
                }
                if(!inserted){
                    sl.push(tobj);
                }
            }

            for (var c = 0; c < sl.length; c++){
                var tb = sl[c]
                mod.append(tb);
                var ob = mod.get(c).people
                ob.clear();
                for (var d = 0; d < tb.people.length; d++){
                    ob.append(JSON.parse(tb.people[d]));
                }
            }
            preve.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                preve.sendTextMessage('{"messageindex": "11"}');
                break;
            }
        }
    }

    ListView {
        id: typeview
        interactive: true
        clip: true
        anchors.fill: parent
        model: ListModel {id: mod}
        delegate: EventDelegate {}
        spacing: 3
        onCurrentIndexChanged: {
            // Change the values of the boxes.
        }
    }
}
