import QtQuick 2.0
import "qrc:/global"

Item {
    id: root

    property var stringTable: {
        "appTitle" : ["HabitBreaker"],
        "countdownTitle" : ["Got the urge?\nIt's okay."],
        "countdownButton" : ["Start the countdown"],
        "countdownInProgress" : ["Hang tight!"],
        "countdownInProgressButton" : ["Oops, I did the thing..."],
        "countdownSuccess" : ["Ur doing great", "I got u bae", "Super chill",
                              "I got u fam", "Float on", "Cheers m8", "All good in the hood",
                              "Crushing it", "Ur a STAR", "Truly magical", "Snek so proud of u",
                              "Habit Kween", "Such a strong habit boi", "Here come dat boi"],
        "countdownSuccessButton" : ["Bai"],
        "countdownFailure" : ["Ya did the thing"], // "x times will be appended
        "countdownFailureButton" : ["Cya"],
        "setupTitle" : ["Just a couple of questions..."],
        "setupButton" : ["Noice"],
        "setupConfirmTitle" : ["How's this look?"],
        "setupConfirmButtonOk" : ["Roger that"],
        "setupConfirmButtonBack" : ["Actually..."],
        "reportBest" : ["Your personal best is "] // x times a day will be appended
    }
    property var imageTable: {
        "countdownSuccess" : ["ok-hand-sign.png", "heart.png", "snowflake.png",
                              "fam.png", "balloon.png", "beer-cheers.png", "turtle.png",
                              "100-emoji.png", "glowing-star.png", "unicorn-face.png", "snek.png",
                              "crown.png", "flexed-biceps.png", "frogboi.png"]
    }

    function getRandomString(key) {
        return stringTable[key][Math.floor(Math.random()*stringTable[key].length)]
    }

    function getRandomImage(key) {
        return imageTable[key][Math.floor(Math.random()*imageTable[key].length)]
    }

    function getSuccessObject() {
        var key = "countdownSuccess"
        var index = Math.floor(Math.random()*stringTable[key].length)
        var obj = {
            message: stringTable[key][index],
            img: imageTable[key][index]
        }
        return obj
    }
}
