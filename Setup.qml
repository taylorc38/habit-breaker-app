import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.0
import "qrc:/global"
import "qrc:/pages"
import "qrc:/components"

Page {
    id: root
    objectName: "Setup"

    property bool firstTimeSettingUp: false

    property int promptSpacerHeight: height * .03
    property int blockSpacerHeight: height * .07
    property int comboWidth: width * .40
    property int comboHeight: 50

    property var modelCountdown
    property var modelHoursInDay
    property var hoursInDayValues

    property bool countdown: comboCountdown.currentIndex > 0
    property bool eod: comboEndOfDay.currentIndex > 0
//    property bool dndFrom: comboDndFrom.currentIndex > 0
//    property bool dndTo: comboDndTo.currentIndex > 0

    signal countdownChosen(int index)
    signal endOfDayChosen(int index)
//    signal dndToChosen(int index)
//    signal dndFromChosen(int index)
    signal setupCompleted
    signal setupConfirmed

    state: "setup"
    states: [
        State {
            name: "setup"
            PropertyChanges {
                target: columnSetup
                opacity: 1
            }
            PropertyChanges {
                target: columnConfirm
                opacity: 0
            }
        },
        State {
            name: "confirm"
            PropertyChanges {
                target: columnSetup
                opacity: 0
            }
            PropertyChanges {
                target: columnConfirm
                opacity: 1
            }
        }
    ]
    transitions: [
        Transition {
            from: "setup"; to: "confirm"
            SequentialAnimation {
                NumberAnimation {
                    target: columnSetup
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: { columnSetup.visible = false; columnConfirm.visible = true }
                }
            }
        },
        Transition {
            from: "confirm"; to: "setup"
            SequentialAnimation {
                NumberAnimation {
                    target: columnConfirm
                    property: "opacity"
                    duration: 500
                    easing.type: Easing.InOutQuad
                }
                ScriptAction {
                    script: { columnConfirm.visible = false; columnSetup.visible = true }
                }
            }
        }

    ]

    onSetupConfirmed: {
        DeviceInterface.scheduleDailyReminder(properties.appTitle, properties.appNotificationBody, properties.settings.eod)
        pageStack.goToPage("Home", {}, true)
    }

    onActivated: {
        // Assign once to avoid data binding affecting performance
        modelCountdown = getFiveSecondIntervals()
        modelHoursInDay = getDayModel()
        hoursInDayValues = getDayValues()

        if (!firstTimeSettingUp) {
            // Grab data from db to set as defaults
            var savedCountdown
            var savedEod
//            var savedDndFrom
//            var savedDndTo
            database.execute(SqlQueries.getAll("settings"), function(data) {
                savedCountdown = data[0].countdown
                savedEod = data[0].eod
//                savedDndFrom = data[0].dndFrom
//                savedDndTo = data[0].dndTo
            })
            comboCountdown.currentIndex = modelCountdown.indexOf(savedCountdown)
            comboEndOfDay.currentIndex = hoursInDayValues.indexOf(savedEod)
//            comboDndFrom.currentIndex = hoursInDayValues.indexOf(savedDndFrom)
//            comboDndTo.currentIndex = hoursInDayValues.indexOf(savedDndTo)
        }
    }

    onCountdownChosen: {
        if (index == 0) return
        var value = modelCountdown[index]
        settings.setCountdown(value)
    }

    onEndOfDayChosen: {
        if (index == 0) return
        var value = hoursInDayValues[index]
        settings.setEod(value)
    }

//    onDndToChosen: {
//        if (index == 0) return
//        console.log("dndto chosen index = " + index)
//        var value = hoursInDayValues[index]
//        settings.setDndTo(value)
//    }

//    onDndFromChosen: {
//        if (index == 0) return
//        var value = hoursInDayValues[index]
//        settings.setDndFrom(value)
//    }

    onSetupCompleted: {
        state = "confirm"
    }

    function reset() {
        comboCountdown.currentIndex = 0
        comboEndOfDay.currentIndex = 0
//        comboDndFrom.currentIndex = 0
//        comboDndTo.currentIndex = 0
        state = "setup"
    }

    function getFiveSecondIntervals() {
        var arr = [""]
        for (var i = 5; i <= 60; i+=5) {
            arr.push(i)
        }
        return arr
    }

    // Creates an array with each hour of the day
    function getDayModel() {
        var arr = [""]
        for (var i = 0; i < 24; i++) {
            var formattedTime
            var hour = i
            if (hour == 0) {
                arr.push("12:00am")
                continue
            }
            if (hour < 12) {
                formattedTime = hour.toString() + ":00am"
            } else if (hour == 12) {
                formattedTime = hour.toString() + ":00pm"
            } else {
                hour -= 12
                formattedTime = hour.toString() + ":00pm"
            }
            arr.push(formattedTime)
        }
        return arr
    }

    function getDayValues() {
        var arr = [""]
        for (var i = 0; i < 24; i++) {
            arr.push(i)
        }
        return arr
    }

    Column {
        id: columnConfirm

        width: parent.width * .90
        anchors.centerIn: parent
        spacing: 10
        opacity: 0
        visible: false

        AppLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: stringManager.getRandomString("setupConfirmTitle")
            font.pointSize: properties.fontSizes.regular
            font.bold: true
        }

        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        AppLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Countdown: " + modelCountdown[comboCountdown.currentIndex] + " seconds"
            font.pointSize: properties.fontSizes.regular
        }
        AppLabel {
            anchors.horizontalCenter: parent.horizontalCenter
            text: "End of day report: " + modelHoursInDay[comboEndOfDay.currentIndex]
            font.pointSize: properties.fontSizes.regular
        }
//        AppLabel {
//            anchors.horizontalCenter: parent.horizontalCenter
//            text: "D.N.D: " + modelHoursInDay[comboDndFrom.currentIndex] + " to " + modelHoursInDay[comboDndTo.currentIndex]
//            font.pointSize: properties.fontSizes.regular
//        }

        Item {
            width: parent.width
            height: blockSpacerHeight
        }

        BaseButton {
            id: btnConfirm

            anchors.horizontalCenter: parent.horizontalCenter
            text: stringManager.getRandomString("setupConfirmButtonOk")
            width: comboWidth
            height: comboHeight
            centerAlignText: true

            onActivated: {
                setupConfirmed()
            }
        }
        BaseButton {
            id: btnReset

            anchors.horizontalCenter: parent.horizontalCenter
            text: stringManager.getRandomString("setupConfirmButtonBack")
            colorDefault: Theme.colors.error
            colorPressed: Theme.colors.errorLight
            width: comboWidth
            height: comboHeight
            centerAlignText: true

            onActivated: {
                reset()
            }
        }
    }

    Column {
        id: columnSetup

        width: parent.width * .90
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        // Title
        AppLabel {
            id: labelTitle

            width: parent.width
            anchors.left: parent.left
            text: stringManager.getRandomString("setupTitle")
            font.pointSize: properties.fontSizes.regular
            font.bold: true
            wrapMode: Text.Wrap
        }
        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        // Interval
        AppLabel {
            id: labelCountdown

            width: parent.width
            anchors.left: parent.left
            text: "How many seconds should I count?"
            font.pointSize: properties.fontSizes.regular
            wrapMode: Text.Wrap
        }
        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        ComboBox {
            id: comboCountdown

            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: comboWidth
            height: comboHeight
            model: modelCountdown
            style: ComboBoxStyleA {}
            currentIndex: 0

            onCurrentIndexChanged: {
                countdownChosen(currentIndex)
            }
        }
        Item {
            width: parent.width
            height: blockSpacerHeight
        }

        // End of day
        AppLabel {
            id: labelEndOfDay

            width: parent.width
            anchors.left: parent.left
            text: "When would you like your end-of-day report?"
            wrapMode: Text.Wrap
            font.pointSize: properties.fontSizes.regular
        }
        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        ComboBox {
            id: comboEndOfDay

            anchors {
                horizontalCenter: parent.horizontalCenter
            }
            width: comboWidth
            height: comboHeight
            model: modelHoursInDay
            style: ComboBoxStyleA {}

            onCurrentIndexChanged: {
                endOfDayChosen(currentIndex)
            }
        }
        Item {
            width: parent.width
            height: blockSpacerHeight
        }

//        // Do not disturb
//        AppLabel {
//            id: labelDnd

//            width: parent.width
//            anchors.left: parent.left
//            text: "When shouldn't I disturb you?"
//            wrapMode: Text.Wrap
//            font.pointSize: properties.fontSizes.regular
//        }
//        Item {
//            width: parent.width
//            height: promptSpacerHeight
//        }

//        Row {
//            id: rowDnd
//            anchors.horizontalCenter: parent.horizontalCenter
//            spacing: 10
//            ComboBox {
//                id: comboDndFrom
//                width: comboWidth
//                height: comboHeight
//                model: modelHoursInDay
//                style: ComboBoxStyleA {}

//                onCurrentIndexChanged: {
//                    dndFromChosen(currentIndex)
//                }
//            }

//            AppLabel {
//                id: labelDndTo

//                anchors.verticalCenter: parent.verticalCenter
//                text: "to"
//                font.pointSize: properties.fontSizes.medium
//            }

//            ComboBox {
//                id: comboDndTo
//                width: comboWidth
//                height: comboHeight
//                model: modelHoursInDay
//                style: ComboBoxStyleA {}

//                onCurrentIndexChanged: {
//                    dndToChosen(currentIndex)
//                }
//            }
//        }

//        Item {
//            width: parent.width
//            height: promptSpacerHeight
//        }

        BaseButton {
            id: btnGoToConfirm

            property bool show: comboCountdown.currentIndex > 0
                                && comboEndOfDay.currentIndex > 0
//                                && comboDndFrom.currentIndex > 0
//                                && comboDndTo.currentIndex > 0

            Behavior on anchors.rightMargin {
                NumberAnimation {
                    duration: 300
                    easing.type: Easing.OutQuad
                }
            }
            anchors {
                right: parent.right; rightMargin: 10
            }
            height: comboHeight
            text: stringManager.getRandomString("setupButton")
            centerAlignText: true
            state: show ? "shown" : "hidden"
            states: [
                State {
                    name: "hidden"
                    PropertyChanges {
                        target: btnGoToConfirm
                        anchors.rightMargin: -1 * btnGoToConfirm.width - 50
                    }
                },
                State {
                    name: "shown"
                    PropertyChanges {
                        target: btnGoToConfirm
                        anchors.rightMargin: 20
                    }
                }
            ]

            onActivated: {
                root.setupCompleted()
            }
        }
    }
}
