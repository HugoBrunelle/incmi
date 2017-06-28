import QtQuick 2.0
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.1

Item {
    x: 5
    width: parent.width - 10
    height: 65

    function vcolor(col){
        var val = parseInt(col)
        if (val === 0){
            tvcount.color = "black"
        }else if(val < 0) {
            tvcount.color = "red"
        }else{
            tvcount.color = "green"
        }
    }

    function add() {
        var val = (parseInt(tvcount.text) + 1).toString()
        vcolor(val);
        tvcount.text = val;
    }

    function subtract() {
        var val = parseInt(tvcount.text) - 1
        var tval = val + parseInt(account.text);
        if (tval < 0) {
            val += 1;
        }
        vcolor(val);
        tvcount.text = val.toString();
    }

    Component.onCompleted: {
        vcolor(tvcount.text);
    }


    Pane {
        Material.elevation: 1
        Material.background:"#F5F5F5"

        anchors.fill: parent
        RowLayout {
            anchors.rightMargin: 0
            anchors.bottomMargin: 0
            anchors.leftMargin: 0
            anchors.topMargin: 0
            anchors.fill: parent
            spacing: 2
            Text {
                id: mheight
                text: name
                fontSizeMode: Text.Fit
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }
            Rectangle {
                y : 2
                height: parent.height
                width: 1
                color: "darkgrey"
                Layout.fillHeight: true
            }
            Text {
                id: account
                text: acount
                Layout.maximumWidth: 50
                Layout.minimumWidth: 50
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                fontSizeMode: Text.Fit
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                y : 2
                height: parent.height
                width: 1
                color: "darkgrey"
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            }
            Text {
                id: tvcount
                text: vcount
                Layout.maximumWidth: 50
                Layout.minimumWidth: 50
                fontSizeMode: Text.HorizontalFit
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                anchors.verticalCenter: parent.verticalCenter
            }

            Button {
                id: minus
                text: qsTr("-")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.maximumWidth: 45
                Layout.minimumWidth: 45
                Layout.fillWidth: true
                Layout.fillHeight: true
                onClicked: {
                    subtract();
                }
            }

            Button {
                id: plus
                text: qsTr("+")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.minimumWidth: 45
                Layout.maximumWidth: 45
                Layout.fillHeight: true
                Layout.fillWidth: true
                onClicked: {
                    add();
                }
            }


        }
    }

}
