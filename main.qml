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
    property string appTitle: "HabitBreaker"

    // fired when DatabaseManager is ready
    signal appReady

    visible: true
    width: consoleDebug ? 0 : 750
    height: consoleDebug ? 0 : 1334

    onAppReady: {
//        pageStack.goToPage("Home", {}, false)
        if (properties.setupRequired) {
            pageStack.goToPage("Setup", {}, false)
        } else {
            pageStack.goToPage("Home", {}, false)
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

    Properties {
        id: properties
    }

    DatabaseManager {
        id: database

        onReady: {
            // Load settings
            execute(SqlQueries.getAll(SqlQueries.tables.settings), function(data) {
                SqlQueries.user_id = data[0].user_id
                properties.settings.user_id = data[0].user_id
                properties.settings.username = data[0].name
                properties.settings.skin = data[0].skin
                properties.settings.countdown = data[0].countdown
                properties.settings.eod = data[0].eod
                properties.settings.dndFrom = data[0].dndFrom
                properties.settings.dndTo = data[0].dndTo
            })
            // Start the rest of the app
            root.appReady()
        }
    }

    SettingsManager {
        id: settings
        database: database
    }

    DebugTab {
        id: debugTab

        anchors {
            bottom: parent.bottom
            left: parent.left
        }
        z: 100
    }

}
