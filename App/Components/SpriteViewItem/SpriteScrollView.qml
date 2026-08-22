import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import "../../Controls"

MaterialScrollView {
    id: spriteScrollView
    anchors.fill: parent
    anchors.margins: 8
    
    contentHeight: spriteContent.height * appSettings.zoom
    contentWidth: spriteContent.width * appSettings.zoom
    
    WheelHandler {
        acceptedModifiers: Qt.ControlModifier
        onWheel: function( ev ) {
            const step = 0.25
            const zoom = ev.angleDelta.y > 0 ? appSettings.zoom + step : appSettings.zoom - step
            appSettings.zoom = Math.max(appSettings.minimumZoom, Math.min(appSettings.maximumZoom, zoom))
        }
    }
    
    Item {
        id: spriteContent
        width: spriteSheetImage.width
        height: spriteSheetImage.height
        scale: appSettings.zoom
        transformOrigin: Item.TopLeft
        
        Image {
            id: spriteSheetImage
            source: appSettings.lastSpriteSheet
            width: sourceSize.width
            height: sourceSize.height
        }
        
        Shape {
            id: spriteSheeGrid
            anchors.fill: spriteSheetImage
            
            MouseArea {
                anchors.fill: parent
                onPressed: spriteContent.forceActiveFocus()
                onClicked: {

                    appSettings.spriteOffsetX = Math.max(0, mouseX - appSettings.spriteWidth / 2)
                    appSettings.spriteOffsetY = Math.max(0, mouseY - appSettings.spriteHeight / 2)
                }
            }
            
            DragHandler {
                target: null
                
                property real __startX: 0
                property real __startY: 0
                
                onActiveChanged: {
                    if ( active ) {

                        __startX = appSettings.spriteOffsetX;
                        __startY = appSettings.spriteOffsetY;
                    }
                }
                onTranslationChanged:  {
                    const stepSize = appSettings.movingStepSize
                    const spriteX = __startX + activeTranslation.x / appSettings.zoom;
                    const snappedX = Math.round( spriteX / stepSize ) * stepSize
                    const spriteY = __startY + activeTranslation.y / appSettings.zoom;
                    const snappedY = Math.round( spriteY / stepSize ) * stepSize
                    appSettings.spriteOffsetX = Math.max(0, snappedX );
                    appSettings.spriteOffsetY = Math.max(0, snappedY);
                }
            }
            
            ShapePath {
                strokeWidth: 2
                strokeColor: "magenta"
                fillColor: "transparent"
                cosmeticStroke: true
                
                PathMultiline {
                    paths: spriteView.model.map(function(obj) {
                        return [
                                    Qt.point(obj.spriteX, obj.spriteY),
                                    Qt.point(obj.spriteX + obj.spriteWidth, obj.spriteY),
                                    Qt.point(obj.spriteX + obj.spriteWidth, obj.spriteY + obj.spriteHeight),
                                    Qt.point(obj.spriteX, obj.spriteY + obj.spriteHeight),
                                    Qt.point(obj.spriteX, obj.spriteY)
                                ];
                    })
                }
            }
        }
    }
}
