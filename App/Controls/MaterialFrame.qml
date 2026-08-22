import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

Frame {
    id: control
    bottomPadding: 0
    topPadding: 0
    padding: 0
    height: Theme.height
    width: Theme.width

    visible: opacity > 0
    enabled: visible

    Material.elevation: 4
    Material.background: ColorPalette.background

    property int radius: Theme.backgroundRadius

    background: Rectangle {
        color: control.Material.backgroundColor
        radius: control.radius

        layer.enabled: control.enabled && control.Material.elevation > 0
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }
    }
}
