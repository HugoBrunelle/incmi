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
    function formatHourText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
    }
    function formatMinuteText(modelData) {
        var data = modelData;
        return data.toString().length < 2 ? "0" + data : data;
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
            currentIndex: 0
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: firstPage
                    visible: true
                }
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: secondPage
                    visible: true
                }
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: thirdPage
                    visible: true
                }
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: fourthPage
                    visible: true
                }
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: fifthPage
                    visible: true
                }
                Loader {
                    asynchronous: true
                    active: SwipeView.isCurrentItem || SwipeView.isNextItem || SwipeView.isPreviousItem
                    sourceComponent: sixthPage
                    visible: true
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


        // All different swipeview pages, setup as components to be loaded on the fly.

        Component {
            id: firstPage
            Item{
                onHeightChanged: {
                   vp1bar.position = 0.0;
                }

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
                            id: tumbl
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
                    y: r1.height + r1.y
                    id: r2
                    x: xd/2
                    width: parent.width - xd
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
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 20
                                    Layout.maximumHeight: 40
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
                                    Layout.maximumWidth: 20
                                    Layout.maximumHeight: 40
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
                                    Layout.minimumWidth: 25
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 20
                                    Layout.maximumHeight: 40
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
                                    Layout.maximumWidth: 20
                                    Layout.maximumHeight: 40
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
                                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                                    Layout.maximumWidth: 20
                                    Layout.maximumHeight: 40
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
                size: view.height / (p1rec.height + 15)
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible: true
            }
        }
        }
        Component {
            id: secondPage
            Item {
                onHeightChanged: {
                   vp2bar.position = 0.0;
                }
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
                size: view.height / (p2rec.height + 15)
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible: true
            }
        }
        }
        Component {
            id: thirdPage
            Item {
                onHeightChanged: {
                   vp3bar.position = 0.0;
                }
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
                    color: "#efefef"
                    radius: 8
                    TextArea {
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
            ScrollBar {
                id: vp3bar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: view.height / (p3rec.height + 15)
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible: true
            }
            /*
            property bool prsd: false
            property int lasty: 0
            MouseArea {
                id: ar
                anchors.fill: parent
                enabled: true
                onMouseYChanged: {
                    if (prsd){
                        var change = ((lasty - mouse.y)/ar.height);
                        if (vp3bar.position + change < 0) {
                            vp3bar.position = 0
                        }else{
                            if ()
                        }

                        console.log("mouse y on move" + mouse.y.toString());
                        console.log(((lasty - mouse.y)/ar.height).toString());
                        lasty = mouse.y
                    }
                }

                onPressAndHold: {
                    console.log("Starting mousy  - " + mouse.y.toString());
                    lasty = mouse.y
                    prsd = true;
                }
                onReleased: {
                    prsd = false;
                    lasty = 0;
                }
            }
            */
            }
        }
        Component {
            id: fourthPage
            Item {
                onHeightChanged: {
                   vp4bar.position = 0.0;
                }
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
            ScrollBar {
                id: vp4bar
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.top: parent.top
                anchors.topMargin: 0
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: view.height / (p4rec.childrenRect.height + 15)
                visible: true
            }
        }
        }
        Component {
            id: fifthPage
            Item {
                onHeightChanged: {
                   vp5bar.position = 0.0;
                }
            Rectangle {
                id: p5rec
                y: - vp5bar.position * childrenRect.height
                x: 0
                height: childrenRect.height
                width: parent.width
                Rectangle {
                    id: p5r2
                    x: xd/2
                    width: parent.width - xd
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
                    height: 100
                    TextArea {
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
                    y: p5r3.height + p5r3.y
                    width: parent.width - xd
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
                                font.pointSize: 10
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
                                font.pointSize: 10
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
                    y: p5r5.height + p5r5.y
                    width: parent.width - xd
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
                            font.pointSize: 7
                        }

                        CheckBox {
                            text: qsTr("Cardiaque")
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            font.pointSize: 7
                        }

                        CheckBox {
                            text: qsTr("Diabète")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pointSize: 7
                        }

                        CheckBox {
                            text: qsTr("Épliepsie")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pointSize: 7
                        }

                        CheckBox {
                            text: qsTr("Hyper/Hypo Tension")
                            Layout.fillHeight: false
                            Layout.fillWidth: true
                            font.pointSize: 7
                        }

                        CheckBox {
                            id: abox
                            text: qsTr("Autre")
                            Layout.fillHeight: true
                            Layout.fillWidth: true
                            font.pointSize: 7
                        }
                    }
                }
                Rectangle {
                    id: p5r8
                    x: xd
                    y: p5r7.height + p5r7.y
                    width: parent.width - xd*2
                    height: 90
                    TextArea {
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
            ScrollBar {
                id: vp5bar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: view.height / (p5rec.height + 15)
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible: true
            }
        }
        }
        Component {
            id: sixthPage
            Item {
                onHeightChanged: {
                   vp6bar.position = 0.0;
                }
            Rectangle {
                id: p6rec
                y: - vp6bar.position * childrenRect.height
                x: 0
                height: childrenRect.height
                width: parent.width
                Rectangle {
                    id: p6r2
                    x: xd/2
                    width: parent.width - xd
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
            ScrollBar {
                id: vp6bar
                hoverEnabled: true
                active: hovered || pressed
                orientation: Qt.Vertical
                size: view.height / (p6rec.height + 15)
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                visible: true
            }
        }
        }

    }
}
