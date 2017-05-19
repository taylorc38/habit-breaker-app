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
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Great job! I got u bae!"
            font.pointSize: properties.fontSizes.large
        }

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: root.width * .50
            source: properties.paths.iconPath + "ok-hand.png"
            fillMode: Image.PreserveAspectFit
        }
    }

    BaseButton {
        text: "CLOSE"
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
