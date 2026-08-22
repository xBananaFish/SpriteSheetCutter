import QtQuick

QtObject {
    property bool largest: app.width > 1715
    property bool smallest: app.width < 1175


    function getLimitNumber( arr, size ) {
        const index = arr.findIndex( limit => size < limit );
        return index < 0 ? arr.length + 1 : index + 1;
    }
}
