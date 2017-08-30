import QtQuick 2.8
import QtQuick.Controls 2.2

Button {
    property int iwidth: 32
    property int iheight: 32
    property alias source: im.source

    Image {
        id: im
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        width: iwidth
        height: iheight
        fillMode: Image.Stretch
    }

}
