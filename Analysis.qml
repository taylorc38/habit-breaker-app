import QtQuick 2.0
import "qrc:/global"
import "qrc:/components"

Page {
    id: root
    objectName: "Analysis"

    onActivated: {
        dataManager.getAllRecords(function(data) {
            for (var i = 0; i < data.length; i++) {
                modelHabitData.append(data[i])
            }
        })
    }

    ListModel {
        id: modelHabitData
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
            text: "May 29, 2017"
        }
    }

    ListView {
        id: listViewHabitData

        Rectangle {
            anchors.fill: parent
            color: "blue"
            opacity: 0.2
        }

        width: parent.width * .80
        anchors {
            top: itemDate.bottom; topMargin: 20
            bottom: itemBest.top; bottomMargin: 20
            horizontalCenter: parent.horizontalCenter
        }
        model: modelHabitData
        delegate: Item {
            width: listViewHabitData.width
            height: 100
            AppLabel {
                anchors.centerIn: parent
                font.pointSize: properties.fontSizes.regular
                color: "#000"
                text: model.date + " | " + model.time + " | " + model.numTimes + " times"
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

        Row {
            id: rowBest

            anchors.horizontalCenter: parent.horizontalCenter
            height: Math.max(imgCrown.height, labelBest.height)
            spacing: 20

            Image {
                id: imgCrown

                source: properties.paths.iconPath + "settings.png"
                anchors.verticalCenter: parent.verticalCenter
            }

            AppLabel {
                id: labelBest

                width: itemBest.width - imgCrown.width
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: properties.fontSizes.regular
                color: "#000"
                text: "Your personal best is 3 times a day!"
                wrapMode: Text.Wrap
            }
        }


    }
}
