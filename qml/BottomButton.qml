// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: bottomBut
    property string buttonText
    property int yOy: mainwindow.height * 0.84166666666667

    width: mainwindow.width * 0.225; height: mainwindow.height * 0.03166666
    smooth: true

    // that doesn't work.. waiting for new QtQuick :(
   /* border {
        width: 1
       Gradient {
          GradientStop { position: 0.0; color: Qt.rgba(0/255.0, 0/255.0, 0/255.0, 70.0/255.0) }
          GradientStop { position: 1.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 255.0/255.0, 70.0/255.0) }
      }
    }*/

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

    Text {
        text: buttonText
        color: "white"
        font.family: "verdana"
        font.pixelSize: 11
        anchors.leftMargin: 16
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
    }

    MouseArea {
        id: mouse
        hoverEnabled: true
        anchors.fill: parent
        onPressed: bottomBut.gradient = pressedGrad
        onReleased: bottomBut.gradient = releasedGrad

        // this connected to menu when we press back it goes to previous level
        onClicked: {
            if (bottomBut.state == "quit")
                Qt.quit()
            else {
                bottomBut.state = "quit"

                var i = mainMenu2.menuType.length - 1
                while (i >= 0 && mainMenu2.menuType[i] !== '[')
                    --i
                mainMenu2.menuType = mainMenu2.menuType.substring(0, i)
                mainMenu1.menuType = mainMenu1.menuType.substring(0, i)
                if (mainMenu1.state == "hidden") {
                    mainMenu1.state = "shown"
                    mainMenu2.state = "hidden"
                }
                else {
                    mainMenu1.state = "hidden"
                    mainMenu2.state = "shown"
                }

                if (heading1.state == "shown") {
                    heading1.state = "hidden"
                    heading2.state = "shown"
                }
                else {
                    heading1.state = "shown"
                    heading2.state = "hidden"
                }

                if (mainText1.state == "shown") {
                    mainText1.state = "hidden"
                    mainText2.state = "shown"
                }
                else {
                    mainText1.state = "shown"
                    mainText2.state = "hidden"
                }
                if (tasksForChoose.state == "shown") {
                    tasksForChoose.state = "hidden"
                    typesForChoose.state = "hidden"
                }
                if (tasks.state == "shown")
                    tasks.state = "hidden"
                if (addtaskfield.state == "shown")
                    addtaskfield.state = "hidden"

                // NEEDS CHANGES!!!
                heading1.heading = "Заголовок: да, так он выглядит"
                heading2.heading = "Заголовок: да, так он выглядит"

                mainText1.maintext = "Ну, вот и текст появляется..:)<br>А так-то здесь должно быть вступительное слово"
                mainText2.maintext = "Ну, вот и текст появляется..:)<br>А так-то здесь должно быть вступительное слово"
                // DO NOT FORGET
            }
        }
    }

    states: [
        State {
            name: "quit"
            PropertyChanges {
                target: bottomBut
                x: 10
                y: yOy
                buttonText: "Выход"
            }
        },
        State {
            name: "back"
            PropertyChanges {
                target: bottomBut
                x: 10
                y: yOy
                buttonText: "Назад"
            }
        }
    ]
    transitions: [
        Transition {
            from: "quit"
            to: "back"
            SequentialAnimation {
                PropertyAnimation { properties: "x"; from: 10; to: -200; duration: 500 }
                PropertyAnimation { properties: "y"; from: yOy; to: yOy - 10; duration: 200 }
                PropertyAnimation { properties: "buttonText"; duration: 10 }
                PropertyAnimation { properties: "x"; from: -200; to: 10; duration: 500 }
                PropertyAnimation { properties: "y"; from: yOy - 10; to: yOy; duration: 700 }
            }
        },
        Transition {
            from: "back"
            to: "quit"
            SequentialAnimation {
                PropertyAnimation { properties: "x"; from: 10; to: -200; duration: 500 }
                PropertyAnimation { properties: "y"; from: yOy; to: yOy - 10; duration: 200 }
                PropertyAnimation { properties: "buttonText"; duration: 10 }
                PropertyAnimation { properties: "x"; from: -200; to: 10; duration: 500 }
                PropertyAnimation { properties: "y"; from: yOy - 10; to: yOy; duration: 700 }
            }
        }
    ]
}

