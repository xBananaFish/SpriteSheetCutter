import QtQuick
import QtQuick.Controls.Material

ScrollView {
    id: control
    width: 1920
    height: 1080
    property color scrollBarColor: ColorPalette.backgroundAlt
    ScrollBar.vertical: ScrollBar {
        width: 8
        policy: "AsNeeded"
        x: control.mirrored ? 0 : control.width - width
        y: control.topPadding
        height: control.availableHeight
        active: control.ScrollBar.horizontal.active
        contentItem: Rectangle {
            implicitWidth: 8
            radius: width / 2
            color: control.scrollBarColor
            opacity: parent.active ? 1 : 0.5
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }

    ScrollBar.horizontal: ScrollBar {
        height: 8
        policy: "AsNeeded"
        parent: control
        x: control.leftPadding
        y: control.height - height
        width: control.availableWidth
        active: control.ScrollBar.vertical.active

        contentItem: Rectangle {
            implicitHeight: 8
            radius: height / 2
            color: control.scrollBarColor
            opacity: parent.active ? 1 : 0.5
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }
}
