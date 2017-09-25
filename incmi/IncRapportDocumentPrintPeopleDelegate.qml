import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Item {
    width: parent.width
    height: 58
    property string sepcolor: "grey"
    property int pad: 5
    property int fontsize: 12

    Item {
        anchors.fill: parent
        anchors.margins: 3

        Item {
            height: parent.height - 4
            width: parent.width
            Item {
                id: i1
                height: (parent.height - 4*pad) / 2
                y: pad
                x: pad
                width: parent.width - 2*pad

                Label {
                    id: l1
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Nom: "
                    leftPadding: 2
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: firstname + " " + lastname
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
            }
            Item {
                id: i2
                height: (parent.height - 4*pad) / 2
                y: i1.y + i1.height + pad
                x: pad
                width: parent.width - 2*pad
                Label {
                    id: lb
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Matricule: "
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 2
                    font.pointSize: fontsize
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: matricule
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
            }
        }

        Rectangle {
            id: footer
            width: parent.width
            y: parent.height - 3
            height: 2
            color: sepcolor
        }
    }
}
