import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

import "../Controls"

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
    
    FlexboxLayout {
        Layout.fillWidth: true
        Layout.topMargin: 16
        rowGap: 16
        columnGap: 16
        wrap: FlexboxLayout.Wrap
        Layout.preferredHeight: childrenRect.height
        alignItems: FlexboxLayout.AlignEnd
        MaterialSpinBox {
            title: "Geschw. (ms)"
            from: 1
            to: 30000
            value: appSettings.animationSpeed
            stepSize: 1
            onValueModified: appSettings.animationSpeed = value
            Layout.alignment: Qt.AlignBottom
        }
        RowLayout {
            spacing: 2
            MaterialFlatButton {
                enabled: !spriteGif.isRunning
                icon.source: Icons.play_arrow
                onClicked: {
                    spriteGif.play()
                }
                
            }
            
            MaterialFlatButton {
                enabled: spriteGif.isRunning
                icon.source: Icons.pause
                onClicked: {
                    spriteGif.pause()
                }
            }
            MaterialFlatButton {
                enabled: spriteGif.isRunning
                icon.source: Icons.stop
                onClicked: {
                    spriteGif.stop()
                }
            }
        }
    }
    
    Item {
        id: spriteGif
        Layout.topMargin: 16
        property real __sc: Math.min(
                                (spriteAnimationPane.width - spriteAnimationPane.padding * 2) / appSettings.spriteWidth,
                                (spriteAnimationPane.height - spriteAnimationPane.padding * 2) / appSettings.spriteHeight
                                )
        
        Layout.preferredHeight: appSettings.spriteHeight * __sc
        Layout.preferredWidth: appSettings.spriteWidth * __sc
        clip: true
        Layout.alignment: Qt.AlignHCenter
        
        property alias isRunning: __timer.running
        property bool timerEnabled: spriteOptionView.enabled
        property int currentFrame: 0
        property int frameIndex: app.spriteView.model.length > 0 ? currentFrame % app.spriteView.model.length : -1
        property var sprite: frameIndex >= 0 ? app.spriteView.model[frameIndex] : null
        
        MaterialTransparentBackground { radius: 8; opacity: appSettings.showTransparentBackground ? 1 : 0 }
        
        
        function play() {
            isRunning = Qt.binding(() => spriteView.model.length > 1 && spriteGif.timerEnabled);
        }
        
        function pause() {
            isRunning = false;
        }
        
        function stop() {
            isRunning = false;
            spriteGif.currentFrame = 0;
        }
        
        Image {
            source: appSettings.lastSpriteSheet
            width: sourceSize.width * spriteGif.__sc
            height: sourceSize.height * spriteGif.__sc
            asynchronous: true
            cache: true
            x: spriteGif.sprite ? -spriteGif.sprite.spriteX * spriteGif.__sc: 0
            y: spriteGif.sprite ? -spriteGif.sprite.spriteY * spriteGif.__sc: 0
            
        }
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
