import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"

/**
 * Stellt die scrollbare Seitenleiste mit den Einstellungen des SpriteSheetCutters bereit.
 *
 * Die Seitenleiste kann ein- und ausgeblendet werden und enthält die
 * Konfigurationen für Sprite-Sheet, Raster und Animationsvorschau.
 */
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

    /**
     * Animiert das Ein- und Ausblenden der Seitenleiste.
     */
    Behavior on opacity { NumberAnimation { duration: 500; easing.type: Easing.InOutQuad } }
    Behavior on anchors.leftMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }
    Behavior on anchors.rightMargin { NumberAnimation { duration: 300; easing.type: Easing.InOutQuad } }

    /**
     * Ordnet die verschiedenen Einstellungsbereiche untereinander an.
     */
    ColumnLayout {
        width: spriteOptionView.width - 16

        /**
         * Enthält die Einstellungen für das geladene Sprite-Sheet.
         */
        SpriteSheetSetup {
            id: spriteSheetSetup
            Layout.fillWidth: true
        }

        /**
         * Enthält die Einstellungen für Größe und Abstand der Sprites.
         */
        SpriteSetup {
            id: spriteSetup
            Layout.fillWidth: true
        }

        /**
         * Enthält die Steuerung und Vorschau der Sprite-Animation.
         */
        SpriteAnimationPane {
            id: spriteAnimationPane
            Layout.fillWidth: true
        }
    }
}