#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>
#include <QVariantList>
#include <QUrl>

class FileUtils : public QObject
{
    Q_OBJECT
public:
    explicit FileUtils(QObject *parent = nullptr);
    Q_INVOKABLE void saveSprites(
        const QUrl &source,
        const QUrl folderPath,
        const QString &spriteName,
        const QString &spriteFolderName,
        const QVariantList &model
        );

    Q_INVOKABLE void saveGif(const QUrl &source, const QUrl &filePath, qreal frameDuration, const QVariantList &model);

signals:
};

#endif // FILEUTILS_H
