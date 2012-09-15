#include "mainwindow.h"

void MainWindow::debug(QString str) {
    QMessageBox msg;
    msg.setText(str);
    msg.exec();
}

int MainWindow::stringToInt(QString str) {
    return str.toInt();
}

QString MainWindow::intToString(int x) {
    QString str;
    return str.number(x);
}

QString MainWindow::doubleToString(double x) {
    QString str;
    return str.number(x);

}

int MainWindow::stringToDouble(QString str) {
    return str.toDouble();
}

MainWindow::MainWindow(QWidget *parent) : QDeclarativeView(parent)
{
    this->setResizeMode(QDeclarativeView::SizeRootObjectToView); // this one is for image background to move with
                                                                 // the main window while in scaling

    imageProv = new ImageProvider(QDeclarativeImageProvider::Image);

    this->engine()->addImageProvider(QLatin1String("provider"), imageProv);
    this->setSource(QUrl("qrc:/main.qml"));
    this->makeConnectionWithDB();
    this->makeConnectionWithQml();
    tasksInfo.resize(37); // 37 is the number of checkboxes..
}

void MainWindow::makeConnectionWithDB() {
    // HREN'
#ifdef QT_NO_DEBUG
    loader.setFileName("C:/QtSDK/Desktop/Qt/4.8.1/mingw/plugins/sqldrivers/qsqlmysql4.dll");
#else
    loader.setFileName("C:/QtSDK/Desktop/Qt/4.8.1/mingw/plugins/sqldrivers/qsqlmysqld4.dll");
#endif
    if (!loader.load())
        debug(loader.errorString());

    // set everything for data base
    xPl = qobject_cast<QSqlDriverPlugin *> ( loader.instance() );
    db = QSqlDatabase::addDatabase(xPl->create("QMYSQL"));
    db.setHostName("localhost");
    db.setDatabaseName("tasks_archive");
    db.setUserName("root");
    db.setPassword("1524323");
    if (!db.open()) {
        QSqlError err;
        err = db.lastError();
        debug(err.text());
    }
    query = new QSqlQuery(db);
}

void MainWindow::makeConnectionWithQml() {
    // get root object
    object = (QObject *)this->rootObject();
    this->rootContext()->setContextProperty("getTask", this);
}

void MainWindow::toDatabase(QString diff) {
    execution = "SELECT task, answer, difficulty, comment FROM tasks WHERE (difficulty = " + diff + ") and (";
    for (int i = 0; i < tasksInfo.size(); i++) {
        execution += "class" + intToString(i + 1) + " = ";
        execution += tasksInfo[i] == false ? "0" : "1";
        if (i != tasksInfo.size() - 1)
            execution += ") and (";
    }
    execution += ");";
  //  debug(execution);
    if (!query->exec(execution)) {
        QSqlError err;
        err = query->lastError();
        debug(err.text());
    }
}

double MainWindow::getAnswer() {
    return query->value(1).toDouble();
}

void MainWindow::setTask() {
    ba = query->value(0).toByteArray();
    imageProv->svg.load(ba);
}

bool MainWindow::nextTask() {
    query->next();
    debug(intToString(query->at()));
    debug(intToString(query->size() - 1));
    return query->at() == (query->size() - 1);
}

bool MainWindow::prevTask() {
    query->previous();
    return query->at() == 0;
}

int MainWindow::getDifficulty() {
    return query->value(2).toInt();
}

QString MainWindow::getComment() {
    return query->value(3).toString();
}

// this function is called whenever a checkbox changes it's status
void MainWindow::updateTasksInfo(int number, bool checked) {
    tasksInfo[number] = checked;
}

void MainWindow::addTask(QString difficulty, QString comment, QString answer, QString source) {
    // *********************
    QFile f(source);
    if (f.open(QIODevice::ReadOnly)) {
        ba = f.readAll();
        f.close();
    }
    else {
        debug("Cannot load an image");
        return;
    }
    // ********************* loading a task

    execution = "INSERT INTO tasks VALUES (DEFAULT, :IMAGE, " + answer + ", '" + comment + "', " + difficulty + ", ";
    for (int i = 0; i < tasksInfo.size(); i++) {
        execution += tasksInfo[i] == false ? "0, " : "1, ";
    }
    execution.resize(execution.size() - 2);
    execution += ");";
  //  debug(execution);
    query->prepare(execution.toUtf8()); //
    query->bindValue(":IMAGE", ba);
    if (!query->exec()) {
        QSqlError err;
        err = query->lastError();
        debug(err.text());
    }
    else {
        debug("Works fine");
    }
}

QString MainWindow::findSource() {
    return QFileDialog::getOpenFileName(this,
                        QString::fromLocal8Bit("Выберите задачу"), QCoreApplication::applicationDirPath(),
                        QString::fromLocal8Bit("Векторное изображение (*.svg)"));
}

MainWindow::~MainWindow()
{
    delete object;
    delete xPl;
    delete qmlClass;
    delete query;
    delete imageProv;
}
