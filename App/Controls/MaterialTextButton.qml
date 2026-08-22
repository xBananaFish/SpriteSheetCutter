import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Button {
    id: control
    text: qsTr("Button")
    implicitHeight: Theme.controlHeight
    bottomInset: 0
    topInset: 0
    rightPadding: 16
    leftPadding: 16
    bottomPadding: 0
    topPadding: 0

    Material.background: ColorPalette.backgroundAlt
    Material.foreground: ColorPalette.foreground
    font: Fonts.controlFont
    property int radius: Theme.controlRadius
    checkable: true
    
    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        radius: control.radius
        color: ColorPalette.transparent

        Behavior on border.color { ColorAnimation { duration: 200 } }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color:  control.Material.rippleColor
        }
        Rectangle {
            anchors.bottom: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            width: control.checked ? control.implicitWidth / 2 : 0
            color: Material.accent
            height: 1
            Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }


    // background: Item {
    //     anchors.fill: parent
    //     visible: control.enabled
    //     Rectangle {
    //         anchors.fill: parent
    //         radius: control.radius
    //         color: ColorPalette.backgroundElevated
    //         opacity: control.down ? 1.0 : control.hovered ? 0.75 : 0
    //         Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    //     }
        
    //     Rectangle {
    //         anchors.bottom: parent.bottom
    //         anchors.horizontalCenter: parent.horizontalCenter
    //         width: control.checked ? control.implicitWidth - control.radius : 0
    //         color: Material.accent
    //         height: 1
    //         Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    //     }
    // }
    
    property string toolTipText: ""
    
    MaterialToolTip { }
}
