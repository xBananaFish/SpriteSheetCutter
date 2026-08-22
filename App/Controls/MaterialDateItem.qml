import QtQuick
import QtQuick.Controls
import QtQuick.Layouts


RowLayout {
    id: rlayout
    property date initDate: new Date()
    property string currentDate: `${sbDay.displayText}.${sbMonth.displayText}.${sbYear.displayText}`
    
    ColumnLayout {
        Label {
            opacity: 0.496
            text: "Tag"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false
            font.pointSize: 8
        }
        
        
        MaterialSpinBox {
            id: sbDay
            up.indicator: Item { }
            down.indicator: Item { }
            editable: true
            from: 1
            Layout.preferredWidth: 60
            font: Fonts.headerFont
            to: sbYear.value === rlayout.initDate.getFullYear()
                && sbMonth.value === rlayout.initDate.getMonth() + 1
                ? rlayout.initDate.getDate()
                : new Date(sbYear.value, sbMonth.value, 0).getDate()
            value: rlayout.initDate.getDate()
            textFromValue: function(value, locale) {
                return String(value).padStart(2, "0")
            }
            
            valueFromText: function(value, locale) {
                return parseInt(value)
            }
        }
    }
    MaterialLabel {
        text: "."
        verticalAlignment: Text.AlignBottom
        Layout.fillHeight: true
        font.pointSize: 32
    }
    
    ColumnLayout {
        MaterialLabel {
            opacity: 0.496
            text: "Monat"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false
            font.pointSize: 8
        }
        
        
        MaterialSpinBox {
            id: sbMonth
            up.indicator: Item { }
            down.indicator: Item { }
            editable: true
            to: sbYear.value >= rlayout.initDate.getFullYear()
                ? rlayout.initDate.getMonth() + 1 : 12
            from: 1
            Layout.preferredWidth: 60
            font: Fonts.headerFont
            value: rlayout.initDate.getMonth() + 1
            textFromValue: function(value, locale) {
                return String(value).padStart(2, "0")
            }
            
            valueFromText: function(value, locale) {
                return parseInt(value)
            }
        }
    }
    
    MaterialLabel {
        text: "."
        verticalAlignment: Text.AlignBottom
        Layout.fillHeight: true
        font.pointSize: 32
    }
    
    ColumnLayout {
        MaterialLabel {
            opacity: 0.496
            text: "Jahr"
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: false
            font.pointSize: 8
        }
        
        MaterialSpinBox {
            id: sbYear
            up.indicator: Item { }
            down.indicator: Item { }
            editable: true
            Layout.preferredWidth: 90
            font: Fonts.headerFont
            from: rlayout.initDate.getFullYear() - 1
            value: rlayout.initDate.getFullYear()
            to: rlayout.initDate.getFullYear()
            textFromValue: function(value, locale) {
                return value.toString()
            }
            valueFromText: function(text, locale) {
                return parseInt(text)
            }
        }
    }
}
