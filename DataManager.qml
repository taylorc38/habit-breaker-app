import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property var database
    property var columns: ["numTimes", "date", "time"]


    function appendRecord(numTimes) {
        var date = new Date()
        var dateStr = "'" + date.toLocaleDateString() + "'"
        var timeStr = "'" + date.toLocaleTimeString(Qt.locale(), "h:m ap") + "'"
        var valuesArr = [numTimes, dateStr, timeStr]
        database.execute(SqlQueries.appendRecord(SqlQueries.tables.habit_data, columns.join(","), valuesArr.join(",")), function(data) {

        })
    }

    function getAllRecords(callback) {
        database.execute(SqlQueries.getAll(SqlQueries.tables.habit_data), function(data) {
            if (callback != null) {
                callback(data)
            }
        })
    }

    function getRecordsForDate(date, callback) {
        database.execute(SqlQueries.getRecordsFromDate(SqlQueries.tables.habit_data), function(data) {
            if (callback != null) {
                callback(data)
            }
        })
    }
}
