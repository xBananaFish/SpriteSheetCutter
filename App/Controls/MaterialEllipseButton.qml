import QtQuick
import QtQuick.Controls


RoundButton {
    id: control
    radius: 8
    padding: 0
    rightInset: 0
    leftInset: 0
    implicitHeight: 42
    implicitWidth: 42
    bottomInset: 0
    topInset: 0
    bottomPadding: 0
    topPadding: 0
    rightPadding: 0
    leftPadding: 0
    flat: true
    property color color: Material.color(Material.Red)
    
    background: Item {
        Rectangle {
            anchors.fill: parent
            radius: control.radius
            color: control.color
            opacity: control.down ? 0.25 : control.hovered ? 0.125 : 0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }
    
    contentItem: Item {
        Rectangle {
            anchors.centerIn: parent
            width: control.width * 0.4
            height: control.height * 0.4
            radius: Math.max(width, height) * 0.5
            color: control.color
            scale: control.down ? 0.8 : control.hovered ? 1.5 : 1.0
            Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }

        }
    }
}
