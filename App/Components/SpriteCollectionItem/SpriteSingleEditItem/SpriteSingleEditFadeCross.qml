import QtQuick
import QtQuick.Shapes
import "../../../Controls"

Shape {
    id: spriteSingleEditFadeCross
    anchors.fill: parent
    opacity: appSettings.showFadeCross ? 1 : 0
    visible: opacity > 0
    
    Behavior on opacity {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
    
    ShapePath {
        strokeWidth: 2
        strokeColor: ColorPalette.red
        fillColor: ColorPalette.transparent
        
        PathMove { x: 0; y: spriteSingleEdit.height / 2 }
        PathLine { x: spriteSingleEdit.width; y: spriteSingleEdit.height / 2 }
        PathMove { x: spriteSingleEdit.width / 2; y: 0 }
        PathLine { x: spriteSingleEdit.width / 2; y: spriteSingleEdit.height }
    }
}
