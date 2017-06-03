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
        "countdownSuccess" : ["Great job! I got u bae."],
        "countdownSuccessButton" : ["Close"],
        "countdownFailure" : ["Did the thing"], // "x times will be appended
        "countdownFailureButton" : ["Okay"],
        "setupTitle" : ["Just a couple of questions..."],
        "setupButton" : ["I'm good!"],
        "setupConfirmTitle" : ["How does this look?"],
        "setupConfirmButtonOk" : ["Looks good!"],
        "setupConfirmButtonBack" : ["Actually..."],
        "reportBest" : ["Your personal best is "] // x times a day will be appended
    }
    property var imageTable: {
        "successImage" : ["ok-hand.png"]
    }

    function getRandomString(key) {
        return stringTable[key][Math.floor(Math.random()*stringTable[key].length)]
    }

    function getRandomImage(key) {
        return imageTable[key][Math.floor(Math.random()*imageTable[key].length)]
    }
}
