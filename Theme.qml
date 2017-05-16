pragma Singleton
import QtQuick 2.0

Item {
    id: root

    property alias colors: _default

    QtObject {
        id: _default

        property string primary: "#11B683"
        property string accent: "#FF3366"
        property string background: "#F9F9FB"
        property string dark: "#1F2532"
    }
}
