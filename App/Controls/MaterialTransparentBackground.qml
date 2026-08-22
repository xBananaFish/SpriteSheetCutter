import QtQuick
import QtQuick.Effects

Item {
    id: control
    anchors.fill: parent

    width: Theme.width
    height: Theme.height
    visible: opacity > 0
    Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }

    property int radius: Theme.backgroundRadius

    Rectangle {
        id: clipRect
        anchors.fill: parent
        radius: control.radius
        visible: false
        layer.enabled: true

    }

    Image {
        clip: true
        anchors.fill: parent

        source: `data:image/svg+xml,
        <svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32">
        <rect width="32" height="32" fill="#ffffff"/>
        <rect x="16" width="16" height="16" fill="#c8c8c8"/>
        <rect y="16" width="16" height="16" fill="#c8c8c8"/>
        </svg>
        `
        sourceSize: Qt.size(32, 32)
        fillMode: Image.Tile
        visible: true
        layer.enabled: true
        layer.effect: MultiEffect {
            anchors.fill: parent
            maskEnabled: true
            maskInverted: false
            maskSource: clipRect
        }
    }
}
