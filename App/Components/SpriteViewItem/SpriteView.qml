import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"

Item {
    id: spriteView
    SplitView.minimumWidth: 400

    SplitView.preferredWidth: appSettings.spriteViewWidth
    Component.onDestruction: appSettings.spriteViewWidth = width

    property var spriteAdjustments: []
    property bool adjustmentsMoved: spriteAdjustments.some( ( ele ) => ele !== Qt.point(0,0) )

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


    function setSpritePosition(index, spriteX, spriteY) {
        if ( index < 0 || index >= model.length )
            return;

        const sprite = model[index];
        const adjustments = spriteAdjustments.slice();
        adjustments[index] = Qt.point(spriteX - (sprite.spriteX - sprite.adjustX), spriteY - (sprite.spriteY - sprite.adjustY));
        spriteAdjustments = adjustments;
    }

    function resetAdjustments() {
        for ( let i = 0; i < spriteAdjustments.length; ++i) {
            spriteAdjustments[i] = Qt.point(0,0)
        }
        spriteAdjustmentsChanged();
    }

    function resetAdjustmentsAt( index ) {
        spriteAdjustments[index] = Qt.point(0,0)
        spriteAdjustmentsChanged();
    }



    MaterialTransparentBackground {
        opacity: appSettings.showTransparentBackground ? 1 : 0
    }

    SpriteScrollView {
        id: spriteScrollView
    }
}
