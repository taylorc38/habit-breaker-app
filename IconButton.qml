import QtQuick 2.0

Image {
    id: root

    property string iconSource: ""
    property string pressedSource: ""

    source: iconSource
    width: properties.dimens.iconWidth
    height: properties.dimens.iconHeight
    fillMode: Image.Stretch

    signal activated

    MouseArea {
        anchors.fill: parent

        onPressedChanged: {
            if (pressed) {
                if (pressedSource != "")
                    source = pressedSource
            } else {
                source = iconSource
            }
        }

        onClicked: {
            if (!debounce.running) {
                debounce.restart()
                root.activated()
            }
        }
    }

    Timer {
        id: debounce
        interval: 100
    }
}
