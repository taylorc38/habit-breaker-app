import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Failure"

    property int numTimes: 5

    Column {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top; topMargin: root.height * .10
        }
        width: root.width
        spacing: 10

        AppLabel {
            id: labelTitle

            anchors.horizontalCenter: parent.horizontalCenter
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: properties.fontSizes.huge
            text: stringManager.getRandomString("countdownFailure")
        }

        Row {
            id: row

            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 30
            Rectangle {
                anchors.verticalCenter: parent.verticalCenter
                width: 50
                height: 50
                border {
                    color: Theme.colors.dark
                    width: 2
                }

                AppLabel {
                    anchors.centerIn: parent
                    font.pointSize: properties.fontSizes.regular
                    color: Theme.colors.dark
                    text: root.numTimes
                }
            }

            AppLabel {
                anchors.verticalCenter: parent.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.pointSize: properties.fontSizes.huge
                text: root.numTimes == 1 ? "time" : "times" + "."
            }
        }
    }

    BaseButton {
        text: stringManager.getRandomString("countdownFailureButton")
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom; bottomMargin: parent.height * .20
        }
        centerAlignText: true
        colorDefault: Theme.colors.error
        colorPressed: Theme.colors.errorLight

        onActivated: {
            Qt.quit()
        }
    }
}
