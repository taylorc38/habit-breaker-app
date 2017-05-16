import QtQuick 2.0

Item {
    id: root

    property alias settings: _settings
    property alias appFont: fontLoader
    property alias fontSizes: _fontSizes
    property alias paths: _paths
    property alias dimens: _dimensions

    property bool prod: false
    property bool setupRequired: false

    property var buttonModels: {
        "back" : { "id" : "back", "iconSource" : paths.iconPath + "back.png", "pressedSource" : paths.iconPath + "back-pressed.png" }
    }
    QtObject {
        id: _settings

        property int user_id
        property string username
        property string skin: "default"
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

    QtObject {
        id: _fontSizes

        property int small: 16
        property int medium: 20
        property int regular: 24
        property int large: 36
    }

    QtObject {
        id: _paths

        property string iconPath: Qt.resolvedUrl("qrc:/icons/")
        property string fontPath: Qt.resolvedUrl("qrc:/fonts/")
        property string database: "config_db"
    }

    QtObject {
        id: _dimensions

        property int iconWidth: 50
        property int iconHeight: 50
    }
}
