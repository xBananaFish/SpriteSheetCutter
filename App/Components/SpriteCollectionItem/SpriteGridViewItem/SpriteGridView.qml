import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../../Controls"

GridView {
    id: spriteGridView
    boundsBehavior: Flickable.StopAtBounds
    Layout.fillWidth: true
    Layout.fillHeight: true

    property real __sc: Math.min(
                            appSettings.spriteGridSize / appSettings.spriteWidth,
                            appSettings.spriteGridSize / appSettings.spriteHeight
                          )

    cellWidth: appSettings.spriteWidth * __sc
    cellHeight: appSettings.spriteHeight * __sc
    currentIndex: validIndex
    model: spriteView.model.length
    clip: true
    reuseItems: true

    ScrollBar.vertical: ScrollBar {
        policy: "AsNeeded"
        width: 8
    }

    property int selectedIndex: 0
    property int validIndex: count > 0 ? Math.min(selectedIndex, count - 1) : -1

    function select(index) {
        selectedIndex = index;
    }

    delegate: SpriteGridDelegate {
        id: spriteGridDelegate
    }
}
