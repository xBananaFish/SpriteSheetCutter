import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../../Controls"

/**
 * Zeigt alle berechneten Sprites in einer scrollbaren Rasteransicht an.
 *
 * Die Größe der Rasterelemente wird an die eingestellte Sprite-Größe
 * angepasst und ausgewählte Einträge bleiben auch bei Modelländerungen gültig.
 */
GridView {
    id: spriteGridView
    boundsBehavior: Flickable.StopAtBounds
    Layout.fillWidth: true
    Layout.fillHeight: true

    /**
     * Berechnet den Skalierungsfaktor für die Darstellung der Sprites im Raster.
     */
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

    /**
     * Enthält den zuletzt ausgewählten Modellindex.
     */
    property int selectedIndex: 0

    /**
     * Begrenzt den ausgewählten Index auf die aktuell vorhandenen Rasterelemente.
     */
    property int validIndex: count > 0 ? Math.min(selectedIndex, count - 1) : -1

    /**
     * Wählt das Sprite mit dem angegebenen Index aus.
     *
     * @param index Index des auszuwählenden Sprites.
     */
    function select(index) {
        selectedIndex = index;
    }

    /**
     * Stellt die einzelnen Sprite-Ausschnitte innerhalb des Rasters dar.
     */
    delegate: SpriteGridDelegate {
        id: spriteGridDelegate
    }
}