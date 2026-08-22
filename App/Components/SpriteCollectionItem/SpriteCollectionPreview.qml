import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "SpriteSingleEditItem"
import "SpriteGridViewItem"

MaterialPane {
    id: spriteCollectionPreview
    spacing: 16
    
    SpriteCollectionControls { id: spriteCollectionControls }

    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
        RowLayout {
            anchors.fill: parent
            
            SpriteSingleEdit {
                id: spriteSingleEdit
            }
        }        
    }
    
    SpriteGridView { id: spriteGridView }
}
