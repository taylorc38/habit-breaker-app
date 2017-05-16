import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property var database

    function setUsername(username) {
        database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "name", username))
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "name"), function(data) {
            Properties.settings.username = data[0].name
        })
    }

    // doesnt work
    function setSkin(skin) {
        database.execute(SqlQueries.setValue(SqlQueries.tables.settings, "skin", skin))
        database.execute(SqlQueries.getValue(SqlQueries.tables.settings, "skin"), function(data) {
            Properties.settings.skin = data[0].skin
            Theme.activeSkin = data[0].skin
        })
    }
}
