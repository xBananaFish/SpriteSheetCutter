import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


Rectangle {
    id: control
    Layout.fillWidth: true
    implicitHeight: clayout.implicitHeight + clayout.anchors.margins * 2
    color: ColorPalette.backgroundAlt
    border.color: ColorPalette.border
    radius: 16
    
    property alias iconSource: _icon.source
    property alias title: _lbl.text
    property alias text: materialTextArea.text
    property alias textDocument: materialTextArea.textDocument
    property bool readOnly: false
    property bool copyVisible: false
    property alias font: materialTextArea.font

    function clear() {
        materialTextArea.clear();
    }
    
    ColumnLayout {
        id: clayout
        anchors.fill: parent
        spacing: 0
        RowLayout {
            spacing: 0
            MaterialColoredImage {
                id: _icon
                visible: source.toString().length > 0
                source: ""
                Layout.leftMargin: 16
            }
            
            MaterialLabel {
                id: _lbl
                text: "Code"
                leftPadding: _icon.source.toString().length > 0 ? 8 : 16
                
                Layout.fillWidth: true
                padding: 16
                font: Fonts.controlFontBold
            }

            MaterialRoundButton {
                Layout.preferredHeight: 24
                Layout.preferredWidth: 24
                icon.source: Icons.copy_all
                Layout.rightMargin: 16
                visible: materialTextArea.text.trim().length > 0 && control.copyVisible
                onClicked: {
                    materialTextArea.selectAll();
                    materialTextArea.copy();
                    materialTextArea.select(0,0)
                }
            }
        }
        ScrollView {

            Layout.fillWidth: true
            MaterialTextArea {
                id: materialTextArea
                topPadding: 0
                topInset: 0
                tabStopDistance: 40

                font.family:  "JetBrains Mono"
                background: Item { }

                readOnly: control.readOnly
                selectedTextColor: ColorPalette.background
            }
        }
        
    }
}
