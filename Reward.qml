import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Reward"

    property var successObj: stringManager.getSuccessObject()

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top; topMargin: root.height * .10
        }
        width: root.width
        spacing: 40

        AppLabel {
            id: labelSuccess
            width: parent.width * .80
            x: parent.width / 2 - paintedWidth / 2
//            anchors.horizontalCenter: parent.horizontalCenter
            text: "" + root.successObj.message
            font.pointSize: properties.fontSizes.large
            wrapMode: Text.Wrap
        }

        Image {
            id: imageSuccess
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * .50
            source: properties.paths.imagePath + root.successObj.img
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
