// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Rectangle {
    property string topBoxText

    id: topbox
    color: Qt.rgba(0, 0, 0, 0)

    width: chkText.width + 28
    height: 19
    Text {
        id: chkText
        text: topBoxText
        font.family: "verdana"
        font.pixelSize: 11
        y: 3
        anchors.left: parent.left
        anchors.leftMargin: 23
        color: "white"
    }
}
