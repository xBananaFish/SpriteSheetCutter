import QtQuick
import QtQuick.Controls

import "../../../Controls"

/**
 * Zeigt das aktuell ausgewählte Sprite und ermöglicht dessen freie Feinjustierung.
 *
 * Durch Ziehen der Vorschau wird der verwendete Bildausschnitt innerhalb
 * des Sprite-Sheets unter Berücksichtigung der eingestellten Schrittweite verschoben.
 */
Item {
    id: spriteSingleEditPreview
    anchors.fill: parent
    clip: true

    /**
     * Positioniert das Sprite-Sheet so, dass nur der ausgewählte Bildbereich sichtbar ist.
     */
    Image {
        source: appSettings.lastSpriteSheet
        asynchronous: true
        cache: true
        width: sourceSize.width
        height: sourceSize.height
        scale: spriteSingleEdit.__spriteScale
        transformOrigin: Item.TopLeft
        x: spriteSingleEdit.__sprite ? -spriteSingleEdit.__sprite.spriteX * spriteSingleEdit.__spriteScale : 0
        y: spriteSingleEdit.__sprite ? -spriteSingleEdit.__sprite.spriteY * spriteSingleEdit.__spriteScale : 0
        visible: spriteSingleEdit.__sprite !== null
    }

    /**
     * Berechnet während des Ziehens die neue Position des ausgewählten Sprites.
     */
    DragHandler {
        target: null

        /**
         * Enthält den Index des Sprites, das zu Beginn der Bewegung ausgewählt war.
         */
        property int __index: -1

        /**
         * Enthält die horizontale Ausgangsposition des ausgewählten Sprites.
         */
        property real __startX: 0

        /**
         * Enthält die vertikale Ausgangsposition des ausgewählten Sprites.
         */
        property real __startY: 0

        onActiveChanged: {
            if ( !spriteSingleEdit.activeFocus )
                spriteSingleEdit.forceActiveFocus()

            if ( !active ) {
                return
            }

            __index = spriteGridView.validIndex;

            if ( __index < 0 )
                return;

            const sprite = spriteView.model[__index];
            __startX = sprite.spriteX;
            __startY = sprite.spriteY;
        }

        onActiveTranslationChanged: {
            if ( active  && __index >= 0 ){
                const stepSize = appSettings.movingStepSize;

                const spriteX = __startX - activeTranslation.x / spriteSingleEdit.__spriteScale;
                const spriteY = __startY - activeTranslation.y / spriteSingleEdit.__spriteScale;
                const snappedX = Math.round( spriteX / stepSize ) * stepSize
                const snappedY = Math.round( spriteY / stepSize ) * stepSize


                spriteView.setSpritePosition(__index,
                                             Math.max(0, snappedX),
                                             Math.max(0, snappedY));

            }
        }
    }
}