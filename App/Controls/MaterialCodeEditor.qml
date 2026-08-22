import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: textEditor
    width: 923
    height: 654
    clip: true

    property alias text: area.text

    RowLayout {
        spacing: 0
        anchors.fill: parent
        Item {
            id: lineNumberView
            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
            Layout.preferredWidth: 40
            Layout.fillHeight: true
            clip: true
            
            ListView {
                id: listViewLines
                width: 40
                height: area.metrics.lineSpacing * area.lineCount
                y: -scrollView.contentItem.contentY
                model: area.lineCount
                interactive: false
                clip: false
                boundsBehavior: Flickable.StopAtBounds
                
                delegate: Label {
                    width: ListView.view.width
                    height: area.metrics.lineSpacing
                    opacity: 0.25
                    text: index + 1
                    
                    leftPadding: 4
                    
                    background: Rectangle {
                        opacity: 0.025
                    }
                }
            }
        }
        
        Rectangle {
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            color: Theme.border
        }
        
        ScrollView {
            id: scrollView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true
            
            function ensureCursorVisible() {
                Qt.callLater(function() {
                    const cursorRect = area.cursorRectangle
                    
                    if (cursorRect.y < scrollView.contentItem.contentY) {
                        scrollView.contentItem.contentY = cursorRect.y
                    }
                    
                    if (cursorRect.y + cursorRect.height > scrollView.contentItem.contentY + scrollView.availableHeight) {
                        scrollView.contentItem.contentY = cursorRect.y + cursorRect.height - scrollView.availableHeight
                    }
                    
                    if (cursorRect.x < scrollView.contentItem.contentX) {
                        scrollView.contentItem.contentX = cursorRect.x
                    }
                    
                    if (cursorRect.x + cursorRect.width > scrollView.contentItem.contentX + scrollView.availableWidth) {
                        scrollView.contentItem.contentX = cursorRect.x + cursorRect.width - scrollView.availableWidth
                    }
                })
            }
            
            ScrollBar.vertical: ScrollBar {
                id: editorVerticalScrollBar
                width: 12
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
            }
            
            ScrollBar.horizontal: ScrollBar {
                height: 12
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
            
            MaterialCodeTextArea {
                id: area
                leftPadding: 4
                wrapMode: TextEdit.NoWrap
                width: Math.max(scrollView.availableWidth, contentWidth + leftPadding + rightPadding)
                height: Math.max(scrollView.availableHeight, contentHeight + topPadding + bottomPadding)
                selectionColor: ColorPalette.accent
                onContentWidthChanged: scrollView.ensureCursorVisible()
                onContentHeightChanged: scrollView.ensureCursorVisible()
                onTextChanged: scrollView.ensureCursorVisible()
                onLineCountChanged: scrollView.ensureCursorVisible()
                
                // SyntaxHighlighter { textDocument: area.textDocument }

                Keys.onPressed: function( ev ) {
                    if (ev.key === Qt.Key_Backtab || (ev.key === Qt.Key_Tab && (ev.modifiers & Qt.ShiftModifier))) {
                        tabBackward(ev);
                        return;
                    }

                    if (ev.key === Qt.Key_Tab) {
                        tabForward(ev);
                        return;
                    }

                    if ( ev.key === Qt.Key_Delete && (ev.modifiers & Qt.ShiftModifier ) ) {
                        clearLine( ev );
                        return;
                    }

                    if (ev.key === Qt.Key_Return || ev.key === Qt.Key_Enter) {
                        moveBrackets( ev );
                        return;
                    }

                    if ( ev.text === ")" ) {
                        moveAtSign(ev, ")");
                        return;
                    }

                    if ( ev.text === "]" ) {
                        moveAtSign(ev, "]");
                        return;
                    }

                    if ( ev.text === "}" ) {
                        moveAtSign(ev, "}");
                        return;
                    }

                    if ( ev.text === "(" ) {
                        insert(cursorPosition , "()")
                        --cursorPosition;
                        ev.accepted = true;
                        return;
                    }

                    if ( ev.text === "{" ) {
                        insert(cursorPosition , "{}")
                        --cursorPosition;
                        ev.accepted = true;
                        return;
                    }

                    if ( ev.text === "[" ) {
                        insert(cursorPosition , "[]")
                        --cursorPosition;
                        ev.accepted = true;
                        return;
                    }
                }

                Rectangle {
                    height: area.metrics.lineSpacing
                    opacity: 0.064
                    width: area.width
                    y: area.cursorRectangle.y
                }
            }
        }
    }
}
