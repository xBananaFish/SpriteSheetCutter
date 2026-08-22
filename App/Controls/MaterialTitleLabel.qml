import QtQuick
import QtQuick.Layouts

ColumnLayout {
    id: control

    spacing: 0

    property string title: "Title"
    property string text: "Text"

    property alias titleFont: __title.font
    property alias titleColor: __title.color
    property alias titleVisible: __title.visible
    property alias titleOpacity: __title.opacity

    property alias font: __text.font
    property alias textColor: __text.color
    property alias textVisible: __text.visible
    property alias textOpacity: __text.opacity
    height: implicitHeight

    MaterialLabel {
        id: __title
        visible: control.title.trim().length > 0
        text: control.title
        font: Fonts.mediumFontBold
        Layout.fillWidth: true
        elide: "ElideRight"
    }

    MaterialLabel {
        id: __text
         visible: control.text.trim().length > 0
        text: control.text
        Layout.fillWidth: true
        wrapMode: "WordWrap"
        opacity: 0.75
    }

}
