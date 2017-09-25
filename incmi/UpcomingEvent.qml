import QtQuick 2.0
import QtWebSockets 1.1

Item {

    function ready () {
        upce.active = true;
    }

    BaseSocket {
        port: settings.port
        host: settings.host
        id: upce
        onTextMessageReceived: {
            var current = new Date();
            var sl = []
            var obj = JSON.parse(message);
            for (var i = 0; i < obj.items.length; i++){
                var tobj = JSON.parse(obj.items[i]);
                var dd = Date.fromLocaleDateString(locale, tobj.date, 'dd:M:yyyy');

                if ((current.getFullYear() - dd.getFullYear()) > 0){
                    continue;
                }else if ((current.getMonth() - dd.getMonth()) > 0 && (current.getFullYear() - dd.getFullYear()) > -1) {
                    continue;
                }else if ((current.getDate() - dd.getDate()) > 0 && (current.getMonth() - dd.getMonth()) > -1){
                    continue;
                }

                //Date is before
                var inserted = false;
                for (var b = 0; b < sl.length; b++) {
                    var it = sl[b];
                    var tdate = Date.fromLocaleDateString(locale, it.date, 'dd:M:yyyy');
                    if ((tdate.getFullYear() - dd.getFullYear()) > 0){
                        sl.splice(b,0,tobj);
                        inserted = true;
                        break;
                    }else if ((tdate.getMonth() - dd.getMonth()) > 0 &&(tdate.getFullYear() - dd.getFullYear()) > -1) {
                        sl.splice(b,0,tobj);
                        sl.join();
                        inserted = true;
                        break;
                    }else{
                        if ((tdate.getDate() - dd.getDate()) > 0 && (tdate.getMonth() - dd.getMonth()) > -1){
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
            upce.active = false;
        }
        onStatusChanged: {
            switch (status) {
            case WebSocket.Open:
                upce.sendTextMessage('{"messageindex": "11"}');
                break;
            }
        }
    }


    ListView {
        id: typeview
        interactive: true
        anchors.fill: parent
        clip: true
        model: ListModel {id: mod}
        delegate: EventDelegate {}
        spacing: 3
        onCurrentIndexChanged: {
            // Change the values of the boxes.
        }
    }
}
