import QtQuick 2.0
import QtQuick.Controls 2.2

Item {
    height: 45
    width: 360
    property int xd: 1

    Rectangle {
        anchors.fill: parent;

        Label {
            id: code
            height: parent.height;
            x: xd;
            width: ((parent.width - 8) / 4);
            text: test;
            leftPadding: 5
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r1
            height: parent.height - 6;
            y: 3;
            x: code.x + code.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: date
            height: parent.height;
            x: xd + r1.width + r1.x;
            width: ((parent.width - 8) / 4);
            leftPadding: 5
            text: test;
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r2
            height: parent.height - 6;
            y: 3;
            x: date.x + date.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: lieu
            height: parent.height;
            x: xd + r2.width + r2.x;
            width: ((parent.width - 8) / 4);
            leftPadding: 5
            text: test;
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
        Rectangle {
            id: r3
            height: parent.height - 6;
            y: 3;
            x: lieu.x + lieu.width + xd;
            width: 1;
            color: "grey";

        }
        Label {
            id: nature
            height: parent.height;
            x: xd + r3.width + r3.x;
            leftPadding: 5
            width: ((parent.width - 8) / 4);
            text: test;
            horizontalAlignment: Text.AlignLeft;
            verticalAlignment: Text.AlignVCenter;
        }
    }
}
