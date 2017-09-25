import QtQuick 2.4
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1

Item {
    width: parent.width
    height: parent.height
    function ready() {

    }

    ColumnLayout {
        id: mview
        anchors.rightMargin: parent.width / 8
        anchors.leftMargin: parent.width / 8
        anchors.bottomMargin: parent.height / 5.5
        anchors.topMargin: parent.height / 5.5
        anchors.fill: parent
        spacing: 5

        CButton {
            Material.foreground: colorlt
            Material.background: colordp
            Layout.fillHeight: true
            Layout.fillWidth: true
            source: "Icons/ic_invert_colors_white_24dp.png"
            text: "Incendie"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                pressedIncendie();
            }
        }

        CButton {
            source: "Icons/ic_content_paste_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            text: "Medical"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                pressedMedical();
            }
        }

        CButton {
            source: "Icons/ic_content_paste_white_24dp.png"
            Material.foreground: colorlt
            Material.background: colordp
            text: "Calendrier"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            onClicked: {
                pressedEvents();
            }
        }
    }


}
