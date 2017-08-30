import QtQuick 2.8
import QtQuick.Controls 2.2

Button {
    property int swidth: 28
    property int sheight: 28
    property alias source: im.source
    property int leftPad: 12
    leftPadding: im.width
    clip: true
    Image {
        id: im
        x: leftPad
        width: swidth
        height: sheight
        y: (parent.height - sheight) / 2
        fillMode: Image.Stretch
        clip: true
    }

}
