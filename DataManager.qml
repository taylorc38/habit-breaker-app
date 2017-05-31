import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property var database
    property var columns: ["numTimes", "date", "time", "dateSec"]

    function getRandomInt(min, max) {
      min = Math.ceil(min);
      max = Math.floor(max);
      return Math.floor(Math.random() * (max - min)) + min;
    }

    function populateTestData() {
        for (var i = 0; i < 20; i++) {
            var futureDate = new Date(new Date().getFullYear(), 6, getRandomInt(1, 5));
            appendRecord(getRandomInt(1, 10), futureDate)
        }
    }

    // customDate is used only for faking data
    function appendRecord(numTimes, customDate) {
        var dateStr
        var timeStr
        var dateSec

        if (customDate == null) {
            var date = new Date()
            dateStr = "'" + date.toLocaleDateString() + "'"
            timeStr = "'" + date.toLocaleTimeString(Qt.locale(), "h:mm ap") + "'"
            dateSec = date.getTime()
        } else {
            dateStr = "'" + customDate.toLocaleDateString() + "'"
            timeStr = "'" + customDate.toLocaleTimeString(Qt.locale(), "h:mm ap") + "'"
            dateSec = customDate.getTime()
        }

        var valuesArr = [numTimes, dateStr, timeStr, dateSec]
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
        database.execute(SqlQueries.getRecordsFromDate(SqlQueries.tables.habit_data, date), function(data) {
            if (callback != null) {
                callback(data)
            }
        })
    }

    // Sorted
    function getDistinctDates(callback) {
        database.execute(SqlQueries.getColumnDistinctSorted(SqlQueries.tables.habit_data, "date", "dateSec", "ASC"), function(data) {
            if (callback != null) {
                callback(data)
            }
        })
    }

    function getDataFromDate(date, callback) {
        database.execute(SqlQueries.getRecordsFromDate(SqlQueries.tables.habit_data, date), function(data) {
            if (callback != null) {
                callback(data)
            }
        })
    }
}
