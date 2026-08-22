import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

ColumnLayout {
    id: control
    property string title: "Title"
    property int value: 0
    property int from: 1
    property int to: 100
    property real stepSize: 1

    HoverHandler { id: __hh }

    signal valueModified(int value)

    MaterialLabel { text: control.title; Layout.fillWidth: true }
    MaterialSpinBox {
        id: __sb
        from: control.from
        to: control.to
        Layout.fillWidth: true
        value: control.value
        stepSize: control.stepSize
        onValueModified: control.valueModified(value);
    }

    MaterialSlider {
        Layout.fillWidth: true
        from: __sb.from; to: __sb.to; value: control.value
        stepSize: __sb.stepSize
        onMoved: control.valueModified(value);
        opacity: control.enabled && __hh.hovered ? 1 : 0
        enabled: opacity > 0
        Behavior on opacity { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
    }
}
