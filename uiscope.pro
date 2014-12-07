#-------------------------------------------------
#
# Project created by QtCreator 2014-12-06T11:05:00
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = uiscope
TEMPLATE = app

LIBS += -framework Cocoa

SOURCES += main.cpp\
        debugwindow.cpp

HEADERS  += debugwindow.h \
    accessibilityproxy.h

FORMS    += debugwindow.ui

OBJECTIVE_SOURCES += \
    accessibilityproxy.mm
