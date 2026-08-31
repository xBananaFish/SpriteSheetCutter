import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"

/**
 * Berechnet und verwaltet die Bildbereiche der Sprites innerhalb des Sprite-Sheets.
 *
 * Die Positionen ergeben sich aus dem eingestellten Raster und können
 * für jedes Sprite unabhängig nachträglich angepasst werden.
 */
Item {
    id: spriteView
    SplitView.minimumWidth: 400

    SplitView.preferredWidth: appSettings.spriteViewWidth

    /**
     * Speichert die zuletzt verwendete Breite der Sprite-Ansicht.
     */
    Component.onDestruction: appSettings.spriteViewWidth = width

    /**
     * Enthält die individuellen Positionsverschiebungen der einzelnen Sprites.
     */
    property var spriteAdjustments: []

    /**
     * Gibt an, ob mindestens ein Sprite gegenüber seiner berechneten Rasterposition verschoben wurde.
     */
    property bool adjustmentsMoved: spriteAdjustments.some( ( ele ) => ele !== Qt.point(0,0) )

    /**
     * Enthält die berechneten Positionen und Größen aller Sprites.
     *
     * Das Modell wird aus Reihen, Spalten, Sprite-Größe, Abständen, Offsets
     * und den individuellen Positionsverschiebungen aufgebaut.
     */
    property var model: {
        const arr = [];

        for ( let row = 0; row < appSettings.rows; ++row ) {
            for ( let column = 0; column < appSettings.columns; ++column ) {
                const index = row * appSettings.columns + column;
                const adjustment = spriteAdjustments[index] || Qt.point(0, 0);
                const distX = column * appSettings.spriteDistanceX
                const _x = distX + appSettings.spriteOffsetX + column * appSettings.spriteWidth + adjustment.x; // GEÄNDERT
                const distY = row * appSettings.spriteDistanceY
                const _y = distY + appSettings.spriteOffsetY + row * appSettings.spriteHeight + adjustment.y; // GEÄNDERT
                arr.push( {
                             spriteX: _x,
                             spriteY: _y,
                             spriteWidth: appSettings.spriteWidth,
                             spriteHeight: appSettings.spriteHeight,
                             adjustX: adjustment.x,
                             adjustY: adjustment.y
                         } );
            }
        }

        return arr;
    }

    /**
     * Verschiebt ein Sprite unabhängig von seiner ursprünglichen Rasterposition.
     *
     * @param index Index des anzupassenden Sprites.
     * @param spriteX Neue horizontale Position im Sprite-Sheet.
     * @param spriteY Neue vertikale Position im Sprite-Sheet.
     */
    function setSpritePosition(index, spriteX, spriteY) {
        if ( index < 0 || index >= model.length )
            return;

        const sprite = model[index];
        const adjustments = spriteAdjustments.slice();
        adjustments[index] = Qt.point(spriteX - (sprite.spriteX - sprite.adjustX), spriteY - (sprite.spriteY - sprite.adjustY));
        spriteAdjustments = adjustments;
    }

    /**
     * Setzt die individuellen Verschiebungen aller Sprites zurück.
     */
    function resetAdjustments() {
        for ( let i = 0; i < spriteAdjustments.length; ++i) {
            spriteAdjustments[i] = Qt.point(0,0)
        }
        spriteAdjustmentsChanged();
    }

    /**
     * Setzt die individuelle Verschiebung eines Sprites zurück.
     *
     * @param index Index des zurückzusetzenden Sprites.
     */
    function resetAdjustmentsAt( index ) {
        spriteAdjustments[index] = Qt.point(0,0)
        spriteAdjustmentsChanged();
    }

    /**
     * Zeigt bei Bedarf einen transparenten Hintergrund hinter dem Sprite-Sheet an.
     */
    MaterialTransparentBackground {
        opacity: appSettings.showTransparentBackground ? 1 : 0
    }

    /**
     * Stellt das Sprite-Sheet zusammen mit dem berechneten Raster dar.
     */
    SpriteScrollView {
        id: spriteScrollView
    }
}