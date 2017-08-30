import QtQuick 2.8
import QtQuick.Controls 2.2



Button {
    property int swidth: 32
    property int sheight: 32
    property alias source: im.source
    leftPadding: im.width
    clip: true
    Image {
        id: im
        x: 5
        width: swidth > parent.width - 10 ? parent.width - 10 : swidth
        height: sheight > parent.height - 10 ? parent.height - 10: sheight
        y: (parent.height - sheight) / 2
        fillMode: Image.Stretch
    }

}
