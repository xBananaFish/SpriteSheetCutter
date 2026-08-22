import QtQuick
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl
import QtQuick.Layouts

Pane {
    id: control
    width: 200

    rightPadding: 16
    leftPadding: 16
    bottomPadding: 16
    topPadding: 16
    padding: 16
    Material.background: ColorPalette.background
    Material.elevation: 4
    property int radius: Theme.backgroundRadius
    property int orientation: Qt.Horizontal
    property int columns: orientation === Qt.Horizontal ? 1 : -1
    property int rows: orientation === Qt.Horizontal ? -1 : 1
    property color borderColor: ColorPalette.rgba( ColorPalette.border, 0.5 )
    property bool borderVisible: true
    
    default property alias contentItems: gLayout.children

    contentItem: GridLayout {
        id: gLayout
        anchors.fill: parent
        anchors.margins: control.padding
        rowSpacing: control.spacing
        columnSpacing: control.spacing
        rows: control.rows
        columns: control.columns
    }

    background: Rectangle {
        color: control.Material.backgroundColor
        radius: control.radius
        border.color: control.borderColor
        border.width: control.borderVisible ? 1 : 0
        layer.enabled: control.enabled && control.Material.elevation > 0
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }
    }
}
