import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Shapes
import "../../../Controls"

Item {
    id: spriteSingleEditPreview
    anchors.fill: parent
    clip: true
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
    
    DragHandler {
        target: null
        
        property int __index: -1
        property real __startX: 0
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
