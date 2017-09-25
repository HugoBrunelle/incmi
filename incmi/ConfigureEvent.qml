import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3


Item {
    property int textboxheight: 35
    property int pad: 5
    property int footerheight: 70
    property bool cansave: false

    function ready() {
        for (var i = 0; i < currentpeople.length; i++){
            var obj = JSON.parse(currentpeople[i]);
            tmembers.text += obj.firstname + " " + obj.lastname + "; ";
        }
        var ob = JSON.parse(currentevent);
        thour.text = currenthour;
        tlieu.text = currentlieu;
        tdetails.text = currentdetails;
        var dd = Date.fromLocaleDateString(Qt.locale(), currentdate, "dd:M:yyyy");
        datenv1.currentIndex = dd.getDate() - 1;
        datenv2.currentIndex = dd.getMonth();
        datenv3.currentIndex = dd.getFullYear() - new Date().getFullYear() + 5;
    }

    function checkSave() {
        if (thour.text == "" || tdetails.text == "" || tlieu.text == "") {
            cansave = false;
        }else {
            cansave = true;
        }
    }

    function remove(){
        var obj = JSON.parse(eventitembase);
        obj.date = currentdate
        obj.hour = thour.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.text;
        obj.tag = currenttag;
        removeEvent(obj);
    }
    function save(){
        var obj = JSON.parse(eventitembase);
        if (editing){
            obj.tag = currenttag;
        }
        obj.date = datenv1.currentItem.text + ":" + datenv2.currentItem.text + ":" + datenv3.currentItem.text;
        obj.hour = thour.text;
        obj.people = currentpeople;
        obj.details = tdetails.text;
        obj.lieu = tlieu.text;
        saveEvent(obj);
    }

    function formatYearText(modelData) {
        var data = modelData + parseInt(new Date().getFullYear()) - 5;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatDayText(modelData) {
        var data = modelData + 1;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMonthText(modelData) {
        var data = modelData + 1;
        return data.toString().length < 2 ? "0" + data : data;
    }

    width: parent.width
    height: parent.height
    Item {
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - footerheight
        Label {
            id: dlabel
            x: pad
            y: pad
            text: "Event date (dd/mm/yyyy): "
            verticalAlignment: Text.AlignVCenter
            height: textboxheight
        }
        Item {
            id: i1
            x: pad + dlabel.width + dlabel.x
            width: parent.width - dlabel.width - dlabel.x - 2*pad
            height: dlabel.height + 2*pad
            RowLayout{
                anchors.fill: parent
                Tumbler {
                    id: datenv1
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    visibleItemCount: 3
                    model: 31
                    delegate: Label {
                        text: formatDayText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Label {
                    id: label1
                    text: qsTr("/")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 15
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Tumbler {
                    id: datenv2
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    visibleItemCount: 3
                    model: 12
                    delegate: Label {
                        text: formatMonthText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onCurrentIndexChanged: {
                        if(datenv1.currentItem != null){
                            var dat = new Date(datenv3.currentIndex, currentIndex, 0).getDate();
                            var index = datenv1.currentIndex
                            datenv1.model = dat
                            datenv1.currentIndex = index
                        }
                    }
                }
                Label {
                    id: label2
                    text: qsTr("/")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.maximumHeight: 30
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillWidth: true
                    Layout.maximumWidth: 15
                }

                Tumbler {
                    id: datenv3
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    visibleItemCount: 3
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    delegate: Label {
                        text: formatYearText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    onCurrentIndexChanged: {
                        if(datenv1.currentItem != null){
                            var dat = new Date(currentIndex, datenv2.currentIndex, 0).getDate();
                            var index = datenv1.currentIndex
                            datenv1.model = dat
                            datenv1.currentIndex = index
                        }
                    }
                    model: 25
                }
            }
        }

        Label {
            y: r1.y
            x: pad
            text: "Heure : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: dlabel.height + dlabel.y + pad * 5
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: thour
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tlieu
                text: ""
                onTextChanged: {
                    currenthour = thour.text;
                    checkSave();
                }
            }
        }
        Label {
            y: r2.y
            x: pad
            text: "Lieu : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r2
            x: lb.x + lb.width + pad
            y: pad + r1.height + r1.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: tlieu
                selectByMouse: true
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                KeyNavigation.tab: tdetails
                onTextChanged: {
                    currentlieu = tlieu.text;
                    checkSave();
                }
            }
        }
        Label {
            id: lb
            y: r3.y
            x: pad
            text: "Members invited : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + r2.height + r2.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            MouseArea {
                anchors.fill: parent
                onDoubleClicked: {
                    dclicked();
                }
            }
            Label {
                id: tmembers
                anchors.fill: parent
                anchors.margins: 3
                font.pointSize: tdetails.font.pointSize
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignTop
                text: ""
                wrapMode: Text.WordWrap
            }

        }
        Label {
            y: r4.y
            x: pad
            text: "Detailes : "
            verticalAlignment: Text.AlignVCenter
            height: r1.height
        }
        Rectangle {
            id: r4
            x: lb.x + lb.width + pad
            y: pad + r3.height + r3.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight * 2
            color: "white"
            border.color: "grey"
            border.width: 1
            radius: 3
            TextInput {
                id: tdetails
                selectByMouse: true
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.fill: parent
                anchors.margins: 5
                anchors.leftMargin: 15
                KeyNavigation.tab: thour
                text: ""
                onTextChanged: {
                    currentdetails = tdetails.text;
                    checkSave();
                }
            }
        }
    }


    Item {
        id: footer
        x: pad
        y: parent.height - footer.height - pad
        height: footerheight
        width: parent.width - 2*pad
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width *3/ 4 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: cansave
            text: "Save"
            onClicked: {
                save();
            }
        }
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width / 2 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: editing
            text: "Remove"
            onClicked: {
                remove();
            }
        }
    }
}
