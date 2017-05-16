import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4
import "qrc:/pages"
import "qrc:/global"
import "qrc:/components"
import "qrc:/config"
import "qrc:/config/Config.js" as Config

Item {
    id: root

    property bool consoleDebug: false // makes window tiny on mac

    // fired when DatabaseManager is ready
    signal appReady

    visible: true
    width: consoleDebug ? 0 : 750
    height: consoleDebug ? 0 : 1334

    onAppReady: {
        pageStack.goToPage("Home", {}, false)
        timerDebug.restart()
    }

    Timer {
        id: timerDebug
        interval: 2000
        onTriggered: {
            database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "name", "Boaty McBoatface"))
            database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "name"), function(data) {
                console.log("New userName = " + data[0].name)
            })
        }
    }

    HeaderBar {
        id: headerBar

        height: Screen.height * .08
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        currentPage: pageStack.currentPage
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

        }
    }

    DatabaseManager {
        id: database

        onReady: {
            // Load settings
            execute(SqlQueries.getAll(SqlQueries.tables.settings), function(data) {
                Properties.settings.user_id = data[0].user_id
                Properties.settings.userName = data[0].name
                Properties.settings.skin = data[0].skin
            })
            // Start the rest of the app
            root.appReady()
        }
    }
}
