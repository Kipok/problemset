// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    property string maintext: "Ошибка: невозможно прочитать файл с текстом :("
    property string xOx: 0.325 * mainwindow.width
    id: mainText
    y: 130
    Text {
        anchors.fill: parent
        text: maintext
        font.pixelSize: 12
        font.family: "verdana"
        color: "white"
    }
    states: [
        State {
            name: "shown"
            PropertyChanges { target: mainText; x: xOx; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: mainText; x: mainwindow.width + 300; opacity: 0 }
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
