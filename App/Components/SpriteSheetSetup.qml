import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"

/**
 * Erfasst die grundlegenden Einstellungen für das geladene Sprite-Sheet.
 *
 * Dazu gehören die Bezeichnungen für den Export, die Anzahl der Reihen
 * und Spalten, die Rasterposition sowie die Vergrößerung der Ansicht.
 */
MaterialPane {
    id: spriteSheetSetup
    width: 908
    Material.elevation: 4

    /**
     * Zeigt die Bereichsüberschrift und die Aktion zum Laden eines Sprite-Sheets an.
     */
    RowLayout {
        Layout.alignment: Qt.AlignTop
        MaterialLabel {
            text: qsTr("Sheet")
            Layout.fillWidth: true
            elide: "ElideRight"
            font.pointSize: Fonts.mediumFontBold.pointSize
            font.bold: true
            font.capitalization: "AllUppercase"
        }

        /**
         * Öffnet den Dateidialog zur Auswahl eines Sprite-Sheets.
         */
        MaterialFlatButton {
            icon.source: Icons.file_open
            toolTipText: "Sheet laden"
            onClicked: { spriteDialog.open() }
        }
    }

    /**
     * Ordnet die Einstellungen abhängig von der verfügbaren Breite automatisch an.
     */
    FlexboxLayout {
        Layout.topMargin: 16
        rowGap: 16
        columnGap: 16
        wrap: FlexboxLayout.Wrap
        Layout.fillWidth: true
        Layout.alignment: Qt.AlignBottom
        Layout.preferredHeight: childrenRect.height
        alignItems: FlexboxLayout.AlignEnd

        /**
         * Legt den Basisnamen der exportierten Sprite-Dateien fest.
         */
        MaterialTextField {
            title: "Name"
            Layout.preferredWidth: parent.width
            text: appSettings.spriteName
            onAccepted: { appSettings.spriteName = text; }
            onTextEdited: { appSettings.spriteName = text; }
        }

        /**
         * Legt den optionalen Unterordner für den Sprite-Export fest.
         */
        MaterialTextField {
            title: "Ordner-Name"
            Layout.preferredWidth: parent.width
            text: appSettings.spriteFolderName
            onAccepted: { appSettings.spriteFolderName = text; }
            onTextEdited: { appSettings.spriteFolderName = text; }
        }

        /**
         * Legt die Anzahl der Sprite-Reihen fest.
         */
        MaterialSpinBox {
            title: "Reihen"
            Layout.fillWidth: false
            from : 1
            to: 50
            value: appSettings.rows
            onValueModified: {
                appSettings.rows = value;
            }
        }

        /**
         * Legt die Anzahl der Sprite-Spalten fest.
         */
        MaterialSpinBox {
            title: "Spalten"
            from : 1
            to: 50
            value: appSettings.columns
            onValueModified: {
                appSettings.columns = value;
            }
        }

        /**
         * Legt den horizontalen Abstand des Rasters zum Bildrand fest.
         */
        MaterialDoubleSpinBox {
            title: "Offset-X"
            from : 0
            to: 1000
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteOffsetX
            onValueModified: {
                appSettings.spriteOffsetX = value;
            }
        }

        /**
         * Legt den vertikalen Abstand des Rasters zum Bildrand fest.
         */
        MaterialDoubleSpinBox {
            title: "Offset-Y"
            from : 0
            to: 1000
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteOffsetY
            onValueModified: {
                appSettings.spriteOffsetY = value;
            }
        }

        /**
         * Ermöglicht das Vergrößern der Sprite-Sheet-Ansicht und das Zurücksetzen des Zooms.
         */
        RowLayout {
            spacing: 8
            MaterialSpinBox {
                id: __zoomSb
                title: "Zoom"
                from: appSettings.minimumZoom * 100
                to: appSettings.maximumZoom * 100

                Binding {
                    target: __zoomSb
                    value: appSettings.zoom * 100
                    property: "value"
                }

                stepSize: 25
                onValueModified: {
                    const zoom = Math.max(appSettings.minimumZoom, Math.min(appSettings.maximumZoom, value / 100));
                    appSettings.zoom = zoom
                }
            }
            MaterialButton {
                icon.source: Icons.fit_screen
                Layout.alignment: Qt.AlignBottom
                enabled: appSettings.zoom !== 1.0
                onClicked: {
                    appSettings.zoom = 1.0
                }
                toolTipText: "Zoom zurücksetzen"
            }
        }
    }

    Item {
        Layout.fillHeight: true
    }
}