import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "SpriteSingleEditItem"
import "SpriteGridViewItem"

/**
 * Stellt die Aktionen für die Einzelbearbeitung der Sprites bereit.
 *
 * Das Fadenkreuz kann ein- oder ausgeblendet und vorgenommene
 * Positionsverschiebungen können gezielt zurückgesetzt werden.
 */
Flow {
    id: spriteCollectionControls
    spacing: 4

    /**
     * Blendet das Fadenkreuz über der Einzelansicht ein oder aus.
     */
    MaterialFlatButton {
        icon.source: Icons.grid_goldenratio
        toolTipText: `Blendet das Pfadenkreuz ${checked ? 'aus' : 'ein'}.`
        checkable: true
        checked: appSettings.showFadeCross
        onCheckedChanged: appSettings.showFadeCross = checked;
    }

    /**
     * Setzt die Verschiebung des aktuell ausgewählten Sprites zurück.
     */
    MaterialFlatButton {
        icon.source: Icons.route
        toolTipText: `Aktuelle Verschiebungen zurücksetzen.`
        enabled: spriteSingleEdit.__sprite && spriteView.spriteAdjustments[spriteGridView.validIndex] !== Qt.point(0,0)

        onClicked: {
            spriteView.resetAdjustmentsAt(spriteGridView.validIndex);
        }
    }

    /**
     * Setzt die individuellen Verschiebungen aller Sprites zurück.
     */
    MaterialFlatButton {
        icon.source: Icons.restart_alt
        toolTipText: `Alle Verschiebungen zurücksetzen.`
        enabled: spriteView.adjustmentsMoved
        onClicked: {
            spriteView.resetAdjustments();
        }
    }
}