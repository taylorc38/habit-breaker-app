import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    // todo Refactor getters/setters into a generic function by iterating through properties.settings QtObject properties

    property var database

    function setUsername(username) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "name", username))) {
            properties.settings.username = username
        }
    }

    function setSkin(skin) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "skin", skin))) {
            Theme.activeSkin = skin
        }
    }

    function getCountdown() {
        var value
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "countdown"), function(data) {
            value = data[0].countdown
        })
        return value
    }

    function setCountdown(seconds) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "countdown", seconds))) {
            properties.settings.countdown = seconds
            getCountdown()
        }
    }

    function getEod() {
        var value
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "eod"), function(data) {
            value = data[0].eod
        })
        return value
    }

    // Where hour is an int 0 - 23
    function setEod(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "eod", hour))) {
            properties.settings.eod = hour
        }
    }

    function getDndFrom() {
        var value
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "dndFrom"), function(data) {
            value = data[0].dndFrom
        })
        return value
    }

    function setDndFrom(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "dndFrom", hour))) {
            properties.settings.dndFrom = hour
        }
    }

    function getDndTo() {
        var value
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "dndTo"), function(data) {
            value = data[0].dndTo
        })
        return value
    }

    function setDndTo(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "dndTo", hour))) {
            properties.settings.dndTo = hour
        }
    }
}
