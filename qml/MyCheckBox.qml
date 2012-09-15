// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property string checkBoxText
    property bool checked: false
    property int number

    id: checkbox
    color: Qt.rgba(0, 0, 0, 0)

    // image states
    states: [
        State {
            name: "checked"
            PropertyChanges {
                target: img
                opacity: 1
            }
        },
        State {
            name: "unchecked"
            PropertyChanges {
                target: img
                opacity: 0
            }
        }
    ]
    state: "unchecked"
    width: chkText.width + 28
    height: 19
    Rectangle {
        id: tick
        width: 10
        height: 10
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 5
        border.width: 1
        // tick rectangle states
        states: [
            State {
                name: "pressed"
                PropertyChanges {
                    target: tick
                    color: "grey"
                    border.color: "grey"
                    border.width: 1
                }
            },
            State {
                name: "normal"
                PropertyChanges {
                    target: tick
                    color: "darkgrey"
                    border.color: "lightgrey"
                    border.width: 1
                }
            },
            State {
                name: "hovered"
                PropertyChanges {
                    target: tick
                    color: "lightblue"
                    border.color: "lightgrey"
                    border.width: 1
//                    gradient: Gradient {
//                        id: releasedGrad
//                        GradientStop { position: 0.0; color: Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
//                        GradientStop { position: 1.0; color: mouse.containsMouse == false ? Qt.rgba(255.0/255.0, 255.0/255.0, 235.0/255.0, 10.0/255.0) : Qt.rgba(255.0/255.0, 255.0/255.0, 245.0/255.0, 60.0/255.0) }
//                    }
                }
            }
        ]
        state: "normal"
    }
    Text {
        id: chkText
        text: checkBoxText
        font.family: "verdana"
        font.pixelSize: 11
        y: 3
        anchors.left: parent.left
        anchors.leftMargin: 23
        color: "white"
    }
    Image {
        id: img
        source: "qrc:/images/tick.svg"
        sourceSize.height: 15
        sourceSize.width: 15
        anchors.left: parent.left
        anchors.leftMargin: 3
        anchors.verticalCenter: parent.verticalCenter
    }
    // area for text
    MouseArea {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            tick.state = "hovered"
        }

        onExited: {
            tick.state = "normal"
        }

        onPressed: {
            tick.state = "pressed"
        }
        onReleased: {
            tick.state = "normal"
        }
        onClicked: {
            parent.state = (parent.state == "checked") ? "unchecked" : "checked"
            checked = checked === false ? true : false
            getTask.updateTasksInfo(number, checked)
        }
    }
    // area for tick rectangle
    MouseArea {
        anchors.fill: tick
        hoverEnabled: true

        onEntered: {
            tick.state = "hovered"
        }

        onExited: {
            tick.state = "normal"
        }

        onPressed: {
            tick.state = "pressed"
        }
        onReleased: {
            tick.state = "normal"
        }
        onClicked: {
            parent.state = (parent.state == "checked") ? "unchecked" : "checked"
            checked = checked === false ? true : false
            getTask.updateTasksInfo(number, checked)
        }
    }
}
