import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../../Controls"
import "SpriteSingleEditItem"
import "SpriteGridViewItem"

Flow {
    id: spriteCollectionControls
    spacing: 4
    MaterialFlatButton {
        icon.source: Icons.grid_goldenratio
        toolTipText: `Blendet das Pfadenkreuz ${checked ? 'aus' : 'ein'}.`
        checkable: true
        checked: appSettings.showFadeCross
        onCheckedChanged: appSettings.showFadeCross = checked;
    }

    MaterialFlatButton {
        icon.source: Icons.route
        toolTipText: `Aktuelle Verschiebungen zurücksetzen.`
        enabled: spriteSingleEdit.__sprite && spriteView.spriteAdjustments[spriteGridView.validIndex] !== Qt.point(0,0)
        
        onClicked: {
            spriteView.resetAdjustmentsAt(spriteGridView.validIndex);
        }
    }
    
    MaterialFlatButton {
        icon.source: Icons.restart_alt
        toolTipText: `Alle Verschiebungen zurücksetzen.`
        enabled: spriteView.adjustmentsMoved
        onClicked: {
            spriteView.resetAdjustments();
        }
    }
}
