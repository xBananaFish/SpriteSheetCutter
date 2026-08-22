import QtQuick
import QtCore

Settings {
    id: appSettings

    property var initSettings: {
        Qt.application.name = "SpriteSheetCutter"
        Qt.application.domain = "SpriteSheetCutter.de"
        Qt.application.organization = "SpriteSheetCutter_org"
    }


    property string spriteName: ""
    property string spriteFolderName: ""
    property bool isDarkMode: true
    property real minimumZoom: 0.5
    property real maximumZoom: 10.0
    property real zoom: 1.0
    property url lastSpriteSheet: ""
    property int rows: 1
    property int columns: 1
    property real spriteWidth: 24
    property real spriteHeight: 24
    property real spriteDistanceX: 0
    property real spriteDistanceY: 0
    property real spriteOffsetX: 0
    property real spriteOffsetY: 0
    property real spriteGridSize: 100

    property real spriteViewWidth: 500

    property bool showFadeCross: true

    property real movingStepSize: 0.5
    property int animationSpeed: 100

    property bool showOptionsBar: true
    property bool showTransparentBackground: true
    property bool showSingleEdit: true

    Component.onCompleted: {
        ColorPalette.isDarkMode = isDarkMode;
    }
}
