import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"

/**
 * Erfasst die Größe der einzelnen Sprites und ihre Abstände im Sprite-Sheet.
 *
 * Die Werte werden für die Berechnung des Rasters und der auszuschneidenden
 * Bildbereiche verwendet.
 */
MaterialPane {
    id: spriteSetup
    width: 908
    Material.elevation: 4
    MaterialLabel {
        text: qsTr("Sprite")
        elide: "ElideRight"
        Layout.fillWidth: true
        font.pointSize: Fonts.mediumFontBold.pointSize
        font.bold: true
        font.capitalization: "AllUppercase"
    }

    /**
     * Ordnet die Einstellungen abhängig von der verfügbaren Breite automatisch an.
     */
    Flow {
        Layout.alignment: Qt.AlignBottom
        Layout.topMargin: 16
        spacing: 16
        Layout.fillWidth: true

        /**
         * Legt die Breite eines einzelnen Sprites fest.
         */
        MaterialDoubleSpinBox {
            title: "Breite"
            from : 8
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteWidth
            onValueModified: {
                appSettings.spriteWidth = value;
            }
        }

        /**
         * Legt die Höhe eines einzelnen Sprites fest.
         */
        MaterialDoubleSpinBox {
            title: "Höhe"
            from : 8
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteHeight
            onValueModified: {
                appSettings.spriteHeight = value;
            }
        }

        /**
         * Legt den horizontalen Abstand zwischen den Sprites fest.
         */
        MaterialDoubleSpinBox {
            title: "Abstand-X"
            from : 0
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteDistanceX
            onValueModified: {
                appSettings.spriteDistanceX = value;
            }
        }

        /**
         * Legt den vertikalen Abstand zwischen den Sprites fest.
         */
        MaterialDoubleSpinBox {
            title: "Abstand-Y"
            from : 0
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteDistanceY
            onValueModified: {
                appSettings.spriteDistanceY = value;
            }
        }
    }
}