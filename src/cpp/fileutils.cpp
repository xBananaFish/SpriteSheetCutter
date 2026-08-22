#include "fileutils.h"

#include <QDir>
#include <QImage>

#define MSF_GIF_IMPL
#include "msf_gif.h"

FileUtils::FileUtils(QObject *parent)
    : QObject{parent}
{}

void FileUtils::saveSprites(const QUrl &source, const QUrl folderPath, const QString &spriteName, const QString &spriteFolderName, const QVariantList &model)
{
    const QImage sourceImage = QImage(source.toLocalFile());

    QDir directory(folderPath.toLocalFile());
    if ( !spriteFolderName.isEmpty() ) {
        directory.mkpath(spriteFolderName);
        directory.cd(spriteFolderName);
    }

    for ( int i = 0; i < model.count(); ++i ) {
        const QVariantMap &map = model.at(i).toMap();
        qreal spriteX = map["spriteX"].toReal();
        qreal spriteY = map["spriteY"].toReal();
        qreal spriteWidth = map["spriteWidth"].toReal();
        qreal spriteHeight = map["spriteHeight"].toReal();


        const QRect rect(
                spriteX , spriteY , spriteWidth, spriteHeight
            );

        const QImage img = sourceImage.copy(rect);
        const QString fileName = directory.filePath(QString("%1_%2.png")).arg(spriteName).arg(i + 1);
        img.save(fileName);
    }
}



void FileUtils::saveGif(const QUrl &source, const QUrl &filePath, qreal frameDuration, const QVariantList &model)
{
    if ( model.isEmpty() )
        return;

    const QImage sourceImage(source.toLocalFile());

    if ( sourceImage.isNull() )
        return;

    const QVariantMap firstSprite = model.first().toMap();
    const qreal spriteWidth = firstSprite["spriteWidth"].toReal();
    const qreal spriteHeight = firstSprite["spriteHeight"].toReal();
    const qreal delay = frameDuration / 10.0;

    MsfGifState gif = {};
    msf_gif_alpha_threshold = 128;

    if ( !msf_gif_begin(&gif, spriteWidth, spriteHeight) )
        return;

    for ( const QVariant &entry : model ) {
        const QVariantMap map = entry.toMap();
        const qreal spriteX = map["spriteX"].toReal();
        const qreal spriteY = map["spriteY"].toReal();

        const QRect rect(
            spriteX,
            spriteY,
            spriteWidth,
            spriteHeight
            );

        QImage frame = sourceImage.copy(rect).convertToFormat(QImage::Format_RGBA8888);
        msf_gif_frame(&gif, frame.bits(), delay, 16, frame.bytesPerLine());
    }

    const MsfGifResult result = msf_gif_end(&gif);

    if ( result.data ) {
        QFile file(filePath.toLocalFile());

        if ( file.open(QIODevice::WriteOnly) )
            file.write(reinterpret_cast<const char *>(result.data), result.dataSize);
    }

    msf_gif_free(result);
}
