import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property string currentPage
    property var pageIconTable: {
        "Home" : {
            "left" : [Properties.buttonModels.back],
            "right" : []
        }
    }

    signal iconClicked(string id)

    onCurrentPageChanged: {
        refreshModels(currentPage)
    }

    onIconClicked: {
        console.log(":: HeaderBar :: Icon clicked: " + id)
        switch (id) {
        case "back":
            // todo
            break
        default:
            console.log(":: HeaderBar :: Unknown icon clicked: " + id)
        }
    }

    function refreshModels(page) {
        console.log(":: HeaderBar :: Refreshing list models")

        var tableObj = pageIconTable[page]
        if (tableObj == null) {
            console.log(":: HeaderBar :: Page not found in pageIconTable: " + page)
            return
        }

        listModelLeft.clear()
        listModelRight.clear()

        for (var i = 0; i < tableObj.left.length; i++) {
            listModelLeft.append(tableObj.left[i])
        }
        for (var k = 0; k < tableObj.right.length; k++) {
            listModelRight.append(tableObj.right[k])
        }
    }

    // Background
    Rectangle {
        id: background
        anchors.fill: parent
        color: Theme.colors.primary
    }

    // Left side
    ListModel {
        id: listModelLeft
    }

    ListView {
        id: listViewLeft

        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        orientation: ListView.Horizontal
        model: listModelLeft
        delegate: IconButton {
            width: height
            height: root.height * .60
            anchors.verticalCenter: parent.verticalCenter
            iconSource: model.iconSource
            pressedSource: model.pressedSource

            onActivated: {
                root.iconClicked(model.id)
            }
        }
    }

    // Right side
    ListModel {
        id: listModelRight
    }

    ListView {
        id: listViewRight

        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft
        model: listModelRight
        delegate: IconButton {
            width: height
            height: root.height * .80
            anchors.verticalCenter: parent.verticalCenter
            iconSource: model.iconSource
            pressedSource: model.pressedSource

            onActivated: {
                root.iconClicked(model.id)
            }
        }
    }
}
