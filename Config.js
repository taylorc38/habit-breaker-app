

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
        { "attr" : "user_id", "_type" : "integer" },
        { "attr" : "name", "_type" : "TEXT" },
        { "attr" : "skin", "_type" : "TEXT" } // etc
    ],
    "defaults" : {
        "user_id" : 1337,
        "name" : "Taylor",
        "skin" : "default"
    }
}

var tables = [init, settings]
