import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property string currentPage
    property var pageIconTable: {
        "Setup" : {
            "left" : pageStack.depth > 1 ? [buttonModels.back] : [],
            "right" : []
        },
        "Home" : {
            "left" : [],
            "right" : [buttonModels.report, buttonModels.settings]
        },
        "Confirm" : {
            "left" : [],
            "right" : []
        },
        "Analysis" : {
            "left" : pageStack.depth > 1 ? [buttonModels.back] : [],
            "right" : [buttonModels.settings]
        }
    }
    property var buttonModels: {
        "back" : { "id" : "back", "iconSource" : properties.paths.iconPath + "back.png", "pressedSource" : properties.paths.iconPath + "back-pressed.png" },
        "settings" : { "id" : "settings", "iconSource" : properties.paths.iconPath + "settings.png", "pressedSource" : properties.paths.iconPath + "settings-pressed.png" },
        "report" : { "id" : "report", "iconSource" : properties.paths.iconPath + "report.png", "pressedSource" : properties.paths.iconPath + "report-pressed.png" }
    }

    signal iconClicked(string id)

    onCurrentPageChanged: {
        refreshModels(currentPage)
    }

    onIconClicked: {
        console.log(":: HeaderBar :: Icon clicked: " + id)
        switch (id) {
        case "back":
            pageStack.goBack()
            break
        case "settings":
            pageStack.goToPage("Setup", {}, false)
            break
        case "report":
            pageStack.goToPage("Analysis", {}, false)
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
        color: Theme.colors.dark
    }

    AppLabel {
        id: labelTitle

        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left; leftMargin: root.height * .80 + 20
        }
        font.pointSize: properties.fontSizes.regular
        color: Theme.colors.background
        text: appTitle
    }

    // Left side
    ListModel {
        id: listModelLeft
    }

    // Right side
    ListModel {
        id: listModelRight
    }

    ListView {
        id: listViewLeft

        width: childrenRect.width
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
        boundsBehavior: Flickable.StopAtBounds
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

    ListView {
        id: listViewRight

        width: childrenRect.width
        anchors {
            right: parent.right; rightMargin: 20
            top: parent.top
            bottom: parent.bottom
        }
        boundsBehavior: Flickable.StopAtBounds
        orientation: ListView.Horizontal
        layoutDirection: Qt.RightToLeft
        spacing: 20
        model: listModelRight
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

//    state: currentPage == "Setup" ? "title" : "buttons"
//    states: [
//        State {
//            name: "buttons"
//            PropertyChanges {
//                target: listViewLeft
//                visible: true
//            }
//            PropertyChanges {
//                target: listViewRight
//                visible: true
//            }
//            PropertyChanges {
//                target: labelTitle
//                visible: false
//            }
//        },
//        State {
//            name: "title"
//            PropertyChanges {
//                target: listViewLeft
//                visible: false
//            }
//            PropertyChanges {
//                target: listViewRight
//                visible: false
//            }
//            PropertyChanges {
//                target: labelTitle
//                visible: true
//            }
//        }
//    ]
}
