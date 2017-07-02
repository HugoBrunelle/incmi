import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQml 2.2

Rectangle {
    property alias meddoccancel: cancel
    property alias meddocsave: save
    property int xd: 30
    width: 360
    height: 640
    Material.accent: colora

    
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

    function setNumberOfDays(){
        if(tumbler.currentItem != null){
            var dat = new Date(parseInt(tumbler2.currentItem.text), parseInt(tumbler1.currentItem.text), 0).getDate();
            var index = tumbler.currentIndex
            tumbler.model = dat
            tumbler.currentIndex = index
        }
    }

    ColumnLayout {
        id: columnLayout
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
                    Layout.minimumWidth: 100
                    Layout.maximumWidth: 250
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
            
            onHeightChanged: {
                vp1bar.position = 0.0;
                vp2bar.position = 0.0;
                vp3bar.position = 0.0;
                vp4bar.position = 0.0;
            }

            Item {
                id: firstPage
                Rectangle {
                    id: p1rec
                    y: - vp1bar.position * childrenRect.height
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
                                id: tumbler
                                Layout.maximumWidth: 25
                                Layout.maximumHeight: 40
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
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.maximumWidth: 25
                                Layout.maximumHeight: 40
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
                                    setNumberOfDays();
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
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.maximumWidth: 32
                                currentIndex: 5
                                visibleItemCount: 3
                                Layout.maximumHeight: 40
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
                                    setNumberOfDays();
                                }

                                model: 25
                            }
                        }
                    }
                    Rectangle {
                        y: r1.height + r1.y
                        id: r2
                        x: xd/2
                        width: parent.width - xd
                        height: 35
                        Pane {
                            x: 5
                            y: -2
                            width: parent.width - 10
                            height: parent.height
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
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                            setNumberOfDays();
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
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                        Layout.minimumWidth: 25
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                            setNumberOfDays();
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
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                        Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                        Layout.maximumWidth: 20
                                        Layout.maximumHeight: 40
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
                                            setNumberOfDays();
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }
                }
                ScrollBar {
                    id: vp1bar
                    hoverEnabled: true
                    active: hovered || pressed
                    orientation: Qt.Vertical
                    size: view.height / p1rec.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    visible: true
                }
            }
            Item {
                id: secondPage
                Rectangle {
                    id: p2rec
                    y: - vp2bar.position * childrenRect.height
                    x: 0
                    height: childrenRect.height
                    width: parent.width
                    Rectangle {
                        id: p2r2
                        x: xd/2
                        width: parent.width - xd
                        height: 35
                        Pane {
                            x: 5
                            y: -2
                            width: parent.width - 10
                            height: parent.height
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
                                text: qsTr("Date de naissance (jj/mm/yy) :")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            Label {
                                text: qsTr("/")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            Label {
                                text: qsTr("/")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }

                }
                ScrollBar {
                    id: vp2bar
                    hoverEnabled: true
                    active: hovered || pressed
                    orientation: Qt.Vertical
                    size: view.height / p2rec.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    visible: true
                }
            }
            Item {
                id: thirdPage
                Rectangle {
                    id: p3rec
                    y: - vp3bar.position * childrenRect.height
                    x: 0
                    height: childrenRect.height
                    width: parent.width
                    Rectangle {
                        id: p3r2
                        x: xd/2
                        width: parent.width - xd
                        height: 30
                        Pane {
                            x: 5
                            y: -2
                            width: parent.width - 10
                            height: parent.height
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
                        y: p3r2.height + p3r2.y + 5
                        width: parent.width - xd*2
                        height: 25
                        Pane {
                            x: 5
                            y: -2
                            width: parent.width - 10
                            height: parent.height
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
                        x: xd / 2
                        y: p3r3.height + p3r3.y
                        width: parent.width - xd
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
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox11
                                text: qsTr("Acr / Code")
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox10
                                text: qsTr("Convulsion")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox9
                                text: qsTr("Diabète")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox8
                                text: qsTr("Douleur Thoracique")
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox7
                                text: qsTr("Faibless")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox6
                                text: qsTr("Hyperthermie")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox5
                                text: qsTr("Hypothermie")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox4
                                text: qsTr("Intoxication")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox3
                                text: qsTr("Mal de Tête")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox2
                                text: qsTr("Obstr. Voies Resp.")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox1
                                text: qsTr("Trauma")
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                font.pointSize: 7
                            }

                            CheckBox {
                                id: checkBox
                                text: qsTr("Autre:")
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                                font.pointSize: 7
                            }
                        }
                    }
                    Rectangle {
                        id: p3r7
                        x: xd/2
                        y: p3r4.height + p3r4.y
                        width: parent.width - xd
                        height: 130

                        TextArea {
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
                ScrollBar {
                    id: vp3bar
                    hoverEnabled: true
                    active: hovered || pressed
                    orientation: Qt.Vertical
                    size: view.height / p3rec.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    visible: true
                }
            }
            Item {
                id: fourthPage
                Rectangle {
                    id: p4rec
                    y: - vp4bar.position * childrenRect.height
                    x: 0
                    height: childrenRect.height
                    width: parent.width

                    Rectangle {
                        id: p4r2
                        x: xd/2
                        width: parent.width - xd
                        height: 35
                        Pane {
                            x: 5
                            y: -2
                            width: parent.width - 10
                            height: parent.height
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
                        id:p4r3
                        x: xd
                        y: p4r2.height + p4r2.y
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
                        id: p4r4
                        x: xd
                        y: p4r3.height + p4r3.y
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
                        id: p4r5
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

                            RadioButton {
                                text: qsTr("M")
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                                Layout.maximumWidth: 50
                            }

                            RadioButton {
                                text: qsTr("F")
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.maximumWidth: 50
                                Layout.fillWidth: true
                                Layout.fillHeight: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r6
                        x: xd
                        y: p2r5.height + p2r5.y
                        width: parent.width - xd*2
                        height: 40
                        RowLayout{
                            anchors.fill: parent
                            Label {
                                text: qsTr("Date de naissance (jj/mm/yy) :")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            Label {
                                text: qsTr("/")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                            Label {
                                text: qsTr("/")
                                Layout.maximumHeight: 30
                                verticalAlignment: Text.AlignVCenter
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: false
                            }
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: true
                                Layout.fillWidth: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r7
                        x: xd
                        y: p4r6.height + p4r6.y
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r8
                        x: xd
                        y: p4r7.height + p4r7.y
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r9
                        x: xd
                        y: p4r8.height + p4r8.y
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r10
                        x: xd
                        y: p4r9.height + p4r9.y
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }
                    Rectangle {
                        id: p4r11
                        x: xd
                        y: p4r10.height + p4r10.y
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
                            TextField {
                                leftPadding: 5
                                bottomPadding: 8
                                Layout.maximumHeight: 40
                                horizontalAlignment: Text.AlignLeft
                                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                                Layout.fillHeight: false
                                Layout.fillWidth: true
                            }
                        }
                    }

                }
                ScrollBar {
                    id: vp4bar
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    hoverEnabled: true
                    active: hovered || pressed
                    orientation: Qt.Vertical
                    size: view.height / p4rec.childrenRect.height
                    visible: true
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
                    id: cancel
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                }
                Button {
                    id: save
                    text: qsTr("Sauvegarder")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                }
            }
        }
    }
}
