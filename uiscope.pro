#-------------------------------------------------
#
# Project created by QtCreator 2014-12-06T11:05:00
#
#-------------------------------------------------

QT       += core gui dbus

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = uiscope
TEMPLATE = app

LIBS += -framework Cocoa

SOURCES += main.cpp\
        debugwindow.cpp \
    accessibilityproxyadapter.cpp

HEADERS  += debugwindow.h \
    accessibilityproxy.h \
    UIElementUtilities.h \
    accessibilityproxyadapter.h

FORMS    += debugwindow.ui

OBJECTIVE_SOURCES += \
    accessibilityproxy.mm \
    UIElementUtilities.mm

OTHER_FILES +=
