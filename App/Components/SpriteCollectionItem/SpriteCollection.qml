import QtQuick
import QtQuick.Controls
import "../../Controls"

Item {
    id: spriteCollection
    height: 1000
    width: 500
    SplitView.minimumWidth: 248

    visible: appSettings.showSingleEdit

    SpriteCollectionPreview {
        id: spriteCollectionPreview
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }
}




















