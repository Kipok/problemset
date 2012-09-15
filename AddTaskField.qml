// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtDesktop 0.1

Item {
    id: addField
    property int xOx: 0.28125 * mainwindow.width
    width: 0.70625 * mainwindow.width
    height: 0.75 * mainwindow.height
    y: 25

    // it will be shown in tasks area for choosing tasks topics
    CheckTree {
        id: tasksForChoose
        qPath: "/menu/item[@name='Выбрать задачи']/content/checkgroup"
        state: "shown"
        xNormal: 0
    }

    // it will be shown in tasks area for choosing tasks types
    CheckBoxes {
        id: typesForChoose
        checkPath: "/menu/item[@name='Выбрать задачи']/content/checkbox"
        xNormal: 0.45 * mainwindow.width
        state: "shown"
    }

    Text {
        id: answer
        x: 0; y: 0
        height: mainwindow.height * 0.03166666
        text: "Ответ на задачу: "
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
    }

    TextField {
        id: spinAns
        x: description.x; y: 0
        height: answer.height; width: answer.width - 30
    }

    Text {
        id: desc
        x: 0; y: answer.y + 30
        height: mainwindow.height * 0.03166666
        text: "Описание задачи: "
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
    }

    TextField {
        id: description
        x: desc.width + 10; y: desc.y - 1
        width: parent.width - desc.width - 10; height: mainwindow.height * 0.03166666
        font.pixelSize: 12
        font.family: "verdana"
    }

    MyButton {
        id: sce
        x: 0; y: description.y + 30
        height: mainwindow.height * 0.03166666; width: desc.width - 10
        buttonText: "Найти задачу"
        gradient: Gradient {
            id: relGrad
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: mse.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        }

        Gradient {
                id: pressGrad
                GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
                GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
            }

        MouseArea {
            id: mse
            anchors.fill: parent
            hoverEnabled: true
            onPressed: button.gradient = pressGrad
            onReleased: button.gradient = relGrad
            onClicked: {
                source.text = getTask.findSource()
            }
        }
    }

    TextField {
        id: source
        x: description.x; y: sce.y
        width: description.width; height: mainwindow.height * 0.03166666
        text: ""
        font.pixelSize: 12
        font.family: "verdana"
    }

    MyButton {
        id: button
        x: parent.width - width
        y: parent.height - height
        buttonText: "Добавить!"
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
            onPressed: button.gradient = pressedGrad
            onReleased: button.gradient = releasedGrad
            onClicked: {
                // it's necessary, because the difficulty of the task recieves the statechanged signal
                typesForChoose.state = "hidden"
                typesForChoose.state = "shown"
                getTask.addTask(typesForChoose.diff, description.text, spinAns.text, source.text)
            }
        }
    }

    states: [
        State {
            name: "shown"
            PropertyChanges { target: addField; x: xOx; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: addField; x: mainwindow.width + 300; opacity: 0 }
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
