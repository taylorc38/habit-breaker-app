pragma Singleton
import QtQuick 2.0

Item {
    id: root

    property alias settings: _settings
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
        property string userName
        property string skin
    }

    QtObject {
        id: _paths

        property string iconPath: Qt.resolvedUrl("qrc:/icons/")
        property string database: "config_db"
    }

    QtObject {
        id: _dimensions

        property int iconWidth: 50
        property int iconHeight: 50
    }
}
