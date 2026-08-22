import QtQuick
import QtQuick.Controls.Material

TextField {
    id: control
    bottomPadding: 0
    implicitHeight: Theme.controlHeight + topInset
    implicitWidth: 120
    font: Fonts.controlFont

    Material.foreground: ColorPalette.foreground
    topInset: __lbl.visible ? __lbl.implicitHeight + spacing : 0
    topPadding: topInset

    property string title: "Title"
    property bool isValid: true
    property int spacing : 4

    MaterialLabel {
        id: __lbl
        visible: control.title.length > 0
        text: control.title
        font.pointSize: Fonts.smallFont.pointSize
        font.capitalization: "AllUppercase"
    }

    background: Item {
        implicitWidth: 140
        implicitHeight: control.Material.textFieldHeight

        Rectangle {
            anchors.fill: parent
            radius: Theme.controlRadius
            color: ColorPalette.backgroundAlt
            border.color: (enabled && control.hovered) ? ColorPalette.foregroundMuted : ColorPalette.border
            Behavior on border.color { ColorAnimation { duration: 200 } }
        }

        Rectangle {
            anchors.fill: parent
            radius: Theme.controlRadius
            color: ColorPalette.transparent
            border.color: ColorPalette.accent
            opacity: (enabled && control.activeFocus) ? 1 : 0
            border.width: 2
            Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
        }
    }

}
