#-------------------------------------------------
#
# Project created by QtCreator 2012-08-19T13:33:19
#
#-------------------------------------------------

QT       += core gui sql declarative svg

TARGET = problemset
TEMPLATE = app

SOURCES += main.cpp\
        mainwindow.cpp \
    ImageProvider.cpp

HEADERS  += mainwindow.h \
    ImageProvider.h

OTHER_FILES += \
    TopBox.qml \
    Task.qml \
    MenuButton.qml \
    MainText.qml \
    main.qml \
    Headline.qml \
    CheckTree.qml \
    CheckGroup.qml \
    CheckBoxes.qml \
    BottomButton.qml \
    structure.xml \
    AddTaskField.qml \
    MyButton.qml \
    MyCheckBox.qml \
    MyMenu.qml

RESOURCES += \
    interface.qrc
