import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Analysis"

    property int currentNumTimes
    property int prevNumTimes
    property int comparisonNumTimes: currentNumTimes - prevNumTimes
    property string comparisonStr: comparisonNumTimes > 0 ? "more" : "less"
    property int bestNumTimes: 10000000

    signal datesReady
    signal habitDataReady
    signal prevDataReady

    onActivated: {
        populateDatesModel()
    }

    onDatesReady: {
        // Set the opening date to the most current, which is guarenteed to be the last entry because it's sorted
        listViewHabitData.currentIndex = modelDates.count - 1
        listViewHabitData.positionViewAtIndex(modelDates.count - 1, ListView.Beginning)
        updateBest()
    }

    onHabitDataReady: {
        root.currentNumTimes = getNumTimes(modelHabitData)
    }

    onPrevDataReady: {
        root.prevNumTimes = getNumTimes(modelPreviousDay)
    }

    function updateBest() {
        for (var i = 0; i < modelDates.count; i++) {
            dataManager.getRecordsForDate(modelDates.get(i).date, function(data) {
                var total = 0
                for (var k = 0; k < data.length; k++) {
                    total += data[k].numTimes
                }
                if (total < root.bestNumTimes) {
                    root.bestNumTimes = total
                }
            })
        }
    }

    function getNumTimes(listModel) {
        var ctr = 0
        for (var i = 0; i < listModel.count; i++) {
            ctr += listModel.get(i).numTimes
        }
        return ctr
    }

    // Assumes data is an array of objects
    function populateDatesModel() {
        modelDates.clear()
        dataManager.getDistinctDates(function(data) {
            for (var i = 0; i < data.length; i++) {
                modelDates.append(data[i])
            }
            root.datesReady()
        })
    }

    function populateHabitDataModel(date) {
        modelHabitData.clear()
        dataManager.getRecordsForDate(date, function(data) {
            for (var i = 0; i < data.length; i++) {
                modelHabitData.append(data[i])
            }
            root.habitDataReady()
        })
    }

    function populatePreviousDayModel(date) {
        modelPreviousDay.clear()
        dataManager.getRecordsForDate(date, function(data) {
            for (var i = 0; i < data.length; i++) {
                modelPreviousDay.append(data[i])
            }
            root.prevDataReady()
        })
    }

    ListModel {
        id: modelDates
    }

    ListModel {
        id: modelHabitData
    }

    ListModel {
        id: modelPreviousDay
    }

    Item {
        id: itemDate

        width: parent.width * .90
        height: labelDate.height
        anchors {
            top: parent.top; topMargin: 10
            horizontalCenter: parent.horizontalCenter
        }

        AppLabel {
            id: labelDate

            anchors.horizontalCenter: parent.horizontalCenter
            font.pointSize: properties.fontSizes.regular
            color: "#000"
            text: modelDates.get(listViewHabitData.currentIndex).date
        }
    }

    Image {
        id: arrowLeft

        anchors {
            right: listViewHabitData.left
            verticalCenter: listViewHabitData.verticalCenter
        }
        visible: listViewHabitData.currentIndex > 0
        source: properties.paths.iconPath + (mouseAreaLeft.pressed ? "arrow-left-pressed.png" : "arrow-left.png")

        MouseArea {
            id: mouseAreaLeft

            anchors.fill: parent
            onClicked: {
                listViewHabitData.decrementCurrentIndex()
            }
        }
    }

    ListView {
        id: listViewHabitData

        width: parent.width * .70
        anchors {
            top: itemDate.bottom; topMargin: 20
            bottom: itemBest.top; bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        clip: true
        snapMode: ListView.SnapToItem
        orientation: ListView.Horizontal
        highlightMoveDuration: 200
        interactive: false
        model: modelDates.count//modelHabitData
        delegate: Item {
            id: delegateRoot

            width: listViewHabitData.width
            height: listViewHabitData.height

            AppLabel {
                id: labelNumTimes

                anchors {
                    top: parent.top; topMargin: 10
                    horizontalCenter: parent.horizontalCenter
                }
                width: parent.width * .80
                wrapMode: Text.Wrap
                font.pointSize: properties.fontSizes.regular
                color: "#000"
                text: index > 0
                      ? "You did it " + root.currentNumTimes + " times, " + Math.abs(root.comparisonNumTimes) + " " + root.comparisonStr + " than the previous day."
                      : "You did it " + root.currentNumTimes + " times."
            }
        }

        onCurrentIndexChanged: {
            populateHabitDataModel(modelDates.get(currentIndex).date)
            if (currentIndex > 0) {
                populatePreviousDayModel(modelDates.get(currentIndex - 1).date)
            } else {
                root.prevNumTimes = 0
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "transparent"
            border {
                width: 2
                color: Theme.colors.primary
            }
        }
    }

    Image {
        id: arrowRight

        anchors {
            left: listViewHabitData.right
            verticalCenter: listViewHabitData.verticalCenter
        }
        visible: listViewHabitData.currentIndex < modelDates.count - 1
        source: properties.paths.iconPath + (mouseAreaRight.pressed ? "arrow-right-pressed.png" : "arrow-right.png")

        MouseArea {
            id: mouseAreaRight

            anchors.fill: parent
            onClicked: {
                listViewHabitData.incrementCurrentIndex()
            }
        }
    }

    Item {
        id: itemBest

        width: parent.width *.90
        height: rowBest.height
        anchors {
            bottom: parent.bottom; bottomMargin: 10
            horizontalCenter: parent.horizontalCenter
        }
        visible: root.bestNumTimes != 10000000

        Row {
            id: rowBest

            anchors.horizontalCenter: parent.horizontalCenter
            height: Math.max(imgCrown.height, labelBest.height)
            spacing: 20

            Image {
                id: imgCrown

                source: properties.paths.iconPath + "crown.png"
                anchors.verticalCenter: parent.verticalCenter
            }

            AppLabel {
                id: labelBest

                width: itemBest.width - imgCrown.width
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: properties.fontSizes.regular
                color: "#000"
                text: stringManager.getRandomString("reportBest") + root.bestNumTimes + " times a day!"
                wrapMode: Text.Wrap
            }
        }
    }
}
