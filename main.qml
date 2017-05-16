import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "qrc:/pages"
import "qrc:/global"
import "qrc:/components"
import "qrc:/config"
import "qrc:/config/Config.js" as Config

Item {
    id: engine

    property bool consoleDebug: true

    visible: true
    width: consoleDebug ? 0 : 750
    height: consoleDebug ? 0 : 1334

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

    DatabaseManager {
        id: database
    }

//    SqlListModel {
//        id: modelSettings

//        query: "SELECT * FROM settings"

//        onReady: {
//            console.log(JSON.stringify(data))
//        }
//    }

    Component.onCompleted: {
        pageStack.goToPage("Home", {}, false)
//        console.log(JSON.stringify(Config.settings))
    }
}
