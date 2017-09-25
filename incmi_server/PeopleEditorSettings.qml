import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.2

Item {
    height: parent.height
    width: parent.width
    property int pad: 5
    property int textboxheight: 30
    property bool cansave: false

    Component.onCompleted: {
        if (!isnew) {
            tfirstname.text = currentobj.firstname;
            tlastname.text = currentobj.lastname;
            tmatricule.text = currentobj.matricule;
            temail.text = currentobj.email;
            trole.text = currentobj.role;
            sadmin.checked = currentobj.isadmin;
        }
    }


    Item {
        y: pad
        x: pad
        width: parent.width - 2*pad
        height: parent.height - 3*pad - buttonfooter.height


        Label {
            id: lb
            y: pad
            x: pad
            text: "First Name : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r1
            x: lb.x + lb.width + pad
            y: pad
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: tfirstname
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tlastname
                text: ""
                onTextChanged: {
                    checkSave();
                }
            }
        }
        Label {
            y: r2.y
            x: pad
            text: "Last Name : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r2
            x: lb.x + lb.width + pad
            y: pad + r1.height + r1.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: tlastname
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                text: ""
                KeyNavigation.tab: tmatricule

                onTextChanged: {
                    checkSave();
                }
            }
        }
        Label {
            y: r3.y
            x: pad
            text: "Matricule : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r3
            x: lb.x + lb.width + pad
            y: pad + r2.height + r2.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: tmatricule
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: temail
                text: ""
                onTextChanged: {
                    checkSave();
                }
            }
        }
        Label {
            y: r4.y
            x: pad
            text: "Email : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r4
            x: lb.x + lb.width + pad
            y: pad + r3.height + r3.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: temail
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: trole
                text: ""
            }
        }
        Label {
            y: r5.y
            x: pad
            text: "Role : "
            verticalAlignment: Text.AlignVCenter
            font.pointSize: 10
            height: r1.height
        }
        Rectangle {
            id: r5
            x: lb.x + lb.width + pad
            y: pad + r4.height + r4.y
            width: parent.width - 3*pad - lb.width
            height: textboxheight
            color: "white"
            border.color: "lightgrey"
            border.width: 1
            radius: 3
            TextInput {
                id: trole
                selectByMouse: true
                font.pointSize: 10
                anchors.fill: parent
                anchors.margins: 3
                anchors.leftMargin: 15
                verticalAlignment: Text.AlignVCenter
                KeyNavigation.tab: tfirstname
                text: ""
            }
        }
        CheckBox {
            id: sadmin
            x: lb.x + lb.width + pad
            y: r5.y + r5.height + pad
            height: textboxheight
            width: parent.width - 3*pad - lb.width
            text: "Is Administrator"
            checked: false
        }
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
            text: "Cancel"
            Material.background: colorp
            Material.foreground: colorlt
            onClicked: {
                seeList();
            }
        }

        Button {
            y: parent.height / 5
            height: parent.height * 3/ 5
            width: parent.width / 4 - 2*pad
            x: parent.width / 2 - pad
            Material.background: colorp
            Material.foreground: colorlt
            enabled: cansave
            text: "Save"
            onClicked: {
                save();
                seeList();
            }
        }
    }

    function checkSave() {
        if (tfirstname.text == "" || tlastname.text == "" || tmatricule.text == ""){
            cansave = false;
        }
        else {
            cansave = true;
        }
    }

    function save() {
        var obj = JSON.parse(peoplebase);
        obj.firstname = tfirstname.text;
        obj.lastname = tlastname.text;
        obj.email = temail.text;
        obj.role = trole.text;
        obj.matricule = tmatricule.text;
        obj.isadmin = sadmin.checked;
        if (isnew) {
            createPersonServer(obj);
        }
        else{
            obj.filename = currentobj.filename;
            editPersonServer(obj);
        }
    }
}

