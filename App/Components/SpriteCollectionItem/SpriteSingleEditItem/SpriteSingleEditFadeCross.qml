import QtQuick
import QtQuick.Shapes
import "../../../Controls"

/**
 * Zeichnet ein optionales Fadenkreuz über die Einzelansicht des ausgewählten Sprites.
 *
 * Die horizontalen und vertikalen Hilfslinien markieren den Mittelpunkt
 * des sichtbaren Sprite-Bereichs.
 */
Shape {
    id: spriteSingleEditFadeCross
    anchors.fill: parent
    opacity: appSettings.showFadeCross ? 1 : 0
    visible: opacity > 0

    /**
     * Animiert das Ein- und Ausblenden des Fadenkreuzes.
     */
    Behavior on opacity {
        NumberAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }

    /**
     * Zeichnet die waagerechte und senkrechte Linie durch den Mittelpunkt der Vorschau.
     */
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