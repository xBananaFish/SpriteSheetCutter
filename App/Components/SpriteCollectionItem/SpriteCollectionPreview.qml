import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "SpriteSingleEditItem"
import "SpriteGridViewItem"

/**
 * Stellt die Auswahl und Einzelbearbeitung der erkannten Sprites bereit.
 *
 * Ein Sprite kann in der Rasteransicht ausgewählt und anschließend
 * vergrößert betrachtet oder individuell verschoben werden.
 */
MaterialPane {
    id: spriteCollectionPreview
    spacing: 16

    /**
     * Enthält die Aktionen für Hilfslinien und das Zurücksetzen von Verschiebungen.
     */
    SpriteCollectionControls { id: spriteCollectionControls }

    /**
     * Stellt den verfügbaren Bereich für die vergrößerte Einzelansicht bereit.
     */
    Item {
        Layout.fillHeight: true
        Layout.fillWidth: true
        RowLayout {
            anchors.fill: parent

            /**
             * Zeigt das aktuell ausgewählte Sprite zur Einzelbearbeitung an.
             */
            SpriteSingleEdit {
                id: spriteSingleEdit
            }
        }
    }

    /**
     * Zeigt alle berechneten Sprites als auswählbare Rasterelemente an.
     */
    SpriteGridView { id: spriteGridView }
}