import QtQuick 2.0

// Wrapper for SQLModel to build a ListModel for UI use

Item {
    id: root

    property variant dataObject
    // Look in SqlQueryObject to see how these two properties are used
    // They aren't really necessary, I just got carried away
    property variant fields: []
    property variant qualifiers: []

    property alias query: sqlModel.query
    property alias dbPath: sqlModel.dbPath
    property alias debug: sqlModel.debug
    property alias listModel: listModel

    signal ready(variant data) // variant
    signal error(string message)

    onReady: {
        if (root.debug) {
            console.log(root + " data: " + JSON.stringify(data))
        }

        listModel.clear()
        for (var i = 0; i < data.length; i++) {
            console.log("data["+i+"] = " + JSON.stringify(data[i]))
            listModel.append(data[i])
        }

        root.dataObject = data
    }

    onError: {
        console.warn(message)
    }

    function refresh() {
        sqlModel.refresh()
    }

    function get(i) {
        return listModel.get(i)
    }

    SqlModel {
        id: sqlModel

        onReady: root.ready(data)
        onError: root.error(message)
    }

    ListModel {
        id: listModel
    }
}
