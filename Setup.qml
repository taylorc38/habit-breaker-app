import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.0
import "qrc:/global"
import "qrc:/pages"
import "qrc:/components"

Page {
    id: root
    objectName: "Setup"

    property int promptSpacerHeight: height * .03
    property int blockSpacerHeight: height * .07
    property int comboWidth: width * .40
    property int comboHeight: 50

    property var modelInterval: ["30 minutes", "Hour", "3 hours", "6 hours"]
    property var intervalValues: [1800, 3600, 10800, 126000] // in seconds // todo these will be used to schedule notifications

    property var modelHoursInDay: getDayModel()
    property var hoursInDayValues: getDayValues()

    onActivated: {

    }

    // Creates an array with each hour of the day
    function getDayModel() {
        var arr = []
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
        var arr = []
        for (var i = 0; i < 24; i++) {
            arr.push(i)
        }
        return arr
    }

    Column {
        width: parent.width * .90
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }

        Item {
            width: parent.width
            height: blockSpacerHeight
        }

        // Interval

        AppLabel {
            id: labelInterval

            anchors.left: parent.left
            text: "Ask me every..."
            font.pointSize: properties.fontSizes.regular
        }

        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        ComboBox {
            id: comboInterval
            anchors.left: rowDnd.left
            width: comboWidth
            height: comboHeight
            model: modelInterval
            style: ComboBoxStyleA {}
        }

        Item {
            width: parent.width
            height: blockSpacerHeight
        }

        // End of day

        AppLabel {
            id: labelEndOfDay

            width: comboEndOfDay.width * 1.5
            anchors.left: parent.left
            text: "I would like my end-of-day report at..."
            wrapMode: Text.Wrap
            font.pointSize: properties.fontSizes.regular
        }

        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        ComboBox {
            id: comboEndOfDay
            anchors.left: rowDnd.left
            width: comboWidth
            height: comboHeight
            model: modelHoursInDay
            style: ComboBoxStyleA {}
        }

        Item {
            width: parent.width
            height: blockSpacerHeight
        }

        // Do not disturb

        AppLabel {
            id: labelDnd

            width: comboEndOfDay.width * 1.5
            anchors.left: parent.left
            text: "Do not disturb hours:"
            wrapMode: Text.Wrap
            font.pointSize: properties.fontSizes.regular
        }

        Item {
            width: parent.width
            height: promptSpacerHeight
        }

        Row {
            id: rowDnd
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            ComboBox {
                id: comboDndFrom
                width: comboWidth
                height: comboHeight
                model: modelHoursInDay
                style: ComboBoxStyleA {}
            }

            AppLabel {
                id: labelDndTo

                anchors.verticalCenter: parent.verticalCenter
                text: "to"
                font.pointSize: properties.fontSizes.medium
            }

            ComboBox {
                id: comboDndTo
                width: comboWidth
                height: comboHeight
                model: modelHoursInDay
                style: ComboBoxStyleA {}
            }
        }
    }

}
