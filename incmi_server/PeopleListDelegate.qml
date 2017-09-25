import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    width: parent.width
    height: 38
    property int pad: 3
    property string seperatorcolor: "grey"
    property int seperatorwidth: 1
    Rectangle {
        anchors.fill: parent
        border.color: "lightgrey"
        border.width: 1
        MouseArea {
            anchors.fill: parent
            onDoubleClicked: {
                dclicked()
            }
        }

        CheckBox {
            id: name
            x: pad
            y: pad
            width: parent.width * 2 / 3 - 2*pad
            height: parent.height - 2*pad
            text: firstname + " " + lastname
            onDoubleClicked: {
                dclicked();
            }
            onCheckedChanged: {
                checkChanged(checked,getObject());
            }
        }

        Rectangle {
            x: parent.width * 2 / 3 - pad / 2
            y: pad * 2
            width: seperatorwidth
            height: parent.height - 4*pad
            color: seperatorcolor
        }

        Label {
            id: lrole
            x: parent.width * 2 / 3 + pad
            y: pad
            width: parent.width / 3 - 2*pad
            height: parent.height - 2*pad
            text: role
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    function dclicked() {
        var obj = getObject();
        editPerson(obj);
    }

    function getObject() {
        var obj = JSON.parse(peoplebase);
        obj.firstname = firstname;
        obj.lastname = lastname;
        obj.role = role;
        obj.matricule = matricule;
        obj.email = email;
        obj.filename = filename;
        obj.isadmin = isadmin;
        return obj
    }
}
