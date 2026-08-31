import QtQuick
import QtQuick.Controls

import "../../../Controls"

/**
 * Stellt einen Sprite-Ausschnitt innerhalb der Rasteransicht dar.
 *
 * Das Element zeigt den zugehörigen Bildbereich des Sprite-Sheets
 * und hebt ihn hervor, wenn er aktuell ausgewählt ist.
 */
Item {
    id: spriteGridDelegate
    width: spriteGridView.cellWidth
    height: spriteGridView.cellHeight

    /**
     * Enthält die Positions- und Größenangaben des dargestellten Sprites.
     */
    property var sprite: index >= 0 && index < spriteView.model.length ? spriteView.model[index] : null

    /**
     * Gibt an, ob dieses Sprite aktuell ausgewählt ist.
     */
    property bool selected: spriteGridView.validIndex === index

    /**
     * Wählt das Sprite aus und übergibt den Tastaturfokus an die Einzelansicht.
     */
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

    /**
     * Begrenzt die Darstellung auf den berechneten Bildbereich des Sprites.
     */
    Item {
        id: spriteClip
        clip: true
        anchors.fill: parent
        anchors.margins: 2

        /**
         * Zentriert den Sprite-Ausschnitt horizontal innerhalb des Rasterelements.
         */
        property real offsetX: (width - appSettings.spriteWidth * spriteGridView.__sc) / 2

        /**
         * Zentriert den Sprite-Ausschnitt vertikal innerhalb des Rasterelements.
         */
        property real offsetY: (height - appSettings.spriteHeight * spriteGridView.__sc) / 2

        /**
         * Zeigt bei Bedarf einen transparenten Hintergrund hinter dem Sprite an.
         */
        MaterialTransparentBackground {
            anchors.margins: 1
            radius: Theme.controlRadius
            opacity: appSettings.showTransparentBackground ? 1 : 0
        }

        /**
         * Verschiebt das Sprite-Sheet so, dass nur der zugehörige Bildausschnitt sichtbar ist.
         */
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

        /**
         * Hebt das aktuell ausgewählte Sprite farblich hervor.
         */
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