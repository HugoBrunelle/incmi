import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Layouts 1.3


Rectangle {
    width: parent == null ? 360:parent.width
    height: parent == null ? 640:parent.height



    function pressedIncendie() {
        winchange(incm);
    }

    function pressedMedical() {
        winchange(medimain);
    }

    function pressedEvents() {
        winchange(events);
    }

    function pressedConfigureAccess() {
        optionsbutton.visible = false;
        sview.push(apicker);
    }

    function pressedIntervenant() {
        sview.push(ssettings);
        settings.isadmin = false;
        optionsbutton.visible = false;
    }

    function pressedAdministrateursConfirmed() {
        settings.isadmin = true;
        optionsbutton.visible = false;
        sview.push(ssettings);
    }

    function confirmSettings(selectedMember) {
        if (settings.isfirstboot) {
             settings.isfirstboot = false;
        }
        settings.user = selectedMember;
        optionsbutton.visible = true;
        sview.push(spicker);

    }

    function pressedOptions() {
        optionsbutton.visible = false;
        sview.push(ssettings);
    }

    function serverSettings() {
        sview.push(servsettings);
    }

    Pane {
        id: header
        height: 90
        width: parent.width + 10
        x: - 5
        Material.elevation: 4
        Material.background: colordp
        GridLayout {
            id: gridLayout
            anchors.fill: parent
            Image {
                fillMode: Image.PreserveAspectFit
                source: "Images/ucmu_100h.png"
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.maximumWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            }

            Label {
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                text: "Incmi"
                color: colorlt
                font.bold: true
            }

            ImageButton {
                id: optionsbutton
                Layout.fillHeight: true
                Layout.maximumHeight: header.height / 2
                Layout.maximumWidth: Layout.maximumHeight
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                source: "Icons/ic_settings_applications_white_24dp.png"
                Material.background: colordp
                Material.foreground: colorlt
                Material.elevation: 6
                visible: !settings.isfirstboot
                onClicked: {
                    visible = false;
                    sview.push(ssettings);
                }

                Behavior on visible {
                    ScriptAction {
                        script: {
                            var val;
                            switch (optionsbutton.visible) {
                            case true:
                                val = 0;
                                break;
                            case false:
                                val = 1;
                                break;
                            }
                            optionsbutton.opacity = val;
                        }
                    }
                }

                Behavior on opacity {
                    NumberAnimation {
                        duration: 190
                        easing.type: Easing.InQuad;
                    }
                }
            }
        }
    }

    Connections {
        target: window
        onDoEvents: {
          switch (settings.isfirstboot) {
          case true:
              sview.push(apicker);
              break;
          case false:
              sview.push(spicker);
              break;
          }
        }
    }


    StackView {
      id: sview
      y: header.height + 3
      width: parent.width
      height: parent.height - 3 - header.height
      clip: true
      onBusyChanged: {
          if (!busy) {
              sview.currentItem.ready();
          }
      }
    }



    Component {
        id: apicker
        AccessTypePicker {}
    }

    Component {
        id: spicker
        IntroForm {}
    }

    Component {
        id: ssettings
        SettingsWindow {}
    }

    Component {
        id: servsettings
        ServerSettingsView {}
    }

}


