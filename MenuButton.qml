// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property string buttonText
    property int nest
    property string type
    property string contentText: "Ошибка: невозможно прочитать файл с текстом :("

    id: button
    width: mainwindow.width * 0.22; height: mainwindow.height * 0.03166666
    smooth: true

    gradient: Gradient {
        id: releasedGrad
        GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
        GradientStop { position: 1.0; color: mouse.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
    }


    Gradient {
            id: normalGrad
            GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
            GradientStop { position: 1.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) }
        }

    Gradient {
            id: pressedGrad
            GradientStop { position: 0.0; color: Qt.rgba(200.0/255.0, 170.0/255.0, 160.0/255.0, 50.0/255.0) }
            GradientStop { position: 1.0; color: Qt.rgba(220.0/255.0, 220.0/255.0, 220.0/255.0, 30.0/255.0) }
        }

    radius: 10
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
        onPressed: button.gradient = pressedGrad
        onReleased: button.gradient = releasedGrad
        onClicked: {
            // changing menu if nest == 1 and changing the button style otherwise
            if (nest == 1) {
                if (mainMenu1.state == "hidden") {
                    mainMenu1.state = "shown"
                    mainMenu2.state = "hidden"
                }
                else {
                    mainMenu1.state = "hidden"
                    mainMenu2.state = "shown"
                }
                mainMenu1.menuType += "[@name='" + buttonText + "']/item"
                mainMenu2.menuType += "[@name='" + buttonText + "']/item"
                if (bottomButton.state == "quit")
                    bottomButton.state = "back"
            }
            else {
                //console.log(menu.count)
             //   for (var i = 0; i < menu.count; i++) {
              //      if (menu.contentItem.children[i].enabled === false) {
                        //menu.contentItem.children[i].enabled = true
                        // this works bad too.. Oh, Gods be good
             //           menu.contentItem.children[i].gradient = normalGrad
                       // menu.contentItem.children[i].hEn = true
                //    }
           //     }
            //    button.gradient = pressedGrad
            }

            // showing content
                //
            if (type != "task") {
                heading1.heading = buttonText
                heading2.heading = buttonText
                if (heading1.state == "shown") {
                    heading1.state = "hidden"
                    heading2.state = "shown"
                }
                else {
                    heading1.state = "shown"
                    heading2.state = "hidden"
                }
            }
            if (type == "text") {
                mainText1.maintext = contentText
                mainText2.maintext = contentText
                if (tasksForChoose.state == "shown") {
                    tasksForChoose.state = "hidden"
                    typesForChoose.state = "hidden"
                }
                if (mainText1.state == "shown") {
                    mainText1.state = "hidden"
                    mainText2.state = "shown"
                }
                else {
                    mainText1.state = "shown"
                    mainText2.state = "hidden"
                }
            }
            if (type == "checktree") {
                tasksForChoose.state = "shown"
                typesForChoose.state = "shown"
                // here it is possible to write some introducing text
                // But it seems quite plain to understand and there is no place left for the text besides
                mainText1.state = "hidden"
                mainText2.state = "hidden"
            }
            if (type == "task") {
                tasksForChoose.state = "hidden"
                typesForChoose.state = "hidden"
                getTask.toDatabase(typesForChoose.diff)
                tasks.state = "shown"
                heading1.state = "hidden"
                heading2.state = "hidden"
                mainText1.state = "hidden"
                mainText2.state = "hidden"
            }
            if (type == "addTasks") {
                addtaskfield.state = "shown"
                heading1.state = "hidden"
                heading2.state = "hidden"
                mainText1.state = "hidden"
                mainText2.state = "hidden"
            }
        }
    }
}
