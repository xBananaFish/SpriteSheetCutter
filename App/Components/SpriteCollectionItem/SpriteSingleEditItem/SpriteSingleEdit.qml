import QtQuick
import QtQuick.Layouts
import "../../../Controls"

/**
 * Stellt das ausgewählte Sprite vergrößert zur Einzelbearbeitung dar.
 *
 * Der Bildausschnitt kann per Maus oder Pfeiltasten feinjustiert werden.
 * Mit gedrückter Umschalttaste wird die eingestellte Schrittweite verzehnfacht.
 */
MaterialFrame {
    id: spriteSingleEdit
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    Layout.preferredHeight: appSettings.spriteHeight * __spriteScale
    Layout.preferredWidth: appSettings.spriteWidth * __spriteScale
    //clip: true


    /**
     * Berechnet den größtmöglichen Skalierungsfaktor für den verfügbaren Vorschaubereich.
     */
    property real __spriteScale: Math.min( parent.width  / appSettings.spriteWidth, parent.height  / appSettings.spriteHeight)

    /**
     * Enthält die Daten des aktuell in der Rasteransicht ausgewählten Sprites.
     */
    property var __sprite: spriteGridView.validIndex >= 0 && spriteGridView.validIndex < spriteView.model.length
                           ? spriteView.model[spriteGridView.validIndex] : null

    /**
     * Verschiebt den ausgewählten Bildausschnitt mit den Pfeiltasten.
     *
     * @param ev Enthält die gedrückte Taste und die aktiven Modifikatortasten.
     */
    Keys.onPressed: function( ev ) {

        const idx = spriteGridView.validIndex;
        const stepSize = appSettings.movingStepSize * (ev.modifiers & Qt.ShiftModifier ? 10 : 1); // GEÄNDERT

        if ( idx < 0 )
            return;

        const sprite = spriteView.model[idx];
        const spriteX = Math.round(sprite.spriteX / stepSize) * stepSize;
        const spriteY = Math.round(sprite.spriteY / stepSize) * stepSize;

        switch ( ev.key ) {
        case Qt.Key_Up: spriteView.setSpritePosition(idx, spriteX, spriteY + stepSize); break;
        case Qt.Key_Down: spriteView.setSpritePosition(idx, spriteX, Math.max(0, spriteY - stepSize)); break;
        case Qt.Key_Left: spriteView.setSpritePosition(idx, spriteX + stepSize, spriteY); break;
        case Qt.Key_Right: spriteView.setSpritePosition(idx, Math.max(0, spriteX - stepSize), spriteY); break;
        default: return;
        }

        ev.accepted = true;
    }

    /**
     * Zeigt bei Bedarf einen transparenten Hintergrund hinter dem Sprite an.
     */
    MaterialTransparentBackground { radius: 0; opacity: appSettings.showTransparentBackground ? 1 : 0 }

    /**
     * Stellt den ausgewählten Bildausschnitt dar und ermöglicht dessen Verschiebung per Maus.
     */
    SpriteSingleEditPreview { id: spriteSingleEditPreview }

    /**
     * Blendet bei Bedarf ein Fadenkreuz über der Einzelansicht ein.
     */
    SpriteSingleEditFadeCross { }
}