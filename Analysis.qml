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

    ListView {
        id: listViewHabitData

        width: parent.width * .90
        height: parent.height * .90
        anchors.centerIn: parent
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
}
