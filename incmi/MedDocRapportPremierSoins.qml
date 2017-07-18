import QtQuick 2.7
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml 2.2

Rectangle {
    property int xd: 30
    width: 360
    height: 640
    Material.accent: colora

    

    function save() {
        // do all the saving work to create a JSON file and send it to the websocket.
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
    function formatHourText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMinuteText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    ColumnLayout {
        id: mview
        spacing: 0
        anchors.fill: parent
        Pane {
            id: header
            width: 360
            height: 100
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 100
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Material.elevation: 4
            Material.background: colorp
            GridLayout {
                id: gridLayout
                anchors.fill: parent
                Image {
                    fillMode: Image.PreserveAspectFit
                    source: "Images/ucmu_100h.png"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
            }
        }
        SwipeView {
            id: view
            clip: true
            topPadding: 10
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: 2
            onCurrentIndexChanged: {
                currentItem.forceActiveFocus();
            }

            Item{
                id: firstPage
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p1rec.childrenRect.height
                    Rectangle {
                        id: p1rec
                        y: 0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: r1
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
                                    id: tumbl
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
                                    id: tumbler1
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
                                        if(tumbl.currentItem != null){
                                            var dat = new Date(tumbler2.currentIndex, currentIndex, 0).getDate();
                                            var index = tumbl.currentIndex
                                            tumbl.model = dat
                                            tumbl.currentIndex = index
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
                                    id: tumbler2
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
                                        if(tumbl.currentItem != null){
                                            var dat = new Date(currentIndex, tumbler1.currentIndex, 0).getDate();
                                            var index = tumbl.currentIndex
                                            tumbl.model = dat
                                            tumbl.currentIndex = index
                                        }
                                    }

                                    model: 25
                                }
                            }
                        }
                        Rectangle {
                            y: r1.height + r1.y + 8
                            id: r2
                            x: xd/2
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                y: 0
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("ÉVÉNEMENT")
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        leftPadding: parent.width / 16
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id:r3
                            x: xd
                            y: r2.height + r2.y
                            width: parent.width - xd*2
                            height: 80
                            RowLayout{
                                spacing: 3
                                anchors.fill: parent
                                Rectangle {
                                    Layout.minimumWidth: 90
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    RowLayout{
                                        spacing: 0.2
                                        anchors.fill: parent
                                        Label {
                                            text: qsTr("Arriver")
                                            rightPadding: 2
                                            Layout.maximumHeight: 30
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignRight
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.maximumWidth: 25
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            currentIndex: 0
                                            visibleItemCount: 3
                                            model: 24
                                            delegate: Label {
                                                text: formatHourText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }

                                        Label {
                                            text: qsTr(":")
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 5
                                            Layout.maximumHeight: 40
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 25
                                            currentIndex: 0
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            visibleItemCount: 3
                                            model: 60
                                            delegate: Label {
                                                text: formatMinuteText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }
                                    }
                                }
                                Rectangle {
                                    Layout.minimumWidth: 90
                                    Layout.columnSpan: 1
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    RowLayout{
                                        spacing: 0.2
                                        anchors.fill: parent
                                        Label {
                                            text: qsTr("Appele")
                                            rightPadding: 2
                                            Layout.maximumHeight: 30
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignRight
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.maximumWidth: 25
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            currentIndex: 0
                                            visibleItemCount: 3
                                            model: 24
                                            delegate: Label {
                                                text: formatHourText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }

                                        Label {
                                            text: qsTr(":")
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 5
                                            Layout.maximumHeight: 40
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.minimumWidth: 25
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 25
                                            currentIndex: 0
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            visibleItemCount: 3
                                            model: 60
                                            delegate: Label {
                                                text: formatMinuteText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }
                                    }
                                }
                                Rectangle {
                                    Layout.minimumWidth: 90
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    RowLayout{
                                        spacing: 0.2
                                        anchors.fill: parent
                                        Label {
                                            text: qsTr("Depart")
                                            rightPadding: 2
                                            Layout.maximumHeight: 30
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignRight
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.maximumWidth: 25
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            currentIndex: 0
                                            visibleItemCount: 3
                                            model: 24
                                            delegate: Label {
                                                text: formatHourText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }

                                        Label {
                                            text: qsTr(":")
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 5
                                            Layout.maximumHeight: 40
                                            verticalAlignment: Text.AlignVCenter
                                            horizontalAlignment: Text.AlignHCenter
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        Tumbler {
                                            Layout.maximumHeight: parent.height - 8
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                            Layout.maximumWidth: 25
                                            currentIndex: 0
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            visibleItemCount: 3
                                            model: 60
                                            delegate: Label {
                                                text: formatMinuteText(modelData)
                                                opacity: 1.0 - Math.abs(Tumbler.displacement) / (1.25)
                                                horizontalAlignment: Text.AlignHCenter
                                                verticalAlignment: Text.AlignVCenter
                                                font.pixelSize: 14
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: r4
                            x: xd
                            y: r3.height + r3.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Nom de l’opération:")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    border.color: "silver"
                                    radius: 3
                                    antialiasing: false
                                    border.width: 1
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: r5
                            x: xd
                            y: r4.height + r4.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Endroit :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: r6
                            x: xd
                            y: r5.height + r5.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Adresse :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: r7
                            x: xd
                            y: r6.height + r6.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Ville :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.margins: 3
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: r8
                            x: xd
                            y: r7.height + r7.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Autre :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                    }
                }
            }
            Item {
                id: secondPage
                visible: true
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p2rec.childrenRect.height
                    Rectangle {
                        id: p2rec
                        y: 0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: p2r2
                            x: xd/2
                            y: 8
                            width: parent.width - xd
                            height: 25 +8
                            Pane {
                                x: 5
                                y: 0
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("VICTIME")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                        }
                        Rectangle {
                            id:p2r3
                            x: xd
                            y: p2r2.height + p2r2.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Nom:")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r4
                            x: xd
                            y: p2r3.height + p2r3.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Prénom:")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r5
                            x: xd
                            y: p2r4.height + p2r4.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Age :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }

                                RadioButton {
                                    id: radioButton
                                    text: qsTr("M")
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Layout.maximumWidth: 50
                                }

                                RadioButton {
                                    id: radioButton1
                                    text: qsTr("F")
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 50
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                }
                            }
                        }
                        Rectangle {
                            id: p2r6
                            x: xd
                            y: p2r5.height + p2r5.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Date de nais. (jj/mm/yy):")
                                    font.pointSize: 10
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.minimumWidth: 25
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 2
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                                Label {
                                    text: qsTr("/")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.minimumWidth: 25
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 2
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                                Label {
                                    text: qsTr("/")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignHCenter
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.minimumWidth: 37
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 2
                                    leftPadding: 4
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r7
                            x: xd
                            y: p2r6.height + p2r6.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Adresse :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r8
                            x: xd
                            y: p2r7.height + p2r7.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Ville :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r9
                            x: xd
                            y: p2r8.height + p2r8.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Autre :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p2r10
                            x: xd
                            y: p2r9.height + p2r9.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Code Postal :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }
                        Rectangle {
                            id: p211
                            x: xd
                            y: p2r10.height + p2r10.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Téléphone :")
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: false
                                }
                                Rectangle {
                                    Layout.maximumHeight: 40
                                    Layout.margins: 3
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    radius: 3
                                    border.color: "silver"
                                    border.width: 1
                                    antialiasing: false
                                TextInput {
                                    anchors.fill: parent
                                    anchors.margins: 4
                                    leftPadding: 5
                                    verticalAlignment: Text.AlignVCenter
                                    font.pointSize: 11
                                }
                                }
                            }
                        }

                    }
                }
            }
            Item {
                id: thirdPage
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p3rec.childrenRect.height
                    Rectangle {
                        id: p3rec
                        y:0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: p3r2
                            x: xd/2
                            width: parent.width - xd
                            height: 30 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("INFORMATION / ÉVALUATION PRIMAIRE")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                        }
                        Rectangle {
                            id:p3r3
                            x: xd
                            y: p3r2.height + p3r2.y
                            width: parent.width - xd*2
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("NATURE DU CAS")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p3r4
                            x: 0
                            y: p3r3.height + p3r3.y
                            width: parent.width
                            height: 240
                            GridLayout{
                                columnSpacing: 3
                                rowSpacing: 1
                                anchors.rightMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                rows: 6
                                columns: 3
                                anchors.fill: parent

                                CheckBox {
                                    id: checkBox12
                                    text: qsTr("Abrassion")
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox11
                                    text: qsTr("Acr / Code")
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox10
                                    text: qsTr("Convulsion")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox9
                                    text: qsTr("Diabète")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox8
                                    text: qsTr("Douleur Thoracique")
                                    Layout.fillHeight: false
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox7
                                    text: qsTr("Faibless")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox6
                                    text: qsTr("Hyperthermie")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox5
                                    text: qsTr("Hypothermie")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox4
                                    text: qsTr("Intoxication")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox3
                                    text: qsTr("Mal de Tête")
                                    spacing: 7
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox2
                                    text: qsTr("Obstr. Voies Resp.")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox1
                                    text: qsTr("Trauma")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: checkBox
                                    text: qsTr("Autre:")
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    font.pointSize: 8
                                }
                            }
                        }
                        Rectangle {
                            id: p3r7
                            x: xd/2
                            y: p3r4.height + p3r4.y
                            width: parent.width - xd
                            height: textArea.implicitHeight > 130 ? textArea.implicitHeight : 130
                            color: "#efefef"
                            radius: 8
                            TextInput {
                                enabled: checkBox.checked
                                id: textArea
                                text: qsTr("")
                                padding: 5
                                wrapMode: Text.WordWrap
                                font.pointSize: 11
                                anchors.bottomMargin: xd/6
                                anchors.rightMargin: xd/2
                                anchors.leftMargin: xd/2
                                anchors.topMargin: xd/6
                                anchors.fill: parent

                            }
                        }

                    }
                }
            }
            Item {
                id: fourthPage
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p3rec.childrenRect.height
                    Rectangle {
                        id: p4rec
                        y: 0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: p4r2
                            x: xd/2
                            y: 8
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("Évaluation Primaire")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id:p4r3
                            x: xd
                            y: p4r2.height + p4r2.y
                            width: parent.width - xd*2
                            height: 60
                            clip: true
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("L'")
                                    leftPadding: 5
                                    Layout.rowSpan: 2
                                    Layout.columnSpan: 2
                                    font.pointSize: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora
                                }

                                ColumnLayout {
                                    Label {
                                        text: qsTr("État de conscience")
                                        topPadding: 5
                                        bottomPadding: 0
                                        font.italic: true
                                        Layout.fillHeight: true
                                        leftPadding: xd
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                        opacity: 0.6
                                        color: colora
                                    }
                                    RowLayout {
                                        spacing: 0
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true

                                        RadioButton {
                                            width: 120
                                            text: qsTr("Reaction")
                                            Layout.maximumWidth: 120
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        RadioButton {
                                            width: 120
                                            text: qsTr("Aucune Reaction")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p4r4
                            x: xd
                            y: p4r3.height + p4r3.y
                            width: parent.width - xd*2
                            height: 60
                            clip: true
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("A")
                                    leftPadding: 5
                                    font.pointSize: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora
                                }
                                ColumnLayout{
                                    Label {
                                        text: qsTr("Voies respiratoires")
                                        topPadding: 5
                                        bottomPadding: 0
                                        font.italic: true
                                        Layout.fillHeight: true
                                        leftPadding: xd
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                        opacity: 0.6
                                        color: colora
                                    }
                                    RowLayout {
                                        spacing: 0
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        RadioButton {
                                            text: qsTr("Ouvertes")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        RadioButton {
                                            text: qsTr("Obstruées")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p4r5
                            x: xd
                            y: p4r4.height + p4r4.y
                            width: parent.width - xd*2
                            height: 60
                            clip: true
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("B")
                                    leftPadding: 5
                                    font.pointSize: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora
                                }
                                ColumnLayout{
                                    Label {
                                        text: qsTr("Respiration")
                                        topPadding: 5
                                        bottomPadding: 0
                                        font.italic: true
                                        Layout.fillHeight: true
                                        leftPadding: xd
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                        opacity: 0.6
                                        color: colora
                                    }
                                    RowLayout {
                                        spacing: 0
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        RadioButton {
                                            text: qsTr("Adéquate")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        }
                                        RadioButton {
                                            text: qsTr("Inadéquate")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p4r6
                            x: xd
                            y: p4r5.height + p4r5.y
                            width: parent.width - xd*2
                            height: 60
                            clip: true
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("C")
                                    leftPadding: 5
                                    font.pointSize: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora
                                }
                                ColumnLayout{
                                    Label {
                                        text: qsTr("Pouls")
                                        topPadding: 5
                                        bottomPadding: 0
                                        font.italic: true
                                        Layout.fillHeight: true
                                        leftPadding: xd
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                        opacity: 0.6
                                        color: colora
                                    }
                                    RowLayout {
                                        spacing: 0
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        RadioButton {
                                            text: qsTr("Présent")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillHeight: true
                                            Layout.fillWidth: true
                                        }

                                        RadioButton {
                                            text: qsTr("Abscent")
                                            Layout.minimumWidth: 120
                                            rightPadding: 4
                                            leftPadding: 4
                                            bottomPadding: 8
                                            topPadding: 8
                                            font.pointSize: 8
                                            Layout.maximumWidth: 120
                                            Layout.fillWidth: true
                                            Layout.fillHeight: true
                                            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        }
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p4r7
                            x: xd
                            y: p4r6.height + p4r6.y
                            width: parent.width - xd*2
                            height: 140
                            clip: true
                            ColumnLayout{
                                anchors.fill: parent
                                RowLayout {
                                    Layout.maximumHeight: 38
                                    Layout.minimumHeight: 38
                                    spacing: 0
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Label {
                                        text: qsTr("D")
                                        leftPadding: 5
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                        font.pointSize: 30
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillHeight: true
                                        Layout.fillWidth: false
                                        color: colora
                                    }
                                    Label {
                                        text: qsTr("Niveau de conscience")
                                        leftPadding: xd
                                        topPadding: 10
                                        font.italic: true
                                        Layout.fillHeight: true
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.fillWidth: true
                                        opacity: 0.6
                                        color: colora
                                    }
                                }
                                GridLayout {
                                    width: 100
                                    height: 100
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    layoutDirection: Qt.LeftToRight
                                    rows: 3
                                    columns: 2
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true

                                    RadioButton {
                                        text: qsTr("Alerte")
                                        Layout.maximumWidth: 125
                                        Layout.minimumWidth: 125
                                        leftPadding: 4
                                        rightPadding: 4
                                        Layout.fillWidth: true
                                        font.pointSize: 8
                                        bottomPadding: 8
                                        Layout.fillHeight: true
                                        topPadding: 8
                                    }

                                    RadioButton {
                                        text: qsTr("Verbal")
                                        leftPadding: 4
                                        Layout.fillWidth: true
                                        rightPadding: 4
                                        font.pointSize: 8
                                        Layout.minimumWidth: 125
                                        Layout.maximumWidth: 125
                                        bottomPadding: 8
                                        Layout.fillHeight: true
                                        topPadding: 8
                                    }

                                    RadioButton {
                                        text: qsTr("Stimuli Verbal")
                                        leftPadding: 4
                                        Layout.fillWidth: true
                                        rightPadding: 4
                                        font.pointSize: 8
                                        Layout.minimumWidth: 125
                                        Layout.maximumWidth: 125
                                        bottomPadding: 8
                                        Layout.fillHeight: true
                                        topPadding: 8
                                    }

                                    RadioButton {
                                        text: qsTr("Stimuli Douleur")
                                        leftPadding: 4
                                        Layout.fillWidth: true
                                        rightPadding: 4
                                        font.pointSize: 8
                                        Layout.minimumWidth: 125
                                        Layout.maximumWidth: 125
                                        bottomPadding: 8
                                        Layout.fillHeight: true
                                        topPadding: 8
                                    }

                                    RadioButton {
                                        text: qsTr("Reaction")
                                        leftPadding: 4
                                        Layout.fillWidth: true
                                        rightPadding: 4
                                        font.pointSize: 8
                                        Layout.minimumWidth: 125
                                        Layout.maximumWidth: 125
                                        bottomPadding: 8
                                        Layout.fillHeight: true
                                        topPadding: 8
                                    }
                                }
                            }
                        }
                    }
                }
            }
            Item {
                id: fifthPage
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p5rec.childrenRect.height
                    Rectangle {
                        id: p5rec
                        y: 0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: p5r2
                            x: xd/2
                            y: 8
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("MÉDICAMENTS")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                        }
                        Rectangle {
                            id:p5r3
                            x: xd
                            y: p5r2.height + p5r2.y
                            width: parent.width - xd*2
                            height: p5tarea1.implicitHeight > 100 ? p5tarea1.implicitHeight : 100
                            color: "#efefef"
                            radius: 8
                            TextInput {
                                id: p5tarea1
                                text: qsTr("")
                                padding: 5
                                wrapMode: Text.WordWrap
                                font.pointSize: 11
                                anchors.bottomMargin: xd/6
                                anchors.rightMargin: xd/2
                                anchors.leftMargin: xd/2
                                anchors.topMargin: xd/6
                                anchors.fill: parent
                            }
                        }
                        Rectangle {
                            id: p5r4
                            x: xd/2
                            y: p5r3.height + p5r3.y + 8
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("ALLERGIES (A)")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p5r5
                            x: xd
                            y: p5r4.height + p5r4.y
                            width: parent.width - xd*2
                            height: 70
                            RowLayout{
                                anchors.bottomMargin: 5
                                spacing: 1
                                anchors.fill: parent
                                ColumnLayout{
                                    TextField {
                                        leftPadding: 5
                                        bottomPadding: 8
                                        Layout.maximumHeight: 40
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Material.accent: colora
                                    }
                                    TextField {
                                        leftPadding: 5
                                        bottomPadding: 8
                                        Layout.maximumHeight: 40
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                        Material.accent: colora
                                    }
                                }
                                ColumnLayout{
                                    RadioButton {
                                        text: qsTr("?")
                                        font.pointSize: 8
                                        Layout.minimumWidth: 70
                                        Layout.maximumWidth: 90
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }

                                    RadioButton {
                                        text: qsTr("N/A")
                                        font.pointSize: 8
                                        Layout.minimumWidth: 70
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.maximumWidth: 90
                                        Layout.fillWidth: true
                                        Layout.fillHeight: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p5r6
                            x: xd/2
                            y: p5r5.height + p5r5.y + 8
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("ANTÉCÉDENTS MÉDICAUX (P)")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }
                        }
                        Rectangle {
                            id: p5r7
                            x: xd/2
                            y: p5r6.height + p5r6.y
                            width: parent.width - xd
                            height: 80
                            GridLayout{
                                columnSpacing: 3
                                rowSpacing: 1
                                anchors.rightMargin: 0
                                anchors.bottomMargin: 0
                                anchors.leftMargin: 0
                                anchors.topMargin: 0
                                rows: 6
                                columns: 3
                                anchors.fill: parent

                                CheckBox {
                                    text: qsTr("AVC")
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    text: qsTr("Cardiaque")
                                    Layout.fillWidth: true
                                    Layout.fillHeight: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    text: qsTr("Diabète")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    text: qsTr("Épliepsie")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    text: qsTr("Hyper/Hypo Tension")
                                    Layout.fillHeight: false
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }

                                CheckBox {
                                    id: abox
                                    text: qsTr("Autre")
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    font.pointSize: 8
                                }
                            }
                        }
                        Rectangle {
                            id: p5r8
                            x: xd
                            y: p5r7.height + p5r7.y
                            width: parent.width - xd*2
                            height: p5tarea2.implicitHeight > 90 ? p5tarea2.implicitHeight : 90
                            color: "#efefef"
                            radius: 8
                            TextInput {
                                id: p5tarea2
                                enabled: abox.checked
                                text: qsTr("")
                                padding: 5
                                wrapMode: Text.WordWrap
                                font.pointSize: 11
                                anchors.bottomMargin: xd/6
                                anchors.rightMargin: xd/2
                                anchors.leftMargin: xd/2
                                anchors.topMargin: xd/6
                                anchors.fill: parent
                            }
                        }
                    }
                }
            }
            Item {
                id: sixthPage
                Flickable{
                    anchors.fill: parent
                    contentWidth: parent.width
                    contentHeight: p3rec.childrenRect.height
                    Rectangle {
                        id: p6rec
                        y: 0
                        x: 0
                        height: childrenRect.height
                        width: parent.width
                        Rectangle {
                            id: p6r2
                            x: xd/2
                            width: parent.width - xd
                            height: 25 + 8
                            Pane {
                                x: 5
                                width: parent.width - 10
                                height: parent.height - 8
                                Material.elevation: 1
                                Material.background: colorp
                                RowLayout{
                                    anchors.fill: parent
                                    Label {
                                        text: qsTr("OPQRST")
                                        leftPadding: 20
                                        Layout.maximumHeight: 30
                                        color: colorlt
                                        verticalAlignment: Text.AlignVCenter
                                        horizontalAlignment: Text.AlignLeft
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.fillHeight: true
                                        Layout.fillWidth: true
                                    }
                                }
                            }

                        }
                        Rectangle {
                            id:p6r3
                            x: xd
                            y: p6r2.height + p6r2.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("O :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                        Rectangle {
                            id: p6r4
                            x: xd
                            y: p6r3.height + p6r3.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("P :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                        Rectangle {
                            id: p6r5
                            x: xd
                            y: p6r4.height + p6r4.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("Q :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                        Rectangle {
                            id: p6r6
                            x: xd
                            y: p6r5.height + p6r5.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("R :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                        Rectangle {
                            id: p6r7
                            x: xd
                            y: p6r6.height + p6r6.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("S :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                        Rectangle {
                            id: p6r8
                            x: xd
                            y: p6r7.height + p6r7.y
                            width: parent.width - xd*2
                            height: 40
                            RowLayout{
                                anchors.fill: parent
                                Label {
                                    text: qsTr("T :")
                                    Layout.maximumWidth: 80
                                    leftPadding: xd
                                    font.pointSize: 25
                                    Layout.maximumHeight: 30
                                    verticalAlignment: Text.AlignVCenter
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    color: colora

                                }
                                TextField {
                                    leftPadding: 5
                                    bottomPadding: 8
                                    Layout.maximumHeight: 40
                                    horizontalAlignment: Text.AlignLeft
                                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                    Layout.fillHeight: true
                                    Layout.fillWidth: true
                                    Material.accent: colora
                                }
                            }
                        }
                    }
                }
            }
        }


        PageIndicator {
            id: indicator
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: false
            Layout.fillWidth: false
            count: view.count
            currentIndex: view.currentIndex
        }


        Pane {
            id: footer
            width: parent.width
            height: 80
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 80
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            Material.elevation: 4
            GridLayout {
                anchors.fill: parent
                Button {
                    id: cancelbutton
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmleave.show();
                    }
                }
                Button {
                    text: qsTr("Sauvegarder")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmsave.show();
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmsave
        x: parent.width / 10
        y: parent.height / 4.5
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: Material.Amber
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            RowLayout{
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.maximumHeight: 50
                spacing: 2.0
                Label {
                    text: qsTr("Nom:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: 12
                }
                // Replace with a combobox populated by the matricule
                TextField {
                    text: qsTr("")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: tfieldMatricule.width
                    font.pointSize: 12
                }
            }
            RowLayout {
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumHeight: 50
                spacing: 2.0
                Label {
                    text: qsTr("Matricule:")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    font.pointSize: 12
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                }
                // Replace with a combobox populated by the matricule
                TextField {
                    id: tfieldMatricule
                    text: qsTr("")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: 12
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                }
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colordp

                    onClicked: {
                        mview.enabled = true;
                        promptconfirmsave.hide();
                    }
                }
                Button {
                    text: qsTr("Soumettre")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        save();
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmleave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*y
        Material.background: Material.Amber
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
                Label {
                    text: qsTr("Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer..")
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    wrapMode: Text.WordWrap
                    Layout.maximumHeight: 50
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    font.pointSize: 14
                }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmleave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colordp
                    onClicked: {
                        winchange(medimain);
                    }
                }
            }
        }
    }
}

