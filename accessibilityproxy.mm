#include "accessibilityproxy.h"

#include <QDebug>

#import <Cocoa/Cocoa.h>

static AXUIElementRef sysEl = 0;

static void initAccessibility() {
    if(sysEl != 0) return; // don't initialize twice
//    AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)@{(__bridge id)kAXTrustedCheckOptionPrompt: @YES});
    if(!AXIsProcessTrustedWithOptions(NULL)) {
        qDebug() << "No accessibility access";
        return;
    }

    sysEl = AXUIElementCreateSystemWide();
    qDebug() << "Got system element";
}

AccessibilityProxy::AccessibilityProxy(QObject *parent) :
    QObject(parent)
{
    initAccessibility();
}

void AccessibilityProxy::testStuff() {
    qDebug() << "testing";
}
