import QtQuick 2.0
import "qrc:/components"

Page {
    id: root
    objectName: "DebugPanel"

    property var modelObj: [
        { "name" : "countdown", "value" : properties.settings.countdown },
        { "name" : "eod", "value" : properties.settings.eod },
        { "name" : "dndTo", "value" : properties.settings.dndTo },
        { "name" : "dndFrom", "value" : properties.settings.dndFrom }
    ]

    onActivated: {
        listModel.clear()
        for (var i = 0; i < modelObj.length; i++) {
            listModel.append(modelObj[i])
        }
    }

    ListModel {
        id: listModel
    }

    ListView {
        id: listView

        height: parent.height * .80
        width: parent.width * .80
        anchors.centerIn: parent
        model: listModel
        delegate: AppLabel {
            font.pointSize: properties.fontSizes.regular
            text: name + ": " + value
        }
    }
}
