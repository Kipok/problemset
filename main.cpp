#include <QtGui/QApplication>
#include <QDeclarativeEngine>
#include "mainwindow.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w(NULL);
    QObject::connect((QObject*)w.engine(), SIGNAL(quit()), &a, SLOT(quit()));
    w.show();
    return a.exec();
}
