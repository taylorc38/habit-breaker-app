pragma Singleton
import QtQuick 2.0

Item {
    id: root

    property alias colors: _colors

    QtObject {
        id: _colors

        property string primary: "#CDFF00"
        property string accent: "#FF3B77"
        property string background: "#FFFFFF"
        property string mutedBackground: "#B8B89F"
        property string dark: "#52656B"
    }
}
