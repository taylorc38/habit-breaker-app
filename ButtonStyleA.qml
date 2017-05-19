import QtQuick 2.0
import QtQuick.Controls.Styles 1.0
import "qrc:/global"

ButtonStyle {
    id: root

    property string colorDefault
    property string colorPressed
    property bool centerAlignText: false

    background: Rectangle {
        width: control.width
        height: control.height
        radius: 10
        color: control.pressed ? root.colorPressed : root.colorDefault
        border {
            width: 2
            color: Theme.colors.dark //control.pressed ? Theme.colors.accent : Theme.colors.dark
        }
    }
    label: Item {
        anchors.centerIn: parent
        AppLabel {
            anchors.centerIn: parent
            width: control.width * .80
            font.bold: true
            font.pointSize: properties.fontSizes.medium
            text: control.text
            color: Theme.colors.background
            wrapMode: Text.Wrap
            horizontalAlignment: root.centerAlignText ? Text.AlignHCenter : Text.AlignLeft
            Component.onCompleted: {
                control.labelWidth = paintedWidth
                control.labelHeight = paintedHeight
            }
        }
    }
}
