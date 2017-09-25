import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: 431
    width: 580
    property int pad: 5
    property bool hasselection: false
    property bool isnew: false
    property var currentobj
    property var checkedobjects: []

    Pane {
        id: title
        x: pad
        y: pad
        width: parent.width - 2*pad
        height: (parent.height / 8) - 2*pad
        Material.background: colordp
        Material.elevation: 5
        Label {
            x: pad * 5
            text: "People Management"
            font.pointSize: 14
            width: parent.width - 2*x
            height: parent.height
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            Material.foreground: colorlt
        }
    }
    Rectangle {
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - title.height
        y: title.y + title.height + pad
        border.color: "lightgrey"
        border.width: 1
        StackView {
            anchors.fill: parent
            clip: true
            id: ld
            initialItem: plist
        }
    }

    Component {
        id: plist
        PeopleListSettings {}
    }

    Component {
        id: peditor
        PeopleEditorSettings {}
    }

    function newPerson() {
        isnew = true;
        ld.push(peditor);
    }

    function seeList() {
        clearObjects();
        ld.push(plist);
    }

    function editPerson(jobj) {
        currentobj = jobj
        isnew = false;
        ld.push(peditor);
    }

    function checkChanged(condition, obj) {
        switch (condition) {
        case true:
            checkedobjects.push(JSON.stringify(obj));
            checkRemove();
            break;
        case false:
            for (var i = checkedobjects.length -1; i > 0; i--){
                var ot = JSON.parse(checkedobjects[i]);
                if (ot.filename == obj.filename) {
                    checkedobjects.splice(i,1);
                }
            }
            checkRemove();
            break;
        }
    }

    function checkRemove() {
        if (checkedobjects.length > 0){
            hasselection = true;
        }else {
            hasselection = false;
        }
    }

    function removeObjects() {
        removePersonServer(checkedobjects);
        checkedobjects = [];
        checkRemove();
    }

    function clearObjects() {
        checkedobjects = [];
        checkRemove();
    }
}
