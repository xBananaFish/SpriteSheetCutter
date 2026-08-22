import QtQuick
import QtQuick.Shapes

Shape {
    id: borderLine
    property int orientation: Qt.Horizontal
    width: orientation === Qt.Horizontal ? parent.width : 1
    height: orientation === Qt.Horizontal ? 1 : parent.height
    ShapePath {
        strokeColor: ColorPalette.border
        strokeWidth: 1
        startX: 0; startY: 0
        PathLine { x: borderLine.width; y: borderLine.height }
    }
}
