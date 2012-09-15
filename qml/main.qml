import QtQuick 1.1
import QtDesktop 0.1

Rectangle
{
    id: mainwindow
    // setting all geometry
    width: 800; height: 600
    Image {
        id: background
        source: "qrc:/images/background.png"
        fillMode: Image.Stretch
        anchors.fill: parent
    }

    // creating main menu. Two of them for animation could work
    MyMenu {
        state: "shown"
        id: mainMenu1
        menuType: "/menu/item"
    }
    MyMenu {
        state: "hidden"
        id: mainMenu2
        menuType: "/menu/item"
    }

    Task {
        id: tasks
        state: "hidden"
    }

    // this is for constructor to add tasks into database
    AddTaskField {
        id: addtaskfield
        state: "hidden"
    }

    // it will be shown in tasks area for choosing tasks topics
    CheckTree {
        id: tasksForChoose
        qPath: "/menu/item[@name='Выбрать задачи']/content/checkgroup"
        state: "hidden"
        xNormal: 0.30625 * mainwindow.width
    }

    // it will be shown in tasks area for choosing tasks types
    CheckBoxes {
        id: typesForChoose
        checkPath: "/menu/item[@name='Выбрать задачи']/content/checkbox"
        xNormal: 0.7375 * mainwindow.width
        state: "hidden"
    }

    // creating heading and maintext. Both double for animation
    Headline {
        id: heading1
        state: "shown"
        heading: "Заголовок: да, так он выглядит"
    }
    Headline {
        id: heading2
        state: "hidden"
        heading: "Заголовок: да, так он выглядит"
    }

    MainText {
        id: mainText1
        state: "shown"
        maintext: "Ну, вот и текст появляется..:)<br>А так-то здесь должно быть вступительное слово"
    }
    MainText {
        id: mainText2
        state: "hidden"
        maintext: "Ну, вот и текст появляется..:)<br>А так-то здесь должно быть вступительное слово"
    }

    BottomButton {
      id: bottomButton
      state: "quit"
    }


}
