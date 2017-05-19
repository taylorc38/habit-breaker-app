import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Home"

    property int numTimes: 0

    signal countdownFinished

    state: "prompt"
    states: [
        State {
            name: "prompt"
            PropertyChanges {
                target: columnPrompt
                visible: true
            }
            PropertyChanges {
                target: columnCountdown
                visible: false
            }
        },
        State {
            name: "countdown"
            PropertyChanges {
                target: columnPrompt
                visible: false
            }
            PropertyChanges {
                target: columnCountdown
                visible: true
            }
        }
    ]

    onStateChanged: {
        if (state == "countdown") {
            timerCountdown.restart()
        }
    }

    onCountdownFinished: {
        if (root.numTimes > 0) {
            // bad!
            // todo save data for bad job
            pageStack.goToPage("Failure", { "numTimes" : root.numTimes }, true)
        } else {
            // good!
            // todo save data for good job
            pageStack.goToPage("Reward", {}, true)
        }
    }

    Item {
        id: columnPrompt

        width: parent.width
        height: parent.height

        AppLabel {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top; topMargin: parent.height * .20
            }
            text: "Got the urge?\nIt's okay."
            font.pointSize: properties.fontSizes.large
        }

        BaseButton {
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom; bottomMargin: parent.height * .20
            }
            text: "Start the countdown"

            onActivated: {
               root. state = "countdown"
            }
        }
    }

    Timer {
        id: timerCountdown

        property int counter: properties.settings.countdown

        interval: 1000

        onTriggered: {
            if (counter > 0) {
                counter--
                restart()
            } else {
                countdownFinished()
            }
        }
    }

    Column {
        id: columnCountdown

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top; topMargin: parent.height * .10
        }
        width: parent.width * .90
        spacing: parent.height * .05

        AppLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Relax for..."
            font.pointSize: properties.fontSizes.regular
        }

        Item {
            width: parent.width
            height: labelCountdown.paintedHeight + labelSec.paintedHeight
            anchors.horizontalCenter: parent.horizontalCenter
            AppLabel {
                id: labelCountdown
                anchors.horizontalCenter: parent.horizontalCenter
                text: timerCountdown.counter
                font.family: properties.appFontBig.name
                font.pointSize: 128
            }
            AppLabel {
                id: labelSec
                anchors {
                    left: labelCountdown.right; leftMargin: 5
                    bottom: labelCountdown.bottom; bottomMargin: 35
                }
                text: "sec."
                font.pointSize: properties.fontSizes.regular
            }
        }

        BaseButton {
            anchors.horizontalCenter: parent.horizontalCenter
            width: properties.dimens.buttonWidth
            height: properties.dimens.buttonHeight
            text: "Oops! I did the thing..."
            colorDefault: Theme.colors.error
            colorPressed: Theme.colors.errorLight

            onActivated: {
                root.numTimes++
            }
        }

        Row {
            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            spacing: 10

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
                font.pointSize: properties.fontSizes.regular
                text: root.numTimes == 1 ? "time" : "times"
                color: Theme.colors.dark
            }
        }
    }
}
