import QtQuick 2.0
import "qrc:/global"

Item {
    id: root
    objectName: "Page"

    signal exit
    signal activated

    anchors.fill: parent

    onActivated: {
        console.log("Page activated: " + objectName)
    }

    onExit: {
        console.log("Page exit: " + objectName)
    }

    // Background
    Rectangle {
        anchors.fill: parent
        color: Theme.colors.background
    }

}
