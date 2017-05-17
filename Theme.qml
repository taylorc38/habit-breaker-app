pragma Singleton
import QtQuick 2.0

Item {
    id: root

    property QtObject colors: getSkin(activeSkin)
    property string activeSkin: "default"

    function getSkin(skin) {
        switch (skin) {
        case "default":
            return _default
        case "secondary":
            return _secondary
        }
    }

    QtObject {
        id: _default

        property string primary: "#11B683"
        property string accent: "#FF3366"
        property string background: "#F9F9FB"
        property string dark: "#1F2532"
        property string primaryLight: "#21d39c"
        property string error: "#e50935"
        property string errorLight: "#f7385e"
    }

    QtObject {
        id: _secondary

        property string primary: "#11B683"
        property string accent: "#FF3366"
        property string background: "#F9F9FB"
        property string dark: "#1F2532"
        property string primaryLight: "#21d39c"
        property string error: "red"
    }
}
