import QtQuick 2.0
import "qrc:/global"

BaseButton {
    id: root

    property bool debugPanelOpen:  pageStack.currentPage == "DebugPanel"

    colorDefault: Theme.colors.error
    colorPressed: Theme.colors.errorLight
    width: 100
    height: 50
    text: debugPanelOpen ? "Close" : "Debug"

    onActivated: {
        if (debugPanelOpen)
            pageStack.closePage("DebugPanel")
        else
            pageStack.goToPage("DebugPanel", {}, false)
    }
}
