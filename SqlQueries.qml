pragma Singleton
import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property alias tables: _tables

    property int user_id: Properties.settings.user_id

    QtObject {
        id: _tables

        property string init: "Init"
        property string settings: "Settings"
    }

    function getAll(table) {
        return "SELECT * FROM " + table
    }

    function getValue(table, column) {
        return "SELECT " + column + " FROM " + table + " WHERE user_id = " + user_id
    }

    function setValue(table, column, value) {
        return "UPDATE " + table + " SET " + column + " = '" + value + "' WHERE user_id = " + user_id
    }

}
