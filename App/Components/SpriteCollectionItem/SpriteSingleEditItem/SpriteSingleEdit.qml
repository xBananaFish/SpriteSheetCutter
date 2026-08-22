import QtQuick
import QtQuick.Layouts
import "../../../Controls"

MaterialFrame {
    id: spriteSingleEdit
    Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter
    Layout.preferredHeight: appSettings.spriteHeight * __spriteScale
    Layout.preferredWidth: appSettings.spriteWidth * __spriteScale
    //clip: true


    property real __spriteScale: Math.min( parent.width  / appSettings.spriteWidth, parent.height  / appSettings.spriteHeight)
    property var __sprite: spriteGridView.validIndex >= 0 && spriteGridView.validIndex < spriteView.model.length
                           ? spriteView.model[spriteGridView.validIndex] : null

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

    MaterialTransparentBackground { radius: 0; opacity: appSettings.showTransparentBackground ? 1 : 0 }
    SpriteSingleEditPreview { id: spriteSingleEditPreview }
    SpriteSingleEditFadeCross { }
}










