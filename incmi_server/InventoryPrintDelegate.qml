import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Item {
    width: parent.width
    height: 85
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
                height: (parent.height - 4*pad) / 3
                y: pad
                x: pad
                width: parent.width - 2*pad

                Label {
                    id: l1
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Objet d'inventaires: "
                    leftPadding: 2
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: name
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
            }
            Item {
                id: i2
                height: (parent.height - 4*pad) / 3
                y: i1.y + i1.height + pad
                x: pad
                width: parent.width - 2*pad
                Label {
                    id: l2
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Compte actuelle: "
                    verticalAlignment: Text.AlignVCenter
                    leftPadding: 2
                    font.pointSize: fontsize
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: count
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
            }
            Item {
                id: i3
                height: (parent.height - 4*pad) / 3
                y: i2.y + i2.height + pad
                x: pad
                width: parent.width - 2*pad
                Label {
                    id: lb
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Compte recommender: "
                    leftPadding: 2
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize: fontsize
                }
                Label {
                    id: ldif
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: rcount
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
