import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Reward"

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top; topMargin: root.height * .10
        }
        width: root.width
        spacing: 30

        AppLabel {
            width: parent.width * .80
            anchors.horizontalCenter: parent.horizontalCenter
            text: stringManager.getRandomString("countdownSuccess")
            font.pointSize: properties.fontSizes.large
            wrapMode: Text.Wrap
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * .50
            source: properties.paths.iconPath + stringManager.getRandomImage("successImage")
            fillMode: Image.PreserveAspectFit
        }
    }

    BaseButton {
        text: stringManager.getRandomString("countdownSuccessButton")
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom; bottomMargin: parent.height * .20
        }
        centerAlignText: true

        onActivated: {
            Qt.quit()
        }
    }

}
