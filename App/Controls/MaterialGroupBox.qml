import QtQuick
import QtQuick.Controls.Material
GroupBox {
    id: control
    rightPadding: 16
    bottomPadding: 16
    leftPadding: 16
    title: ""
    font: Fonts.controlFontBold

    topInset: metric.lineSpacing + 4
    topPadding: topInset + 16

    FontMetrics {
        id: metric
        font: control.font
    }

    background: Rectangle {
        color: ColorPalette.transparent
        border.color: ColorPalette.border
        radius: 8
    }


}
