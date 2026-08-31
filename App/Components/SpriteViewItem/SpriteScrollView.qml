import QtQuick
import QtQuick.Controls
import QtQuick.Shapes
import "../../Controls"

/**
 * Stellt das geladene Sprite-Sheet zusammen mit dem berechneten Raster dar.
 *
 * Die Ansicht unterstützt Zoomen, Scrollen und das Positionieren des
 * gesamten Rasters per Mausklick oder Drag-and-drop.
 */
MaterialScrollView {
    id: spriteScrollView
    anchors.fill: parent
    anchors.margins: 8

    contentHeight: spriteContent.height * appSettings.zoom
    contentWidth: spriteContent.width * appSettings.zoom

    /**
     * Verändert den Zoom bei gedrückter Strg-Taste innerhalb der festgelegten Grenzen.
     */
    WheelHandler {
        acceptedModifiers: Qt.ControlModifier
        onWheel: function( ev ) {
            const step = 0.25
            const zoom = ev.angleDelta.y > 0 ? appSettings.zoom + step : appSettings.zoom - step
            appSettings.zoom = Math.max(appSettings.minimumZoom, Math.min(appSettings.maximumZoom, zoom))
        }
    }

    /**
     * Fasst das Sprite-Sheet und das darüberliegende Raster zu einem skalierbaren Inhalt zusammen.
     */
    Item {
        id: spriteContent
        width: spriteSheetImage.width
        height: spriteSheetImage.height
        scale: appSettings.zoom
        transformOrigin: Item.TopLeft

        /**
         * Zeigt das aktuell ausgewählte Sprite-Sheet in seiner ursprünglichen Größe an.
         */
        Image {
            id: spriteSheetImage
            source: appSettings.lastSpriteSheet
            width: sourceSize.width
            height: sourceSize.height
        }

        /**
         * Zeichnet das berechnete Sprite-Raster über das geladene Sprite-Sheet.
         */
        Shape {
            id: spriteSheeGrid
            anchors.fill: spriteSheetImage

            /**
             * Positioniert den Mittelpunkt des ersten Rasterfelds an der angeklickten Stelle.
             */
            MouseArea {
                anchors.fill: parent
                onPressed: spriteContent.forceActiveFocus()
                onClicked: {

                    appSettings.spriteOffsetX = Math.max(0, mouseX - appSettings.spriteWidth / 2)
                    appSettings.spriteOffsetY = Math.max(0, mouseY - appSettings.spriteHeight / 2)
                }
            }

            /**
             * Verschiebt das gesamte Raster unter Berücksichtigung von Zoom und Schrittweite.
             */
            DragHandler {
                target: null

                /**
                 * Enthält den horizontalen Offset zu Beginn der Verschiebung.
                 */
                property real __startX: 0

                /**
                 * Enthält den vertikalen Offset zu Beginn der Verschiebung.
                 */
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

            /**
             * Legt die Darstellung der Rasterlinien fest.
             */
            ShapePath {
                strokeWidth: 2
                strokeColor: "magenta"
                fillColor: "transparent"
                cosmeticStroke: true

                /**
                 * Erzeugt für jeden Eintrag im Sprite-Modell einen geschlossenen rechteckigen Pfad.
                 */
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