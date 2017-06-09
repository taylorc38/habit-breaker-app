import QtQuick 2.0

Item {
    id: root

    property alias settings: _settings
    property alias appFont: fontLoader
    property alias appFontBig: fontLoader_big
    property alias fontSizes: _fontSizes
    property alias paths: _paths
    property alias dimens: _dimensions

    property bool prod: true
    property bool setupRequired: false

    property string appTitle: "Habit Breaker"
    property string appNotificationBody: "Check out your daily report!"

    QtObject {
        id: _settings

        property int user_id
        property string username
        property string skin: "default"
        property int countdown
        property int eod
        property int dndTo
        property int dndFrom
    }

    // ios already has this font and doesn't like loading my .ttf file...
    FontLoader {
        id: fontLoader
        name: "American Typewriter"
//        source: paths.fontPath + "AmericanTypewriterRegular.ttf"
        onStatusChanged: {
            console.log("Font status = " + status)
        }
    }

    FontLoader {
        id: fontLoader_big
        name: "Great Lakes"
        source: paths.fontPath + "GreatLakes.ttf"
        onStatusChanged: {
            console.log("Font_big status = " + status)
        }
    }

    QtObject {
        id: _fontSizes

        property int small: 16
        property int medium: 20
        property int regular: 24
        property int large: 36
        property int huge: 48
    }

    QtObject {
        id: _paths

        property string iconPath: Qt.resolvedUrl("qrc:/icons/")
        property string imagePath: Qt.resolvedUrl("qrc:/images/")
        property string fontPath: Qt.resolvedUrl("qrc:/fonts/")
        property string database: "config_db"
    }

    QtObject {
        id: _dimensions

        property int iconWidth: 50
        property int iconHeight: 50
        property int buttonWidth: 150
        property int buttonHeight: 100
    }
}
