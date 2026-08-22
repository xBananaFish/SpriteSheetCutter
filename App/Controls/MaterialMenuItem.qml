import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

MenuItem {
    id: control
    height: visible ? Theme.controlHeight : 0
    text: "Desktop"
    topPadding: 0
    bottomPadding: 0
    icon.width: 16
    icon.height: 16
    font: Fonts.controlFont
    Material.foreground: ColorPalette.foreground

    background: Rectangle {
        implicitWidth: 200
        implicitHeight: control.Material.menuItemHeight
        color: control.highlighted ? ColorPalette.rgba(ColorPalette.blue, 0.15) : "transparent"

        Ripple {
            width: parent.width
            height: parent.height

            clip: visible
            pressed: control.pressed
            anchor: control
            active: control.down || control.highlighted
            color: ColorPalette.rgba(ColorPalette.blue, 0.15)
        }
    }
}
