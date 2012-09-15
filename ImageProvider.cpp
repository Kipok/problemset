#include "ImageProvider.h"
#include <qmessagebox.h>

ImageProvider::ImageProvider(QDeclarativeImageProvider::ImageType type) :
    QDeclarativeImageProvider(type) {}

ImageProvider::~ImageProvider() {
}

QImage ImageProvider::requestImage(const QString& id, QSize* size, const QSize& requestedSize)
{
    double coef = double(requestedSize.width()) / double(svg.defaultSize().width());
    QImage img(svg.defaultSize().width() * coef, svg.defaultSize().height() * coef,
               QImage::Format_ARGB32_Premultiplied);

    img.fill(QColor(0,0,0,0).rgba());
    QPainter paint(&img);
    svg.render(&paint);

    *size = requestedSize;
    return img;
}

QPixmap ImageProvider::requestPixmap(const QString& id, QSize* size, const QSize& requestedSize)
{
    QPixmap image = pImg;
    QPixmap result;

    if (requestedSize.isValid() )
        result = image.scaled(requestedSize, Qt::KeepAspectRatio, Qt::SmoothTransformation);
    else
        result = image;
    *size = result.size();
    return result;
}
