import QtQuick 2.0
import "qrc:/global"

Page {
    id: root
    objectName: "Home"

    Text {
        anchors.centerIn: parent
        text: "Hello, " + Properties.userSettings.userName
        color: "black"
        font.pointSize: 28
    }
}
