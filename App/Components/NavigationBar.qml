import QtQuick
import QtQuick.Layouts
import "../Controls"

/**
 * Stellt die Navigation, Exportfunktionen und Fenstersteuerung der Anwendung bereit.
 *
 * Die Navigationsleiste dient gleichzeitig als benutzerdefinierte Titelleiste
 * und ermöglicht das Verschieben sowie die Größensteuerung des Fensters.
 */
MaterialFrame {
    id: navigationBar
    width: Theme.width
    height: 48
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.right: parent.right
    radius: 0

    /**
     * Ermöglicht das Verschieben des Fensters und den Wechsel der Fenstergröße per Doppelklick.
     */
    MouseArea {
        id: area
        anchors.fill: parent
        hoverEnabled: true
        onDoubleClicked:  {
            window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
        }
        onPositionChanged:  {
            if ( pressed )
                window.startSystemMove()
        }
    }

    /**
     * Ordnet die Navigationselemente und Fensteraktionen innerhalb der Leiste an.
     */
    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

        /**
         * Blendet die Seitenleiste mit den Sprite-Einstellungen ein oder aus.
         */
        MaterialFlatButton {
            icon.source: Icons.auto_awesome_mosaic
            checkable: true
            checked: appSettings.showOptionsBar
            onCheckedChanged: {
                appSettings.showOptionsBar = checked;
            }
        }

        /**
         * Öffnet das Hauptmenü für das Laden, Exportieren und Beenden der Anwendung.
         */
        MaterialTextButton {
            text: "Menü"
            checked: menu.visible
            onClicked: { menu.open() }

            /**
             * Enthält die Datei- und Exportaktionen des SpriteSheetCutters.
             */
            MaterialMenu {
                id: menu
                y: parent.height + 8
                MaterialMenuItem { text: "Sheet öffnen"; onClicked: { spriteDialog.open() } }

                /**
                 * Stellt die Exportmöglichkeiten für einzelne Sprites und GIF-Dateien bereit.
                 */
                MaterialMenu {
                    title: "Exportieren"
                    MaterialMenuItem {
                        text: "Sprites exportieren";
                        onClicked: { saveSpritesDialog.open() }
                    }
                    MaterialMenuItem {
                        text: "Als GIF exportieren";
                        onClicked: { gifDialog.open() }
                    }
                    //MaterialMenuItem { text: "Sheet öffnen"; onClicked: { spriteDialog.open() } }
                }
                MaterialMenuItem { text: "Beenden"; onClicked: { window.close() } }
            }
        }

        /**
         * Öffnet das Menü zum Ein- und Ausblenden einzelner Ansichtsbereiche.
         */
        MaterialTextButton {
            text: "Ansicht"
            checked: menuView.visible
            onClicked: {
                menuView.open()
            }

            /**
             * Enthält die Einstellungen für den Hintergrund und die Einzelansicht.
             */
            MaterialMenu {
                id: menuView
                y: parent.height + 8

                MaterialMenuItem {
                    text: `Hintergrund ${appSettings.showTransparentBackground ? 'ausblenden' : 'einblenden'}`;
                    onClicked: {
                        appSettings.showTransparentBackground = !appSettings.showTransparentBackground
                    }
                }

                MaterialMenuItem {
                    text: `Einzelansicht ${appSettings.showSingleEdit ? 'ausblenden' : 'einblenden'}`;
                    onClicked: {
                        appSettings.showSingleEdit = !appSettings.showSingleEdit
                    }
                }
                //MaterialMenuItem { text: "Beenden"; onClicked: { window.close() } }
            }
        }

        Item { Layout.fillWidth: true }

        /**
         * Minimiert das Anwendungsfenster.
         */
        MaterialFlatButton {
            icon.source: Icons.remove
            borderVisible: false
            onClicked: { window.showMinimized(); }
        }

        /**
         * Wechselt zwischen maximierter und normaler Fenstergröße.
         */
        MaterialFlatButton {
            icon.source: window.visibility === Window.Maximized ? Icons.show_max : Icons.square
            borderVisible: false
            icon.width: window.visibility === Window.Maximized ? 10 : 14
            icon.height: window.visibility === Window.Maximized ? 10 : 14
            onClicked: {
                window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
            }
        }

        /**
         * Schließt das Anwendungsfenster.
         */
        MaterialFlatButton {
            icon.source: Icons.close
            borderVisible: false
            onClicked: { window.close(); }
        }
    }
}