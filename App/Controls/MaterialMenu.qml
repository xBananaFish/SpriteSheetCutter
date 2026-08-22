import QtQuick
import QtQuick.Controls.Material

Menu {
    id: menu
    width: 230
    leftPadding: 8
    rightPadding: 8
    Material.background: ColorPalette.backgroundAlt
    Material.elevation: 12

    background: MaterialPane {
        anchors.fill: parent
        radius: Theme.controlRadius
    }

    delegate: MaterialMenuItem { }
}
