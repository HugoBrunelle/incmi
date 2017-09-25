import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: parent.width
    property int pad: 5
    property int footerheight: 70

    Component.onCompleted: {
        var obj = requestPeopleListServer();
        for (var i = 0; i < obj.items.length; i++){
            var t = obj.items[i];
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
        height: parent.height - 3*pad - footer.height
        model: ListModel { id: mod}
        delegate: MemberListDelegate {}
    }

    Item {
        id: footer
        x: pad
        y: parent.height - footer.height - pad
        height: footerheight
        width: parent.width - 2*pad
        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 2 - 2*pad
            x: parent.width / 2- pad
            text: "Confirm"
            Material.foreground: colorlt
            Material.background: colorp

            onClicked: {
                doneMembers();
            }
        }
    }

}
