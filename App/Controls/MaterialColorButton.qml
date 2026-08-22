import QtQuick
import QtQuick.Controls.Material

RoundButton {
    id: control
    text: "ColorButton"
    topPadding: 0
    leftInset: 0
    bottomPadding: 0
    bottomInset: 0
    topInset: 0
    rightInset: 0
    rightPadding: 16
    leftPadding: 16
    implicitHeight: 42
    checkable: true
    Material.background: Material.Blue
    background: Item {
        anchors.fill: parent
        Rectangle {
            anchors.fill: parent
            color: ColorPalette.backgroundElevated
            radius: control.radius
            opacity: !control.enabled ? 0 : control.hovered ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
        
        Rectangle {
            anchors.fill: parent
            radius: control.radius
            color: control.Material.background
            opacity: control.checked ? 0.25 : 0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
        
        Rectangle {
            anchors.fill: parent
            radius: control.radius
            color: ColorPalette.transparent
            border.color: control.Material.background
            opacity: control.checked ? 1 : 0
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }
    
    contentItem: Label {
        text: control.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font: control.font
        color: Material.foreground
    }
    
    
    
    property string toolTipText: ""
    
    MaterialToolTip { }
}
