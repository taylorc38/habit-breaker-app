

var init = {
    "table_name" : "Init",
    "schema" : [
        { "attr" : "name", "_type" : "TEXT" },
        { "attr" : "value", "_type" : "TEXT" }
    ],
    "defaults" : {
        "name" : "init",
        "value" : "1"
    }
}

var settings = {
    "table_name" : "Settings",
    "schema" : [
        { "attr" : "id", "_type" : "integer primary key autoincrement" },
        { "attr" : "name", "_type" : "TEXT" },
        { "attr" : "skin", "_type" : "TEXT" } // etc
    ],
    "defaults" : {
        "name" : "Erica",
        "skin" : "default"
    }
}

var tables = [init, settings]
