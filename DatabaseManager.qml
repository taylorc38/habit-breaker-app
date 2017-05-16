import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import "qrc:/global"
import "qrc:/config/Config.js" as Config

Item {
    id: root
    objectName: "DatabaseManager"

    // To make things easy, every type is TEXT

    // 0 = unknown
    // 1 = initialized
    // 2 = not initialized
    property var initStates: ({
        "Unknown" : 0,
        "Initialized" : 1,
        "Uninitialized" : 2
    })
    property int initState: initStates.Unknown
    property bool reinitialize: true // Should ALWAYS be false in production

    signal ready

    onReady: {
        console.log(objectName, ":: Ready")

        // test
        var query = "SELECT * FROM Settings";
        execute(query, function(data) {
            for (var i = 0; i < data.length; i++) {
                console.log(JSON.stringify(data[i]))
            }
        })
    }

    onInitStateChanged: {
        switch (initState) {
        case initStates.Unknown:
            console.log(objectName, ":: Init state: UNKNOWN")
            break
        case initStates.Initialized:
            console.log(objectName, ":: Init state: Initialized")
            ready()
            break
        case initStates.Uninitialized:
            console.log(objectName, ":: Init state: Uninitialized")
            initializeDb()
            break
        default:
            console.log(objectName, ":: Init state: There's a problem...")
        }
    }

    Component.onCompleted: {
        isInitialized()
    }

    // Passes a data array to callback, returns true if successful false if not
    function execute(query, callback) {
        var db = LocalStorage.openDatabaseSync(Properties.paths.database, "1.0", "Config database for HabitBreaker", 100000000, "QSQLITE")
        var success = true
        db.transaction(function(tx) {
            try {
                var rs = tx.executeSql(query)
                var data = []
                for (var i = 0; i < rs.rows.length; i++) {
                    data.push(rs.rows.item(i))
                }
                if (callback) {
                    callback(data)
                }
            } catch (err) {
                success = false
            }
        })
        return success
    }

    function isInitialized() {
        if (root.reinitialize)
            dropAllTables()

        var init = "SELECT value FROM Init WHERE name='%s'".replace("%s", Config.init.defaults.name)
        var success = execute(init, function(data) {
            var val = parseInt(data[0].value, 10)
            root.initState = val > 0 ? initStates.Initialized : initStates.Uninitialized
        })
        if (!success) {
            root.initState = initStates.Uninitialized
        }
    }

    function initializeDb() {
        console.log(objectName, ":: Initializing db")
        for (var i in Config.tables) {
            addTable(Config.tables[i])
        }
        root.initState = initStates.Initialized
    }

    function addTable(tableObj) {
        var schema = ""
        var columns = ""
        var values = ""
        for (var i in tableObj.schema) {
            schema += tableObj.schema[i].attr + " " + tableObj.schema[i]._type + ", "
            if (tableObj.schema[i].attr != "id") {
                columns += tableObj.schema[i].attr + ", "
                values += "'" + tableObj.defaults[tableObj.schema[i].attr] + "'" + ", "
            }
        }
        schema = schema.slice(0, -2)
        columns = columns.slice(0, -2)
        values = values.slice(0, -2)

        var create = "CREATE TABLE IF NOT EXISTS " + tableObj.table_name + " (" + schema + ")"
        var insert = "INSERT INTO " + tableObj.table_name + "(" + columns + ") VALUES (" + values + ")"

        execute(create)
        execute(insert)
    }

    function dropTable(table_name) {
        console.log(objectName, ":: Dropping table: " + table_name)
        var drop = "DROP TABLE " + table_name
        execute(drop)
    }

    function dropAllTables() {
        for (var i in Config.tables) {
            dropTable(Config.tables[i].table_name)
        }
    }
}
