#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QVariantList>
#include <QUrl>

/**
 * Stellt die Exportfunktionen für einzelne Sprites und animierte GIF-Dateien bereit.
 *
 * Die benötigten Bildbereiche werden anhand des übergebenen Sprite-Modells
 * aus dem geladenen Sprite-Sheet ausgeschnitten.
 */
class FileUtils : public QObject
{
    Q_OBJECT
public:
    /**
     * Erstellt eine FileUtils-Instanz.
     *
     * @param parent Übergeordnetes QObject.
     */
    explicit FileUtils(QObject *parent = nullptr);

    /**
     * Exportiert die im Modell enthaltenen Bildbereiche als einzelne PNG-Dateien.
     *
     * @param source Pfad des verwendeten Sprite-Sheets.
     * @param folderPath Zielverzeichnis für die exportierten Sprites.
     * @param spriteName Basisname der erzeugten Dateien.
     * @param spriteFolderName Optionaler Unterordner für die erzeugten Dateien.
     * @param model Enthält Position und Größe der zu exportierenden Sprites.
     */
    Q_INVOKABLE void saveSprites(
        const QUrl &source,
        const QUrl folderPath,
        const QString &spriteName,
        const QString &spriteFolderName,
        const QVariantList &model
        );

    /**
     * Erstellt aus den im Modell enthaltenen Sprites eine animierte GIF-Datei.
     *
     * @param source Pfad des verwendeten Sprite-Sheets.
     * @param filePath Zielpfad der zu erzeugenden GIF-Datei.
     * @param frameDuration Anzeigedauer eines Frames in Millisekunden.
     * @param model Enthält die Positionen und Größen der einzelnen Frames.
     */
    Q_INVOKABLE void saveGif(const QUrl &source, const QUrl &filePath, qreal frameDuration, const QVariantList &model);

signals:
};

#endif // FILEUTILS_H