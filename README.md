

<img width="1926" height="1101" alt="grafik" src="https://github.com/user-attachments/assets/f5e66690-3e0f-404f-bc8b-392ed687565d" />

# SpriteSheetCutter

SpriteSheetCutter ist eine Desktop-Anwendung zum Aufteilen, Bearbeiten und Exportieren von Sprite-Sheets. Die einzelnen Sprites werden anhand frei konfigurierbarer Rasterwerte automatisch erkannt und können anschließend einzeln überprüft und feinjustiert werden.

## Funktionen

* Laden von Sprite-Sheets im PNG- oder JPG-Format
* Konfiguration von Spalten und Reihen
* Einstellen der Sprite-Breite und Sprite-Höhe
* Festlegen von horizontalen und vertikalen Abständen
* Einstellen des Start-Offsets für das gesamte Raster
* Darstellung des Rasters direkt auf dem Sprite-Sheet
* Übersicht aller erkannten Sprites in einer GridView
* Auswahl und vergrößerte Darstellung einzelner Sprites
* Feinjustierung einzelner Sprite-Positionen per Maus oder Tastatur
* Verschiebbare Hilfslinien zur genaueren Ausrichtung
* Zoomfunktion für die Sprite-Sheet-Ansicht
* Optionaler transparenter Hintergrund zur besseren Kontrolle
* Export aller Sprites als einzelne PNG-Dateien
* Export der Sprite-Abfolge als animiertes GIF
* Einstellbare Geschwindigkeit der GIF-Animation

## Bedienung

1. Sprite-Sheet öffnen.
2. Anzahl der Reihen und Spalten festlegen.
3. Sprite-Größe, Abstände und Offset einstellen.
4. Das berechnete Raster in der Vorschau kontrollieren.
5. Einzelne Sprites auswählen und bei Bedarf feinjustieren.
6. Die Sprites als PNG-Dateien oder als animiertes GIF exportieren.

## Technische Grundlage

* **Qt 6**
* **Qt Quick / QML**
* **C++**
* **qmake**
* **msf_gif** für die GIF-Erstellung

Die Benutzeroberfläche wurde vollständig mit QML umgesetzt. Die Verarbeitung und der Export der Bilddaten erfolgen über C++ und `QImage`.


