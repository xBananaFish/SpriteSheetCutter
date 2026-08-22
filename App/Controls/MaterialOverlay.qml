import QtQuick
import QtQuick.Controls

MaterialFrame {
    id: control
    property bool isAboutToOpen: opacity > 0 && visible
    property bool isOpen: opacity >= 1 && visible
    property bool closedClicked: false

    Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
    signal closed()
    function open() {
        closedClicked = false
        opacity = 1;
    }

    function close() {
        closedClicked = true;
        opacity = 0;
    }

    background: Rectangle {
        color: ColorPalette.foreground
        opacity: 0.75
    }

    MouseArea {
        anchors.fill: parent;
        onClicked: control.close()
    }
}
