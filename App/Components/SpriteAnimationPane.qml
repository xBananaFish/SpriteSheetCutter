import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"

/**
 * Stellt die Steuerung und Vorschau der Sprite-Animation bereit.
 *
 * Die im Sprite-Modell enthaltenen Bildbereiche werden nacheinander
 * dargestellt und können mit einer frei wählbaren Geschwindigkeit abgespielt werden.
 */
MaterialPane {
    id: spriteAnimationPane
    MaterialLabel {
        text: qsTr("Animation")
        elide: "ElideRight"
        Layout.fillWidth: true
        font.pointSize: Fonts.mediumFontBold.pointSize
        font.bold: true
        font.capitalization: "AllUppercase"
    }

    /**
     * Enthält die Geschwindigkeitseinstellung und die Wiedergabesteuerung.
     */
    FlexboxLayout {
        Layout.fillWidth: true
        Layout.topMargin: 16
        rowGap: 16
        columnGap: 16
        wrap: FlexboxLayout.Wrap
        Layout.preferredHeight: childrenRect.height
        alignItems: FlexboxLayout.AlignEnd

        /**
         * Legt die Anzeigedauer eines Frames in Millisekunden fest.
         */
        MaterialSpinBox {
            title: "Geschw. (ms)"
            from: 1
            to: 30000
            value: appSettings.animationSpeed
            stepSize: 1
            onValueModified: appSettings.animationSpeed = value
            Layout.alignment: Qt.AlignBottom
        }

        /**
         * Enthält die Aktionen zum Abspielen, Pausieren und Stoppen der Animation.
         */
        RowLayout {
            spacing: 2

            /**
             * Startet die Wiedergabe der Animation.
             */
            MaterialFlatButton {
                enabled: !spriteGif.isRunning
                icon.source: Icons.play_arrow
                onClicked: {
                    spriteGif.play()
                }
            }

            /**
             * Pausiert die Animation beim aktuellen Frame.
             */
            MaterialFlatButton {
                enabled: spriteGif.isRunning
                icon.source: Icons.pause
                onClicked: {
                    spriteGif.pause()
                }
            }

            /**
             * Stoppt die Animation und springt zum ersten Frame zurück.
             */
            MaterialFlatButton {
                enabled: spriteGif.isRunning
                icon.source: Icons.stop
                onClicked: {
                    spriteGif.stop()
                }
            }
        }
    }

    /**
     * Zeigt den aktuellen Frame der Animation in einer angepassten Größe an.
     */
    Item {
        id: spriteGif
        clip: true
        Layout.topMargin: 16
        Layout.preferredHeight: appSettings.spriteHeight * __sc
        Layout.preferredWidth: appSettings.spriteWidth * __sc
        Layout.alignment: Qt.AlignHCenter

        /**
         * Skalierungsfaktor, mit dem das Sprite in den verfügbaren Vorschaubereich eingepasst wird.
         */
        property real __sc: Math.min(
                                (spriteAnimationPane.width - spriteAnimationPane.padding * 2) / appSettings.spriteWidth,
                                (spriteAnimationPane.height - spriteAnimationPane.padding * 2) / appSettings.spriteHeight
                                )

        /**
         * Gibt an, ob der Timer und damit die Animation aktuell läuft.
         */
        property alias isRunning: __timer.running

        /**
         * Gibt an, ob die Animation innerhalb der sichtbaren Optionsleiste ausgeführt werden kann.
         */
        property bool timerEnabled: spriteOptionView.enabled

        /**
         * Enthält die fortlaufende Nummer des aktuell angezeigten Frames.
         */
        property int currentFrame: 0

        /**
         * Berechnet den gültigen Modellindex für den aktuellen Frame.
         */
        property int frameIndex: app.spriteView.model.length > 0 ? currentFrame % app.spriteView.model.length : -1

        /**
         * Enthält die Positions- und Größenangaben des aktuell angezeigten Sprites.
         */
        property var sprite: frameIndex >= 0 ? app.spriteView.model[frameIndex] : null

        /**
         * Startet die Animation, wenn mindestens zwei Frames vorhanden sind.
         */
        function play() {
            isRunning = Qt.binding(() => spriteView.model.length > 1 && spriteGif.timerEnabled);
        }

        /**
         * Hält die Animation beim aktuellen Frame an.
         */
        function pause() {
            isRunning = false;
        }

        /**
         * Beendet die Wiedergabe und setzt die Animation auf den ersten Frame zurück.
         */
        function stop() {
            isRunning = false;
            spriteGif.currentFrame = 0;
        }

        MaterialTransparentBackground { radius: 8; opacity: appSettings.showTransparentBackground ? 1 : 0 }

        /**
         * Verschiebt das Sprite-Sheet so, dass nur der aktuelle Frame sichtbar ist.
         */
        Image {
            source: appSettings.lastSpriteSheet
            width: sourceSize.width * spriteGif.__sc
            height: sourceSize.height * spriteGif.__sc
            asynchronous: true
            cache: true
            x: spriteGif.sprite ? -spriteGif.sprite.spriteX * spriteGif.__sc: 0
            y: spriteGif.sprite ? -spriteGif.sprite.spriteY * spriteGif.__sc: 0

        }

        /**
         * Schaltet die Vorschau in der eingestellten Geschwindigkeit zum nächsten Frame weiter.
         */
        Timer {
            id: __timer
            interval: appSettings.animationSpeed
            repeat: true
            running: spriteView.model.length > 1 && spriteGif.timerEnabled
            onTriggered: {
                spriteGif.currentFrame = ( spriteGif.currentFrame + 1 ) % app.spriteView.model.length
            }
        }
    }


}