import QtQuick
import QtQuick.Layouts
import "../Controls"

MaterialFrame {
    id: navigationBar
    width: Theme.width
    height: 48
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.right: parent.right
    radius: 0

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

    RowLayout {
        anchors.fill: parent
        anchors.margins: 8

        MaterialFlatButton {
            icon.source: Icons.auto_awesome_mosaic
            checkable: true
            checked: appSettings.showOptionsBar
            onCheckedChanged: {
                appSettings.showOptionsBar = checked;
            }
        }

        MaterialTextButton {
            text: "Menü"
            checked: menu.visible
            onClicked: { menu.open() }

            MaterialMenu {
                id: menu
                y: parent.height + 8
                MaterialMenuItem { text: "Sheet öffnen"; onClicked: { spriteDialog.open() } }
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

        MaterialTextButton {
            text: "Ansicht"
            checked: menuView.visible
            onClicked: {
                menuView.open()
            }

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

        MaterialFlatButton {
            icon.source: Icons.remove
            borderVisible: false
            onClicked: { window.showMinimized(); }
        }

        MaterialFlatButton {
            icon.source: window.visibility === Window.Maximized ? Icons.show_max : Icons.square
            borderVisible: false
            icon.width: window.visibility === Window.Maximized ? 10 : 14
            icon.height: window.visibility === Window.Maximized ? 10 : 14
            onClicked: {
                window.visibility = window.visibility === Window.Maximized ? Window.Windowed : Window.Maximized
            }
        }

        MaterialFlatButton {
            icon.source: Icons.close
            borderVisible: false
            onClicked: { window.close(); }
        }


    }
}

