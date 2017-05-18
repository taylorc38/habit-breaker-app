import QtQuick 2.0
import QtQuick.Controls 1.0
import "qrc:/global"

Button {
    id: root

    property int labelWidth
    property int labelHeight
    property string colorDefault: Theme.colors.primary
    property string colorPressed: Theme.colors.primaryLight

    signal activated

    width: properties.dimens.buttonWidth
    height: properties.dimens.buttonHeight
    style: ButtonStyleA {
        colorDefault: root.colorDefault
        colorPressed: root.colorPressed
    }

    onClicked: {
        if (!debounce.running) {
            debounce.restart()
            root.activated()
        }
    }

    Timer {
        id: debounce
        interval: 100
    }
}
