import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: parent.width
    property int pad: 5

    Component.onCompleted: {
        var obj = requestPeopleListServer();
        for (var i = 0; i < obj.items.length; i++){
            mod.append(obj.items[i]);
        }
    }


    ListView {
        clip: true
        interactive: true
        spacing: 1
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - buttonfooter.height
        model: ListModel { id: mod}
        delegate: PeopleListDelegate {}
    }

    Item {
        id: buttonfooter
        x: pad
        y: parent.height - buttonfooter.height - pad
        height: 70
        width: parent.width - 2*pad

        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width * 3 / 4 - pad
            text: "Remove"
            enabled: hasselection
            Material.background: colorp
            Material.foreground: colorlt
            onClicked: {
                for (var i = 0; i < checkedobjects.length; i++){
                    var obj = JSON.parse(checkedobjects[i]);
                    for (var b = mod.count - 1; b > -1; b--) {
                        if (mod.get(b).filename == obj.filename) {
                            mod.remove(b);
                        }
                    }
                }
                removeObjects();
            }
        }

        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width / 2 - pad
            text: "Add Person"
            Material.foreground: colorlt
            Material.background: colorp

            onClicked: {
                newPerson();
            }
        }

        Label {
            y: parent.height - implicitHeight - pad
            width: implicitWidth
            x: pad
            text: "To edit a person, double click the item"
            font.pointSize: 8
            font.italic: true
            verticalAlignment: Text.AlignVCenter
        }
    }

}
