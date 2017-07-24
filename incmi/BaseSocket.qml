import Qt.labs.settings 1.0
import QtWebSockets 1.1
import QtQuick 2.9

WebSocket {
    property string port: "2565"
    property string host: "192.168.0.108"
    url: "ws://" + host + ":" + port
}
