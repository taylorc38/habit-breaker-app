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
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "countdown"), function(data) {
            properties.settings.countdown = data[0].countdown
        })
    }

    function setCountdown(seconds) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "countdown", seconds))) {
            properties.settings.countdown = seconds
        }
    }

    function getEod() {
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "eod"), function(data) {
            properties.settings.eod = data[0].eod
        })
    }

    // Where hour is an int 0 - 23
    function setEod(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "eod", hour))) {
            properties.settings.eod = hour
        }
    }

    function getDndFrom() {
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "dndFrom"), function(data) {
            properties.settings.dndFrom = data[0].dndFrom
        })
    }

    function setDndFrom(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "dndTo"))) {
            properties.settings.dndFrom = hour
        }
    }

    function getDndTo() {
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "dndTo"), function(data) {
            properties.settings.dndTo = data[0].dndTo
        })
    }

    function setDndTo(hour) {
        if (database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "dndTo"))) {
            properties.settings.dndTo = hour
        }
    }
}
