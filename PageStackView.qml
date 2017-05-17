import QtQuick 2.0
import QtQuick.Controls 1.4

StackView {
    id: root

    property bool debug: false
    property string currentPage: currentItem ? currentItem.objectName : ""
    property url pathToPages: Qt.resolvedUrl(".")

    signal pageLoaded(string filename)

    onPageLoaded: {
        if (debug)
            console.log("Page loaded: " + filename + " | Depth: " + depth)
        if (currentItem != null) {
            currentItem.activated()
            currentItem.forceActiveFocus()
        }
    }

    function loadPageByFilename(filename, properties, replace) {
        if (debug)
            console.log("PageStackView - loadPageByFilename " + pathToPages +filename + ".qml")
        push({ item: pathToPages + filename + ".qml", properties: properties, replace: replace})
        root.pageLoaded(filename)
    }

    // Closes a page by name
    function closePage(page) {
        if (debug)
            console.log("PageStackView - closePage " + page)
        if (depth === 1) {
            clear()
        } else {
            var pageIndex = root.isPageLoaded(page)
            if (pageIndex != -1) {
                closePageIndex(pageIndex)
            } else {
                if (debug)
                    console.log("PageStackView - closePage :" + page + " not loaded")
            }
        }
    }

    // Closes a page by index. This should be used only inside this component.
    function closePageIndex(index) {
        if (debug)
            console.log("PageStackView - closePageindex " + index)
        if (depth === 1) {
            clear()
        } else {
            root.pop(getItem(index))
            if (debug)
                console.log("PageStackView - closePageindex " + index)

        }
    }

    // load page.
    function goToPage(page, properties, replace) {
        var prop = properties
        prop.objectName = page
        if (debug)
            console.log("PageStackView - goToPage :" + page + "::replace=" + replace +" :: Properties=" + JSON.stringify(prop))
        var pageIndex = root.isPageLoaded(page)
        if (pageIndex != -1) {
            if (debug)
                console.log("PageStackView - Closing Page for reload:" + page + ", " + pageIndex)
            root.pop(getItem(pageIndex))
            loadPageByFilename(page, prop, replace)
        } else {
            loadPageByFilename(page, prop, replace)
        }
    }

    //Get page item by index. This should be used only inside this component.
    function getItem(index) {
        return  pathToPages + get(index, true).objectName + ".qml"
    }

    // Clears the entire stack
    function emptyStack () {
        if (debug)
            console.log("PageStackView - emptyStack")
        clear()
    }

    // Goes to the previous Page
    function goBack() {
        if (debug)
            console.log("PageStackView:: goBack : " + get(depth-1).objectName)
        if (depth > 1) {
            pop()
            currentItem.activated()
            currentItem.focus = true
        } else {
            if (debug)
                console.log("PageStackView::Current depth is one. Can't go back.")
        }
    }

    // Checks if page is loaded. Returns index if found, if not returns -1
    function isPageLoaded(page) {
        if (debug)
            console.log("looking for page : " + page)
        for (var i=0; i<root.depth; i++) {
            console.log("Stack item " + i + " : " + root.get(i, true).objectName)
            if (root.get(i, true).objectName == page) {
                console.log("found page : " + page + " : " + i)
                return i
            }
        }
        if (debug)
            console.log("Not found page : " + page)
        return -1
    }

    Connections {
        target: currentItem
        onExit: {
            if (debug)
                console.log("PageStackView : exit() received")
            root.goBack()
        }
    }
}
