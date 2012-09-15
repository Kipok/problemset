#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QDeclarativeView>
#include <QApplication>
#include <qdebug.h>
#include <QtGui/qmainwindow.h>
#include <QtSql/qsqldatabase.h>
#include <QtGui/QMessageBox>
#include <QtSql>
#include <QDeclarativeContext>
#include <QDeclarativeEngine>
#include <QHeaderView>
#include <QFileDialog>
#include "qpluginloader.h"
#include "ImageProvider.h"

class MainWindow : public QDeclarativeView
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = 0);
    ~MainWindow();
    Q_INVOKABLE void toDatabase(QString diff);
    Q_INVOKABLE void updateTasksInfo(int number, bool checked);
    Q_INVOKABLE void addTask(QString difficulty, QString comment, QString answer, QString source);
    Q_INVOKABLE int stringToInt(QString str);
    Q_INVOKABLE int stringToDouble(QString str);
    Q_INVOKABLE double getAnswer();
    Q_INVOKABLE int getDifficulty();
    Q_INVOKABLE QString getComment();
    Q_INVOKABLE void setTask();
    Q_INVOKABLE void debug(QString str);
    Q_INVOKABLE QString intToString(int x);
    Q_INVOKABLE QString doubleToString(double x);
    Q_INVOKABLE bool nextTask();
    Q_INVOKABLE bool prevTask();
    Q_INVOKABLE QString findSource();

    QVector <bool> tasksInfo;
    QSqlQuery *query;
    QString execution;
    QImage img;
    QByteArray ba;
    ImageProvider *imageProv;
private:
    QPluginLoader loader;
    QSqlDriverPlugin *xPl;
    QSqlDatabase db;
    QObject *qmlClass;
    QObject *object;
    void makeConnectionWithQml();
    void makeConnectionWithDB();
};

#endif // MAINWINDOW_H
