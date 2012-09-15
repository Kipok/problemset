// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {

    property string menuType

// reading all data from .xml file
    XmlListModel {
        id: structure
        source: "qrc:/xml/structure.xml"
        query: menuType

        XmlRole { name: "name";  query: "@name/string()" }
        XmlRole { name: "ifnest"; query: "@nest/number()" }
        XmlRole { name: "contentType"; query: "content/@type/string()" }
        XmlRole { name: "contenttext"; query: "content/string()" }
    }

// it means that main container for this menu is menubutton
    Component {
        id: xmlDelegate
        MenuButton {
            buttonText: name
            nest: ifnest
            type: contentType
            contentText: contenttext
        }
    }

// creating menu
    ListView {
        property int clinged
        width: mainwindow.width / 4.0; height: mainwindow.height * 2.0 / 3.0; x: 10; y: 23
        id: menu
        spacing: 4
        interactive: false
        delegate: xmlDelegate
        model: structure
    }

    states: [
        State {
            name: "shown"
            PropertyChanges { target: menu; opacity: 1; y: 23 }
        },
        State {
            name: "hidden"
            PropertyChanges { target: menu; opacity: 0; y: -100 }
        }
    ]
    transitions: [
        Transition {
            from: "shown"
            to: "hidden"
            SequentialAnimation {
                PropertyAnimation { properties: "y"; from: 23; to: mainwindow.height + 100; duration: 300 }
                ParallelAnimation {
                    PropertyAnimation { properties: "y"; from: mainwindow.height + 100; to: -100; duration: 1 }
                    PropertyAnimation { properties: "opacity"; duration: 1 }
                }
            }
        },
        Transition {
            from: "hidden"
            to: "shown"
            ParallelAnimation {
                PropertyAnimation { properties: "y"; duration: 1500; easing.type: "OutBack" }
                PropertyAnimation { properties: "opacity"; duration: 1500 }
            }
        }
    ]

}
