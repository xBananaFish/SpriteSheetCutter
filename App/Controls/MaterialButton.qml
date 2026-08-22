import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Button {
    id: control
    text: qsTr("")
    bottomInset: 0
    topInset: 0
    rightPadding: hasText ? 16 : iconPadding
    leftPadding: hasText ? 16 : iconPadding
    bottomPadding: hasText ? 0 : iconPadding
    topPadding: hasText ? 0 : iconPadding
    icon.width: 18
    icon.height: 18
    Material.roundedScale: Material.SmallScale
    Material.background: ColorPalette.backgroundAlt
    Material.foreground: ColorPalette.foreground
    font: Fonts.controlFont
    Material.elevation: 0
    implicitHeight: Theme.controlHeight
    implicitWidth: hasText  ? contentItem.implicitWidth + leftPadding + spacing + rightPadding : height

    opacity: enabled ? 1 : 0.5

    Behavior on opacity { NumberAnimation { duration: 200; easing.type: "InOutQuad" } }
    property string toolTipText: ""
    property bool hasText: text.trim().length > 0
    property int iconPadding: 8
    property bool borderVisible: true

    MaterialToolTip { }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        radius: control.Material.roundedScale === Material.FullScale ? height / 2 : control.Material.roundedScale
        color: control.Material.buttonColor(control.Material.theme, control.Material.background,
            control.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)
        border.color: !control.borderVisible ? ColorPalette.transparent : (enabled && control.checked)
                      ? ColorPalette.accent:  (enabled && control.hovered)
                        ? ColorPalette.foregroundMuted : ColorPalette.border
        Behavior on border.color { ColorAnimation { duration: 200 } }
        layer.enabled: control.enabled && color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.flat && control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}
