// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    // this is container for checkboxes plus topbox -- left tree
    id: wholeCheckGroup
    property string path
    property int number
    property string mainText
    width: 0.375 * mainwindow.width
    height: mainCheckBox.height + group.height + 5

    TopBox {
        id: mainCheckBox
        anchors.top: parent.top
        topBoxText: mainText
        Image {
            id: triangle
            source: "qrc:/images/triangle.svg"
            sourceSize.height: 10
            sourceSize.width: 10
            anchors.left: parent.left
            anchors.leftMargin: 3
            anchors.verticalCenter: parent.verticalCenter
            state: "normal"
            states: [
                State {
                    name: "normal"
                    PropertyChanges {
                        target: triangle
                        rotation: 0
                    }
                },
                State {
                    name: "turned"
                    PropertyChanges {
                        target: triangle
                        rotation: 90
                    }
                }
            ]
            transitions: [
                Transition {
                    reversible: true
                    from: "normal"
                    to: "turned"
                    PropertyAnimation { properties: rotation; duration: 400 }
                }
            ]
        }
    }
    MouseArea {
        anchors.fill: mainCheckBox
        onClicked: {
            triangle.state = triangle.state == "normal" ? "turned" : "normal"
            wholeCheckGroup.state = wholeCheckGroup.state == "clicked" ? "normal" : "clicked"
        }
    }
    Behavior on state {
        PropertyAnimation { properties: "height"; from: wholeCheckGroup.height; to: mainCheckBox.height + group.height + 5; duration: 0 }
    }

    XmlListModel {
        id: groupModel
        source: "qrc:/structure.xml"
        query: path
        XmlRole { name: "topic"; query: "@name/string()" }
        XmlRole { name: "num"; query: "@num/string()" }
    }

    Component {
        id: pdelegate
        MyCheckBox {
            checkBoxText: topic
            number: getTask.stringToInt(num)
        }
    }

    ListView {
        id: group
        interactive: false
        anchors.top: mainCheckBox.bottom
        width: 300
        // this defines the size of the group using number of checkboxes included to this group
        height: number * 20
        // margin from topic
        x: 15
        model: groupModel
        delegate: pdelegate       
    }
    state: "normal"
    states: [
        State {
            name: "clicked"
            PropertyChanges {
                target: group
                height: number * 20
                opacity: 1
            }
        },
        State {
            name: "normal"
            PropertyChanges {
                target: group
                height: 0
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            reversible: true
            from: "normal"
            to: "clicked"
            ParallelAnimation {
                PropertyAnimation { properties: "height"; duration: 400 }
                PropertyAnimation { properties: "opacity"; duration: 400 }
            }
        }
    ]

}
