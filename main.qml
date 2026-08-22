import QtQuick
import QtQuick.Controls
import App

Window {
    id: window
    width: Theme.width
    height: Theme.height

    visible: true
    title: Theme.title
    flags: Qt.Window | Qt.CustomizeWindowHint

    Material.theme: ColorPalette.isDarkMode ? Material.Dark : Material.Light
    App { id: app; anchors.fill: parent }
}

