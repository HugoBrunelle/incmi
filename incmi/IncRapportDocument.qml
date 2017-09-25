import QtQuick 2.7
import QtQuick.Controls.Material 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Rectangle {
    property int xd: 30
    property int labellength
    property int lrectheight: 40

    // All properties to write to for saving...

    property string date
    property string time
    property string adresse
    property string ville
    property string type
    property var people: []
    property var other: []
    property string femme
    property string homme
    property string enfant
    property var materiel: []

    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height
    Material.accent: colora


    function save() {
        // do all the saving work to create a JSON file and send it to the websocket.
        var obj = JSON.parse(incdocumentbase.slice(0,-1) + ',"messageindex":"20"}');
        obj.date = date;
        var person = JSON.parse(settings.user);
        obj.name = person.firstname + " " + person.lastname;
        obj.matricule = person.matricule;
        obj.time = time;
        obj.adresse = adresse;
        obj.ville = ville;
        obj.type = type;
        obj.people = people;
        obj.other = other;
        obj.femme = femme;
        obj.homme = homme;
        obj.enfant = enfant;
        obj.materiel = materiel
        console.log(JSON.stringify(obj));
        mess.push(JSON.stringify(obj));
        settings.messages = mess;
        sendSavedInformation();
    }

    ColumnLayout {
        id: mview
        spacing: 0
        anchors.fill: parent
        SwipeView {
            id: view
            clip: true
            topPadding: 10
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: 0
            Item {
                Loader {
                    width: parent.width
                    height: parent.height
                    active: true
                    sourceComponent: firstpage
                }
            }
            Item {
                Loader {
                    width: parent.width
                    height: parent.height
                    active: true
                    sourceComponent: secondpage
                }
            }
            Item {
                Loader {
                    width: parent.width
                    height: parent.height
                    active: true
                    sourceComponent: thirdpage
                }
            }
            Item {
                Loader {
                    width: parent.width
                    height: parent.height
                    active: true
                    sourceComponent: fourthpage
                }
            }

        }
        PageIndicator {
            id: indicator
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: false
            Layout.fillWidth: false
            count: view.count
            currentIndex: view.currentIndex
        }
        Pane {
            id: footer
            width: parent.width
            height: 70
            Layout.minimumHeight: 50
            Layout.fillHeight: true
            Layout.maximumHeight: 70
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Material.background: "#0288D1"
            Material.elevation: 4
            GridLayout {
                anchors.fill: parent
                CButton {
                    id: cancelbutton
                    text: qsTr("Annuler")
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.maximumWidth: 150
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    source: "Icons/ic_highlight_off_white_24dp.png"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmleave.show();
                    }
                }
                CButton {
                    text: qsTr("Envoyer")
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.maximumWidth: 150
                    Material.foreground: colorlt
                    Material.background: "#006da9"
                    source: "Icons/ic_cloud_upload_white_24dp.png"
                    onClicked: {
                        mview.enabled = false;
                        promptconfirmsave.show();
                    }
                }
            }
        }

    }
    Component {
        id: firstpage
        IncRapportFirstPage {}
    }
    Component {
        id: secondpage
        IncRapportSecondPage {}
    }
    Component {
        id: thirdpage
        IncRapportThirdPage {}
    }
    Component {
        id: fourthpage
        IncRapportFourthPage {}
    }

    Prompt {
        id: promptconfirmsave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            Label {
                text: settings.user == "" ? qsTr("Vous devez configurer votre compte avant tout... \n Merci!"): qsTr(
                                                "Êtes vous sur de vouloir sauvegarder les changements?\nNom: " +
                                                JSON.parse(settings.user).firstname + " " + JSON.parse(settings.user).lastname +
                                                "\nMatricule: " + JSON.parse(settings.user).matricule);
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                Material.foreground: colorlt
                wrapMode: Text.WordWrap
                Layout.maximumHeight: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 14
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: settings.user == "" ? qsTr("Ok") : qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmsave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    enabled: settings.user == "" ? false: true;
                    onClicked: {
                        save();
                        winchange(incm);
                    }
                }
            }
        }
    }
    Prompt {
        id: promptconfirmleave
        x: parent.width / 14
        y: parent.height / 4.0
        width: parent.width - 2*x
        height: parent.height - 2*(parent.height/4.5)
        Material.background: colora
        Material.elevation: 8
        ColumnLayout {
            anchors.fill: parent
            anchors.leftMargin: parent.width/15
            anchors.rightMargin: parent.width/15
            anchors.bottomMargin: (parent.height/20) * 3
            anchors.topMargin: (parent.height/20) * 3
            spacing: 5
            Label {
                text: qsTr("Êtes vous sur de vouloir quitter? Les changements non sauvegarder seronts effacer..")
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                wrapMode: Text.WordWrap
                Layout.maximumHeight: 50
                Layout.fillHeight: true
                Layout.fillWidth: true
                font.pointSize: 14
                Material.foreground: colorlt
            }
            RowLayout{
                spacing: 15
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom
                Layout.maximumHeight: 50
                Button {
                    text: qsTr("Non")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        mview.enabled = true;
                        promptconfirmleave.hide();
                    }
                }
                Button {
                    text: qsTr("Oui")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Material.foreground: colorlt
                    Material.background: colorp
                    onClicked: {
                        winchange(incm);
                    }
                }
            }
        }
    }
}

