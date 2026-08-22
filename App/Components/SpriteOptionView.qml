import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"


MaterialScrollView {
    id: spriteOptionView
    width: 264
    anchors.left: parent.left
    anchors.top: navigationBar.bottom
    anchors.bottom: parent.bottom
    anchors.margins: 8
    transformOrigin: Item.TopLeft
    anchors.leftMargin: appSettings.showOptionsBar ? 8 : -width
    anchors.rightMargin: appSettings.showOptionsBar ? 8 : -width
    opacity: appSettings.showOptionsBar ? 1 : 0
    visible: opacity > 0
    enabled: visible

    Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
    Behavior on anchors.leftMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
    Behavior on anchors.rightMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }

    ColumnLayout {
        width: spriteOptionView.width - 16
        SpriteSheetSetup {
            id: spriteSheetSetup
            Layout.fillWidth: true
        }
        
        SpriteSetup {
            id: spriteSetup
            Layout.fillWidth: true
        }

        SpriteAnimationPane {
            id: spriteAnimationPane
            Layout.fillWidth: true
        }
    }
    
}
