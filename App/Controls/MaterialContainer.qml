import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: control

    implicitHeight: clayout.implicitHeight + padding * 2
    implicitWidth: clayout.implicitWidth + padding * 2
    radius: Theme.globalRadius
    color: ColorPalette.backgroundElevated
    border.color: ColorPalette.border
    
    default property alias contentItems: glayout.children
    property alias padding: clayout.anchors.margins

    property alias rowSpacing: glayout.rowSpacing
    property alias columnSpacing: glayout.columnSpacing
    property alias rows: glayout.rows
    property alias columns: glayout.columns
    property alias title: lbl.text
    property alias titleFont: lbl.font
    property alias titleVisible: lbl.visible
    
    ColumnLayout {
        id: clayout
        anchors.fill: parent
        anchors.margins: 16
        spacing: control.rowSpacing

        MaterialLabel {
            id: lbl
            visible: text.trim().length > 0
            text: "Title"
            font.capitalization: Font.AllUppercase
            font.bold: true
            Layout.fillWidth: true
        }

        GridLayout {
            id: glayout
            rowSpacing: 16
            columnSpacing: 16
            rows: -1
        }
    }

    
}
