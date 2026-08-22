import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../../Controls"

Item {
    id: spriteGridDelegate
    width: spriteGridView.cellWidth
    height: spriteGridView.cellHeight
    
    property var sprite: index >= 0 && index < spriteView.model.length ? spriteView.model[index] : null
    property bool selected: spriteGridView.validIndex === index
    
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            spriteGridView.select(index);
            spriteSingleEdit.forceActiveFocus();
        }
    }
    
    Item {
        id: spriteClip
        clip: true
        anchors.fill: parent
        anchors.margins: 2
        
        property real offsetX: (width - appSettings.spriteWidth * spriteGridView.__sc) / 2
        property real offsetY: (height - appSettings.spriteHeight * spriteGridView.__sc) / 2
        
        MaterialTransparentBackground {
            anchors.margins: 1
            radius: Theme.controlRadius
            opacity: appSettings.showTransparentBackground ? 1 : 0
        }
        
        Image {
            source: appSettings.lastSpriteSheet
            asynchronous: true
            cache: true
            x: spriteGridDelegate.sprite ? spriteClip.offsetX - spriteGridDelegate.sprite.spriteX  * spriteGridView.__sc: 0
            y: spriteGridDelegate.sprite ? spriteClip.offsetY - spriteGridDelegate.sprite.spriteY  * spriteGridView.__sc: 0
            width: sourceSize.width * spriteGridView.__sc
            height: sourceSize.height * spriteGridView.__sc
            visible: spriteGridDelegate.sprite !== null
            
            
        }
        
        Rectangle {
            anchors.fill: parent
            radius: Theme.controlRadius
            color: ColorPalette.rgba(ColorPalette.accent, 0.25)
            border.color: ColorPalette.accent
            border.width: 2
            opacity: spriteGridDelegate.selected ? 1 : 0
        }
    }
}
