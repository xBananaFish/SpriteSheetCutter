import QtQuick
import QtQuick.Controls

import "../../Controls"

/**
 * Stellt den ein- und ausblendbaren Bereich für die Sprite-Auswahl und Einzelbearbeitung bereit.
 *
 * Die Sichtbarkeit wird über die gespeicherte Einstellung für die Einzelansicht gesteuert.
 */
Item {
    id: spriteCollection
    height: 1000
    width: 500
    SplitView.minimumWidth: 248

    visible: appSettings.showSingleEdit

    /**
     * Füllt den verfügbaren Bereich mit der Sprite-Auswahl und Einzelvorschau.
     */
    SpriteCollectionPreview {
        id: spriteCollectionPreview
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }
}