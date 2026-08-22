import QtQuick
import QtQuick.Controls.Material

Label {
    property string link: "www.google.de"

    textFormat: Text.RichText
    text: "<a href=\"" + (link.startsWith("http") ? link : "https://" + link) + "\">" + link + "</a>"

    wrapMode: Text.WordWrap
    font: Fonts.controlFont

    onLinkActivated: function(link) {
        Qt.openUrlExternally(link)
    }

    HoverHandler { cursorShape: Qt.PointingHandCursor }
}
