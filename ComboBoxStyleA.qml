import QtQuick 2.0
import QtQuick.Controls.Styles 1.0
import "qrc:/global"

ComboBoxStyle {
    background: Rectangle {
        width: control.width
        height: control.height
        radius: 10
        color: Theme.colors.background
        border {
            width: 2
            color: control.pressed ? Theme.colors.accent : Theme.colors.dark
        }
        Image {
            id: icon
            height: parent.height * .50
            width: height
            anchors {
                right: parent.right; rightMargin: width * .25
                verticalCenter: parent.verticalCenter
            }
            source: properties.paths.iconPath + (control.pressed ? "arrow-down-pressed.png" : "arrow-down.png")
            fillMode: Image.Stretch
        }
    }
    label: Item {
        anchors {
            right: parent.right; rightMargin: control.height * .50 * .25 + 10
            verticalCenter: parent.verticalCenter
        }

        AppLabel {
            anchors {
                centerIn: parent
            }
            font.pointSize: properties.fontSizes.medium
            text: control.currentText
        }
    }
}
