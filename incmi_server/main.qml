import QtQuick 2.8
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls.Material 2.2

ApplicationWindow {
    id: mainwindow
    visible: true
    width: 1280
    height: 720
    title: qsTr("IncMi Server")

    Material.accent: colora
    Connections{
        target: mainwindow
        onActiveChanged: {
            if (!mainwindow.active) {
                Qt.quit();
            }
        }
    }

    property color colorb: "#BDBDBD"
    property color colorst: "#757575"
    property color colort: "#212121"
    property color colorlt: "#FFFFFF"
    property color colorp: "#03A9F4"
    property color colorlp: "#B3E5FC"
    property color colordp: "#006da9"
    property color colora: "#607D8B"


    Component.onCompleted: {
        load.sourceComponent = main;
    }


    Rectangle {
        anchors.fill: parent
        color: colorlt
    }

    AsyncQAnimatedLoader {
        id: load
    }

    Component {
        id: main
        MainWindow {

        }
    }

    Component {
        id: login
        LoginWindow {

        }
    }

    OptionsWindow {
        id: options
        anchors.fill: parent
    }



}
