import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import "../Controls"

MaterialPane {
    id: spriteSetup
    width: 908
    Material.elevation: 4
    MaterialLabel {
        text: qsTr("Sprite")
        elide: "ElideRight"
        Layout.fillWidth: true
        font.pointSize: Fonts.mediumFontBold.pointSize
        font.bold: true
        font.capitalization: "AllUppercase"
    }

    Flow {
        Layout.alignment: Qt.AlignBottom
        Layout.topMargin: 16
        spacing: 16
        Layout.fillWidth: true

        MaterialDoubleSpinBox {
            title: "Breite"
            from : 8
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteWidth
            onValueModified: {
                appSettings.spriteWidth = value;
            }
        }
        MaterialDoubleSpinBox {
            title: "Höhe"
            from : 8
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteHeight
            onValueModified: {
                appSettings.spriteHeight = value;
            }
        }

        MaterialDoubleSpinBox {
            title: "Abstand-X"
            from : 0
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteDistanceX
            onValueModified: {
                appSettings.spriteDistanceX = value;
            }
        }
        MaterialDoubleSpinBox {
            title: "Abstand-Y"
            from : 0
            to: 500
            stepSize: appSettings.movingStepSize
            value: appSettings.spriteDistanceY
            onValueModified: {
                appSettings.spriteDistanceY = value;
            }
        }

        
    }
}
