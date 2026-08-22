import QtQuick
import QtQuick.Controls.Material
import QtQuick.Layouts

Popup {
    id: control
    padding: 16

    property point pos: Qt.point(0,0)
    x: pos.x
    y: pos.y

    signal accepted

    background: MaterialPane {
        width: control.width
        height: control.height
        Material.elevation: 12
    }


}
