// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    property string qPath
    property int xNormal
  //  property variant listOfCheckboxes: [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    width: 0.375 * mainwindow.width; height: mainwindow.height * 3 / 5

    y: 100
    id: tree
    XmlListModel {
        id: treeModel
        source: "qrc:/structure.xml"
        query: qPath
        XmlRole { name: "topic"; query: "@name/string()" }
        XmlRole { name: "number"; query: "@number/string()" }

    }
    Component {
        id: pdelegate
        CheckGroup {
            path: qPath + "[@name='" + model.topic + "']/checkbox"
            number: getTask.stringToInt(model.number)
            mainText: model.topic
        }
    }
    ListView {
       // interactive: false
        anchors.fill: parent
        model: treeModel
        delegate: pdelegate
        spacing: 5
    }
    states: [
        State {
            name: "shown"
            PropertyChanges { target: tree; x: xNormal; opacity: 1 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: tree; x: mainwindow.width + 300; opacity: 0 }
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
