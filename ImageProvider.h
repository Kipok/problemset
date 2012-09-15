#ifndef IMAGEPROVIDER_H
#define IMAGEPROVIDER_H
#include <QDeclarativeImageProvider>
#include <QtGui/QPainter>
#include <QtSvg/QSvgRenderer>

class ImageProvider : public QDeclarativeImageProvider
{
public:
    ImageProvider(QDeclarativeImageProvider::ImageType type);
    ~ImageProvider();
    QPixmap requestPixmap(const QString& id, QSize* size, const QSize& requestedSize);
    QImage requestImage(const QString& id, QSize* size, const QSize& requestedSize);
//private:
    QSvgRenderer svg;
   // QImage img;
    QPixmap pImg;
};

#endif // IMAGEPROVIDER_H
