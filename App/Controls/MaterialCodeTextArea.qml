import QtQuick
import QtQuick.Controls

TextArea {
    id: control

    property FontMetrics metrics: FontMetrics {
        font: control.font
    }

    topInset: 0
    leftPadding: 0
    rightPadding: 0
    bottomPadding: 0
    topPadding: 0
    background: Item {}

    font.family: "JetBrains Mono"
    text: "#version 440\n\nlayout(location = 0) in vec2 qt_TexCoord0;\nlayout(location = 0) out vec4 fragColor;\n\nlayout(std140, binding = 0) uniform buf {\nmat4 qt_Matrix;\nfloat qt_Opacity;\n};\n\nvoid main()\n{\nvec2 uv = qt_TexCoord0;\nvec2 centeredUv = uv * 2.0 - 1.0;\n\ncenteredUv.x += 0.5;\n\nfragColor = vec4(centeredUv.x, centeredUv.y, 1.0, 1.0) * qt_Opacity;\n}\n"
    tabStopDistance: 40

    function start() {
        let s = text.lastIndexOf("\n", cursorPosition - 1)
        return s === -1 ? 0 : s + 1
    }

    function end() {
        let e = text.indexOf("\n", cursorPosition)
        return e === -1 ? text.length : e + 1
    }

    function clearLine(ev) {
        remove(start(), end())
        cursorPosition = start()
        ev.accepted = true
    }

    function twistedBrackets( bracket ) {
        return bracket === ")"
                ? "("
                : bracket === "]"
                  ? "["
                  : bracket === "}"
                    ? "{" : "("
    }

    function moveAtSign(ev, bracket ) {
        const before = getText(cursorPosition-1, cursorPosition )
        const after = getText(cursorPosition, cursorPosition + 1)
        if ( before === twistedBrackets( bracket ) || after === bracket ) {
            ++cursorPosition;
        } else {
            insert(cursorPosition, bracket)
        }
        ev.accepted = true;
    }

    function tabForward(ev) {
        const indent = "\t"

        const oldStart = Math.min(selectionStart, selectionEnd)
        const oldEnd = Math.max(selectionStart, selectionEnd)
        const hasSelection = oldStart !== oldEnd

        let lineStart = text.lastIndexOf("\n", oldStart - 1)
        lineStart = lineStart === -1 ? 0 : lineStart + 1

        if (!hasSelection) {
            let lineEndForCheck = text.indexOf("\n", oldStart)
            lineEndForCheck = lineEndForCheck === -1 ? text.length : lineEndForCheck

            const beforeCursor = text.substring(lineStart, oldStart)
            const currentLine = text.substring(lineStart, lineEndForCheck)
            const firstWordIndex = currentLine.search(/\S/)

            if (firstWordIndex !== -1 && beforeCursor.length > firstWordIndex) {
                ev.accepted = false
                return
            }
        }

        let lastTouchedPosition = hasSelection ? oldEnd : oldStart

        if (hasSelection && lastTouchedPosition > lineStart && text.charAt(
                    lastTouchedPosition - 1) === "\n")
            --lastTouchedPosition

        let lineEnd = text.indexOf("\n", lastTouchedPosition)
        lineEnd = lineEnd === -1 ? text.length : lineEnd

        const oldBlock = text.substring(lineStart, lineEnd)
        const lines = oldBlock.split("\n")
        const newBlock = indent + lines.join("\n" + indent)
        const inserted = newBlock.length - oldBlock.length

        remove(lineStart, lineEnd)
        insert(lineStart, newBlock)

        if (hasSelection)
            select(lineStart, oldEnd + inserted)
        else
            cursorPosition = oldStart + indent.length

        ev.accepted = true
    }

    function tabBackward(ev) {
        const indent = "\t"

        const oldStart = Math.min(selectionStart, selectionEnd)
        const oldEnd = Math.max(selectionStart, selectionEnd)
        const hasSelection = oldStart !== oldEnd

        let lineStart = text.lastIndexOf("\n", oldStart - 1)
        lineStart = lineStart === -1 ? 0 : lineStart + 1

        let lastTouchedPosition = hasSelection ? oldEnd : oldStart

        if (hasSelection && lastTouchedPosition > lineStart && text.charAt(
                    lastTouchedPosition - 1) === "\n")
            --lastTouchedPosition

        let lineEnd = text.indexOf("\n", lastTouchedPosition)
        lineEnd = lineEnd === -1 ? text.length : lineEnd

        const oldBlock = text.substring(lineStart, lineEnd)
        const lines = oldBlock.split("\n")

        let removed = 0

        for (var i = 0; i < lines.length; ++i) {
            if (lines[i].startsWith(indent)) {
                lines[i] = lines[i].substring(indent.length)
                removed += indent.length
            }
        }

        const newBlock = lines.join("\n")

        remove(lineStart, lineEnd)
        insert(lineStart, newBlock)

        if (hasSelection)
            select(lineStart, Math.max(lineStart, oldEnd - removed))
        else
            cursorPosition = lineStart + lines[0].search(/\S/)

        ev.accepted = true
    }

    function moveBrackets(ev) {
        const pos = cursorPosition
        const left = text.charAt(pos - 1)
        const right = text.charAt(pos)

        const isBracketPair = (left === "(" && right === ")")
                            || (left === "{" && right === "}")
                            || (left === "[" && right === "]")

        let lineStart = text.lastIndexOf("\n", pos - 1)
        lineStart = lineStart === -1 ? 0 : lineStart + 1

        const currentLineIndent = text.substring(lineStart,
                                                 pos).match(/^[\t ]*/)[0]

        if (isBracketPair) {
            insert(pos,
                   "\n" + currentLineIndent + "\t" + "\n" + currentLineIndent)
            cursorPosition = pos + currentLineIndent.length + 2
            ev.accepted = true
            return
        }

        insert(pos, "\n" + currentLineIndent)
        cursorPosition = pos + currentLineIndent.length + 1
        ev.accepted = true
    }
}
