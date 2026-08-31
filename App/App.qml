import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "Controls"
import "Components"
import "Components/SpriteCollectionItem"
import "Components/SpriteViewItem"

/**
 * Bildet die Hauptoberfläche des SpriteSheetCutters.
 *
 * Die Komponente verbindet die Auswahl des Sprite-Sheets mit den
 * Bearbeitungsansichten und den Exportfunktionen.
 */
Rectangle {
    id: app
    width: Theme.width
    height: Theme.height
    color: ColorPalette.background

    /**
     * Stellt die Sprite-Ansicht und deren berechnetes Modell für andere Komponenten bereit.
     */
    property alias spriteView: spriteView

    /**
     * Stellt die dauerhaft gespeicherten Anwendungseinstellungen bereit.
     */
    AppSettings { id: appSettings }

    /**
     * Passt die Oberfläche an die verfügbare Fenstergröße an.
     */
    Responsive { id: responsive }

    /**
     * Ermöglicht die Auswahl eines Sprite-Sheets im PNG- oder JPG-Format.
     */
    FileDialog {
        id: spriteDialog
        nameFilters: ["*.png", "*.jpg"]
        onAccepted: {
            appSettings.lastSpriteSheet = selectedFile;
        }
    }

    /**
     * Wählt den Speicherort für das GIF und startet anschließend den Export.
     */
    FileDialog {
        id: gifDialog
        nameFilters: ["*.gif"]
        fileMode: FileDialog.SaveFile
        onAccepted: {
            fileUtils.saveGif(
                        appSettings.lastSpriteSheet,
                        selectedFile,
                        appSettings.animationSpeed,
                        spriteView.model
                        )
        }
    }

    /**
     * Wählt das Zielverzeichnis aus und exportiert die Sprites als einzelne Dateien.
     */
    FolderDialog {
        id: saveSpritesDialog
        currentFolder: ""
        onAccepted: {
            fileUtils.saveSprites(
                        appSettings.lastSpriteSheet,
                        selectedFolder,
                        appSettings.spriteName,
                        appSettings.spriteFolderName,
                        spriteView.model
                        )
        }
    }

    /**
     * Enthält die Einstellungen für Sprite-Sheet, Raster und Animationsvorschau.
     */
    SpriteOptionView { id: spriteOptionView }

    /**
     * Stellt die Navigation sowie die Ansichts- und Exportaktionen bereit.
     */
    NavigationBar { id: navigationBar }

    /**
     * Ordnet das Sprite-Sheet und die Einzelbearbeitung in veränderbaren Bereichen an.
     */
    SplitView {
        spacing: 16
        anchors.left: spriteOptionView.right
        anchors.right: parent.right
        anchors.top: navigationBar.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 8

        SpriteView { id: spriteView }
        SpriteCollection { id: spriteCollection }
    }
}