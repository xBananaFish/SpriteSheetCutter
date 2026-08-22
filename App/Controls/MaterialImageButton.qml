import QtQuick
import QtQuick.Controls

MaterialRoundButton {
    id: control
    
    icon.source: Categories.arbeit

    contentItem: Image {
        anchors.fill: parent
        anchors.margins: 4
        source: control.icon.source
        fillMode: Image.PreserveAspectFit
    }
    background: Item {
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            radius: control.radius
            color: ColorPalette.backgroundElevated
            opacity: !control.enabled ? 0 : control.down ? 1 : control.hovered ? 0.75 : 0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }        
    }
}
