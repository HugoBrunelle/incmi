import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Item {
    width: parent.width
    height: 130
    property string sepcolor: "grey"
    property int pad: 8

    Component.onCompleted: {
        var val = parseInt(difference);
        if (val > 0) {
            ldif.color = "green";
        }else if (val = 0) {
            ldif.color = "black";
        }else if (val < 0) {
            ldif.color = "red";
        }
    }

    Item {
        anchors.fill: parent
        anchors.margins: 3

        Item {
            height: parent.height - 4
            width: parent.width
            Item {
                id: i1
                height: (parent.height - 5*pad) / 4
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
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: name
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Item {
                id: i2
                height: (parent.height - 5*pad) / 4
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
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: count
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Item {
                id: i3
                height: (parent.height - 5*pad) / 4
                y: i2.y + i2.height + pad
                x: pad
                width: parent.width - 2*pad
                Label {
                    id: lb
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Changements apporter au compte: "
                    leftPadding: 2
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    id: ldif
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: difference
                    verticalAlignment: Text.AlignVCenter
                }
            }
            Item {
                id: i4
                height:(parent.height - 5*pad) / 4
                y: i3.y + i3.height + pad
                x: pad
                width: parent.width - 2*pad
                Label {
                    id: l4
                    width: lb.implicitWidth
                    height: parent.height
                    x: pad
                    text: "Compte recommender : "
                    verticalAlignment: Text.AlignVCenter
                }
                Label {
                    x: lb.x + pad + lb.width
                    height: parent.height
                    width: parent.width - lb.width - 3*pad
                    text: rcount
                    verticalAlignment: Text.AlignVCenter
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
