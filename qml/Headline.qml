// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    property string heading: "Заголовок: да, так он выглядит"
    property int xOx: 0.30625 * mainwindow.width
    id: headline
    y: 25
    Text {
        anchors.fill: parent
        text: heading
        font.pixelSize: 32
        color: "lightgrey"
        font.family: "georgia"
        font.bold: true
    }
    states: [
        State {
            name: "shown"
            PropertyChanges { target: headline; x: xOx; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: headline; x: mainwindow.width + 300; opacity: 0 }
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
