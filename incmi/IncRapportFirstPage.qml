import QtQuick 2.9
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Flickable{
    property int pad: 5
    property int textboxheight: 35
    function setDate() {
        date = (datenv1.currentIndex + 1).toString() + "/" + datenv2.currentIndex.toString() + "/" + ((new Date().getFullYear() -5) + datenv3.currentIndex).toString();
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
    anchors.fill: parent
    contentWidth: parent.width
    contentHeight: p1rec.childrenRect.height
    Item {
        id: p1rec
        y: 0
        x: 0
        height: childrenRect.height
        width: parent.width
        Item {
            id: rdate
            x: xd
            width: parent.width - 2*xd
            height: 80
            RowLayout{
                anchors.rightMargin: 5
                anchors.topMargin: 0
                anchors.fill: parent
                Label {
                    id: label
                    text: qsTr("Date de l’intervention :")
                    Layout.maximumHeight: 30
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Tumbler {
                    id: datenv1
                    Layout.maximumHeight: parent.height - 8
                    Layout.maximumWidth: 25
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    currentIndex: (new Date().getDate()) - 1
                    visibleItemCount: 3
                    model: 31
                    delegate: Label {
                        text: formatDayText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14
                    }
                    onCurrentIndexChanged: {
                        setDate();
                    }
                }

                Label {
                    id: label1
                    text: qsTr("/")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 15
                    Layout.maximumHeight: 40
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                }

                Tumbler {
                    id: datenv2
                    Layout.maximumHeight: parent.height - 8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 25
                    currentIndex: (new Date().getMonth())
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    visibleItemCount: 3
                    model: 12
                    delegate: Label {
                        text: formatMonthText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14
                    }
                    onCurrentIndexChanged: {
                        if(datenv1.currentItem != null){
                            var dat = new Date(datenv3.currentIndex, currentIndex, 0).getDate();
                            var index = datenv1.currentIndex
                            datenv1.model = dat
                            datenv1.currentIndex = index
                        }
                        setDate();
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
                    Layout.maximumHeight: parent.height - 8
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumWidth: 32
                    currentIndex: 5
                    visibleItemCount: 3
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    delegate: Label {
                        text: formatYearText(modelData)
                        opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.pixelSize: 14
                    }
                    onCurrentIndexChanged: {
                        if(datenv1.currentItem != null){
                            var dat = new Date(currentIndex, datenv2.currentIndex, 0).getDate();
                            var index = datenv1.currentIndex
                            datenv1.model = dat
                            datenv1.currentIndex = index
                        }
                        setDate();
                    }

                    model: 25
                }
            }
        }

        Item {
            height: parent.height - rdate.height
            y: rdate.height
            width: parent.width

            Label {
                y: pad
                x: r1.x - width - pad
                text: "Heure : "
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                height: r1.height
            }
            Rectangle {
                id: r1
                x: lb.x + lb.width + pad
                y: pad
                width: parent.width - 3*pad - lb.width
                height: textboxheight
                color: "white"
                border.color: "grey"
                border.width: 1
                radius: 3
                TextInput {
                    id: t1
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: t2
                    text: ""
                    onTextChanged: {
                        time = text;
                    }

                }
            }
            Label {
                y: r2.y
                x: r1.x - width - pad
                text: "Adresse : "
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
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
                    id: t2
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    text: ""
                    KeyNavigation.tab: t3
                    onTextChanged: {
                        adresse = text;
                    }
                }
            }
            Label {
                y: r3.y
                x: r1.x - width - pad
                text: "Ville : "
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                height: r1.height
            }
            Rectangle {
                id: r3
                x: lb.x + lb.width + pad
                y: pad + r2.height + r2.y
                width: parent.width - 3*pad - lb.width
                height: textboxheight
                color: "white"
                border.color: "grey"
                border.width: 1
                radius: 3
                TextInput {
                    id: t3
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: t4
                    text: ""
                    onTextChanged: {
                        ville = text;
                    }
                }
            }
            Pane {
                id: sintit
                x: pad
                width: parent.width - 2*pad
                height: textboxheight
                y: r3.y + r3.height + pad
                Material.elevation: 2
                Material.background: colordp
                Label {
                    text: qsTr("Nombres de Sinistres");
                    width: parent.width - 3*pad
                    height: implicitHeight
                    y: (parent.height - height) / 2
                    x: 3*pad
                    Material.foreground: colorlt
                }
            }
            Label {
                id: lb
                y: pad + sintit.height + sintit.y
                x: pad
                text: "Hommes : "
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                height: r1.height
            }
            Rectangle {
                id: r4
                x: lb.x + lb.width + pad
                y: pad + sintit.height + sintit.y
                width: parent.width - 3*pad - lb.width
                height: textboxheight
                color: "white"
                border.color: "grey"
                border.width: 1
                radius: 3
                TextInput {
                    id: t4
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: t5
                    text: ""
                    onTextChanged: {
                        homme = text;
                    }
                }
            }
            Label {
                y: r5.y
                x: r1.x - width - pad
                text: "Femmes : "
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                height: r1.height
            }
            Rectangle {
                id: r5
                x: lb.x + lb.width + pad
                y: pad + r4.height + r4.y
                width: parent.width - 3*pad - lb.width
                height: textboxheight
                color: "white"
                border.color: "grey"
                border.width: 1
                radius: 3
                TextInput {
                    id: t5
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: t6
                    text: ""
                    onTextChanged: {
                        femme = text;
                    }
                }
            }
            Label {
                y: r6.y
                x: r1.x - width - pad
                text: "Enfants : "
                horizontalAlignment: Text.AlignRight
                verticalAlignment: Text.AlignVCenter
                height: r1.height
            }
            Rectangle {
                id: r6
                x: lb.x + lb.width + pad
                y: pad + r5.height + r5.y
                width: parent.width - 3*pad - lb.width
                height: textboxheight
                color: "white"
                border.color: "grey"
                border.width: 1
                radius: 3
                TextInput {
                    id: t6
                    selectByMouse: true
                    anchors.fill: parent
                    anchors.margins: 3
                    anchors.leftMargin: 15
                    verticalAlignment: Text.AlignVCenter
                    KeyNavigation.tab: t1
                    text: ""
                    onTextChanged: {
                        enfant = text;
                    }
                }
            }
            Item {
                id: r7
                x: pad
                y: r6.height + pad + r6.y
                width: parent.width  - 2*pad
                height: textboxheight

                RadioButton {
                    id: leger
                    text: qsTr("Leger")
                    width: implicitWidth
                    height: parent.height
                    x: parent.width - width - pad
                    onCheckedChanged: {
                        if (checked) type = "leger";
                    }
                }
                RadioButton {
                    id: moderer
                    text: qsTr("Moderer")
                    width: implicitWidth
                    height: parent.height
                    x: leger.x - width - pad
                    onCheckedChanged: {
                        if (checked) type = "moderer";
                        console.log("moderer");
                    }
                }
                Label {
                    id: typla
                    text: qsTr("Type d'incendie: ")
                    width: implicitWidth
                    height: implicitHeight
                    y: (parent.height - height) / 2
                    x: moderer.x - width - pad
                }
            }

        }
    }
}
