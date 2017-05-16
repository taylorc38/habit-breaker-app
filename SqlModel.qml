import QtQuick 2.0
import SQLModel 1.0

SQLModel {
    id: root

    query: ""
    dbPath: databasePath // context property
    debug: false

    onInitialized: {
        console.log("dbPath: " + dbPath)
        if (query !== "") {
            refresh()
        }
    }

    Component.onCompleted: initialize()

    /*
    Properties:
        string query
        string dbPath
        bool debug - enable/disable console output

    Signals:
        onQueryChanged
        onPathChanged
        onReady(data)
        onError(message)


     Methods:
        refresh() - Query database with [query]
    */

}
