import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Popup {
    id: control
    modal: true
    anchors.centerIn: Overlay.overlay
    padding: 16
    
    property string title: "Title"
    property bool submitEnabled: true
    spacing: 16
    
    signal accepted

    default property alias contentItems: clayout.children

    function reload() {
        for ( const item of contentItems ) {
            item.Layout.fillWidth = true;
        }
    }
    
    Component.onCompleted: reload()

    background: MaterialPane {
        width: control.width
        height: control.height
        Material.elevation: 12
    }
    
    Overlay.modal: Rectangle {
        color: ColorPalette.background
        opacity: 0.9
        Behavior on opacity { NumberAnimation { duration: 150 } }
    }
    
    contentItem: ColumnLayout {
        spacing: control.spacing
        Label {
            text: control.title
            Layout.fillWidth: true
            elide: "ElideRight"
            font: Fonts.headerFontBold
        }
        ColumnLayout {
            id: clayout
            Layout.fillWidth: true
        }
        
        RowLayout {
            Item { Layout.fillWidth: true }
            MaterialButton {
                flat: true
                text: "Abbrechen"
                onClicked: {
                    control.close();
                }
            }

            MaterialButton {
                flat: true
                text: "Ok"
                enabled: control.submitEnabled
                onClicked: {
                    control.accepted()
                    control.close();
                }
            }
        }
    }
}
