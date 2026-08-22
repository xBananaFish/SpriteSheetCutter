import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Image {
    id: control
    height: 24
    width: 24
    Layout.preferredHeight: height
    Layout.preferredWidth: width

    sourceSize.height: height
    sourceSize.width: width
    property color color: ColorPalette.foreground
    layer.enabled: true
    layer.effect: MultiEffect {
        brightness: 1
        colorization: 1
        colorizationColor: control.color
    }
}
