// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtDesktop 0.1

Item {
    id: taskItem
    property int xOx: 0.28125 * mainwindow.width
    property double answer: 0
    property string diff: "0"
    property int forTask: 0
    width: 0.70625 * mainwindow.width
    height: 0.75 * mainwindow.height
    y: 25

    function loadTask() {
        // here it is necessary to change id for image provider and for that I'm using property forTask
        getTask.setTask()
        task.source = "image://provider/task" + getTask.intToString(forTask)
        answer = getTask.stringToDouble(getTask.getAnswer())
        console.log(answer)
        diff = getTask.intToString(getTask.getDifficulty())
        console.log(diff)
        comment.text = getTask.getComment()
    }

    onStateChanged: {
        if (taskItem.state == "shown") {
            getTask.nextTask()
            loadTask()
        }
    }

    Image {
        id: task
        x: 0; y: 0
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        source: ""// "image://provider/task"
    }

    Text {
        id: comment
        height: checkAnswer.height
        x: 0; y: task.height + 20
        text: "Описание задачи:"
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
    }

    Text {
        id: difficulty
        height: checkAnswer.height
        x: 0; y: comment.y + 20
        text: "Сложность задачи: " + diff
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
    }

    MyButton {
        id: checkAnswer
        x: parent.width - width; y: parent.height - height
        buttonText: "Проверить ответ"
        gradient: Gradient {
            id: releasedGrad
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: mouse.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        }

        Gradient {
                id: pressedGrad
                GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
                GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
            }

        MouseArea {
            id: mouse
            anchors.fill: parent
            hoverEnabled: true
            onPressed: checkAnswer.gradient = pressedGrad
            onReleased: checkAnswer.gradient = releasedGrad
            onClicked: {
                if (getTask.stringToDouble(spinAns.text) === taskItem.answer) {
                    getTask.debug("Ну наконец-то! Теперь правильно :)")
                }
                else {
                    getTask.debug("Да что ж такое! Опять не верно..")
                }
            }
        }
    }
    MyButton {
        id: leave
        x: 0; y: parent.height - height
        buttonText: "Сдаюсь!"
        gradient: Gradient {
            id: releasedGradient
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: mouse2.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        }

        Gradient {
                id: pressedGradient
                GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
                GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
            }

        MouseArea {
            id: mouse2
            anchors.fill: parent
            hoverEnabled: true
            onPressed: leave.gradient = pressedGradient
            onReleased: leave.gradient = releasedGradient
            onClicked: {
                spinAns.text = getTask.doubleToString(taskItem.answer)
            }
        }
    }

    MyButton {
        id: nextTask
        x: parent.width - width; y: parent.height - 2 * height - 5
        buttonText: "Следующая задача"
        gradient: Gradient {
            id: relGrad
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: mouse3.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        }

        Gradient {
                id: pressGrad
                GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
                GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
            }

        MouseArea {
            id: mouse3
            anchors.fill: parent
            hoverEnabled: true
            onPressed: nextTask.gradient = pressGrad
            onReleased: nextTask.gradient = relGrad
            onClicked: {
                taskItem.forTask += 1
                if (getTask.nextTask())
                    nextTask.enabled = false
                previousTask.enabled = true
                loadTask()
            }
        }
    }
    MyButton {
        id: previousTask
        x: 0; y: parent.height - 2 * height - 5
        buttonText: "Предыдущая задача"
        enabled: false
        gradient: Gradient {
            id: rGrad
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: mouse4.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        }

        Gradient {
                id: pGrad
                GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
                GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
            }

        MouseArea {
            id: mouse4
            anchors.fill: parent
            hoverEnabled: true
            onPressed: previousTask.gradient = pGrad
            onReleased: previousTask.gradient = rGrad
            onClicked: {
                taskItem.forTask -= 1
                if (getTask.prevTask())
                    previousTask.enabled = false
                nextTask.enabled = true
                loadTask()
            }
        }
    }

    Text {
        id: answer
        x: checkAnswer.width + 50; y: parent.height - height - 10
        height: checkAnswer.height
        text: "Ответ: "
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
        horizontalAlignment: TextInput.AlignLeft
    }

    TextField {
        id: spinAns
        x: answer.x + answer.width + 10; y: answer.y - 2
        width: answer.width; height: answer.height
        focus: true
    }

    states: [
        State {
            name: "shown"
            PropertyChanges { target: taskItem; x: xOx; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: taskItem; x: mainwindow.width + 300; opacity: 0 }
        }
    ]
    transitions: [
        Transition {
            from: "shown"
            to: "hidden"
            SequentialAnimation {
                PropertyAnimation { properties: "x"; from: xOx; to: -300; duration: 300 }
                PropertyAnimation { properties: "opacity"; duration: 1 }
                PropertyAnimation { properties: "x"; from: -300; to: mainwindow.width + 300; duration: 1 }
            }
        },
        Transition {
            from: "hidden"
            to: "shown"
            SequentialAnimation {
                PropertyAnimation { properties: "opacity"; duration: 1 }
                PropertyAnimation { properties: "x"; duration: 1000; easing.type: "OutBack" }
            }
        }
    ]
}
