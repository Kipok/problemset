// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import QtDesktop 0.1

Item {
    // it is just the container for checkboxes, not for checkgrouop
    // I mean not for union of checkboxes and topbox -- so it is right tree
    property int xNormal
    property string checkPath
    property string diff: getTask.doubleToString(spinAns.value) // it's the difficulty of the task
    id: checkBoxesTree
    width: 0.375 * mainwindow.width; height: mainwindow.height  / 3
    y: 100

    XmlListModel {
        id: checkModel
        source: "qrc:/structure.xml"
        query: checkPath
        XmlRole { name: "type"; query: "@name/string()" }
        XmlRole { name: "num"; query: "@num/string()" }
    }
    Component {
        id: pdelegate
        MyCheckBox {
            checkBoxText: type
            number: getTask.stringToInt(num)
        }
    }
    ListView {
        interactive: false
        anchors.fill: parent
        model: checkModel
        delegate: pdelegate
        spacing: 5
    }

    // honestly, this field should not be here, because it doesn't belong to checkboxes.. It just shows the difficulty of the task
    Item {
        x: -10
        y: parent.height - height + 50
        width: spinAns.width + 10; height: difficulty.height + spinAns.height + 15
        Rectangle {
            anchors.fill: parent
            border.color: "lightgrey"
            color: Qt.rgba(0, 0, 0, 0)
         //   radius: 5
        }

        Text {
            id: difficulty
            x: 55; y: 5
            width: parent.width; height: mainwindow.height * 0.03166666
            text: "Сложность: 1"
            font.pixelSize: 12
            font.family: "verdana"
            color: "white"
        }

        Slider {
            id: spinAns
            x: 5; y: difficulty.y + 20
            value: 1
            maximumValue: 10
            minimumValue: 1
            stepSize: 1
            onValueChanged: {
                difficulty.text = "Сложность: " + getTask.doubleToString(spinAns.value)
            }
        }
    }
    onStateChanged: {
        diff = getTask.intToString(spinAns.value)
    }

    states: [
        State {
            name: "shown"
            PropertyChanges { target: checkBoxesTree; x: xNormal; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: checkBoxesTree; x: mainwindow.width + 300; opacity: 0; }
        }
    ]
    transitions: [
        Transition {
            from: "shown"
            to: "hidden"
            SequentialAnimation {
                PropertyAnimation { properties: "x"; from: xNormal; to: -300; duration: 300 }
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
