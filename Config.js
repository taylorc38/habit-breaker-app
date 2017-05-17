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
        { "attr" : "skin", "_type" : "TEXT" },
        { "attr" : "countdown", "_type" : "integer" },
        { "attr" : "eod", "_type" : "integer" },
        { "attr" : "dndFrom", "_type" : "integer" },
        { "attr" : "dndTo", "_type" : "integer" }
    ],
    "defaults" : {
        "user_id" : 1337,
        "name" : "Taylor",
        "skin" : "default",
        "countdown" : 10, // 10 seconds
        "eod" : 20, // 8:00 pm
        "dndFrom" : 21, // 9:00 pm
        "dndTo" : 7 // 8:00 am
    }
}

var tables = [init, settings]
