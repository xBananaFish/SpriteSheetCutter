import QtQuick
import QtQuick.Controls.Material

RoundButton {
    id: control
    radius: 4
    topInset: 0
    bottomInset: 0
    rightInset: 0
    leftInset: 0
    padding: 4
    implicitHeight: 42
    implicitWidth: 42
    opacity: !enabled ? 0.25 : 1
    flat: true    
    font: Fonts.controlFont
    Material.foreground: checked ? Material.accent : ColorPalette.foreground
    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    HoverHandler { cursorShape: Qt.PointingHandCursor }

    property string toolTipText: ""

    MaterialToolTip { }

}
