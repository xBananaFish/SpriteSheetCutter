import QtQuick
import QtQuick.Controls

ToolTip {
    enabled: control.enabled && control.visible && control.toolTipText.trim().length > 0
    visible: enabled && control.hovered
    text: control.toolTipText
    y: -implicitHeight - 4
    delay: 750
    timeout: 2000
    background: MaterialPane {
        anchors.fill: parent
        // color: Theme.background
        Material.elevation: 12
        Material.background: ColorPalette.backgroundElevated
    }
}
