import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "Controls"
import "Components"
import "Components/SpriteCollectionItem"
import "Components/SpriteViewItem"

Rectangle {
    id: app
    width: Theme.width
    height: Theme.height
    color: ColorPalette.background
    property alias spriteView: spriteView

    AppSettings { id: appSettings }
    Responsive { id: responsive }

    FileDialog {
        id: spriteDialog
        nameFilters: ["*.png", "*.jpg"]
        onAccepted: {
            appSettings.lastSpriteSheet = selectedFile;
        }
    }

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

    SpriteOptionView { id: spriteOptionView }
    NavigationBar { id: navigationBar }

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















