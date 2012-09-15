// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    id: button
    property string buttonText

    width: mainwindow.width * 0.225; height: mainwindow.height * 0.03166666
    smooth: true

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
        onPressed: button.gradient = pressedGrad
        onReleased: button.gradient = releasedGrad
    }
}
