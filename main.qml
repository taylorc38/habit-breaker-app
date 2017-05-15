import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "qrc:/pages"
import "qrc:/global"
import "qrc:/components"

Window {
    visible: true
    width: 750
    height: 1334

    HeaderBar {
        id: headerBar

        height: Screen.height * .05
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
    }

    PageStackView {
        id: pageStack

        anchors {
            top: headerBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        pathToPages: Qt.resolvedUrl("qrc:/pages/")
        debug: false

        onPageLoaded: {
            headerBar.refreshModels(filename)
        }
    }

    Component.onCompleted: {
        pageStack.goToPage("Home", {}, false)
    }
}
