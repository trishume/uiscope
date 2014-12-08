#include "accessibilityproxy.h"

#include <QDebug>

#import <Cocoa/Cocoa.h>

#import "UIElementUtilities.h"

static AXUIElementRef sysEl = 0;

static void initAccessibility() {
    if(sysEl != 0) return; // don't initialize twice
//    AXIsProcessTrustedWithOptions((__bridge CFDictionaryRef)@{(__bridge id)kAXTrustedCheckOptionPrompt: @YES});
    if(!AXIsProcessTrustedWithOptions(NULL)) {
        qDebug() << "No accessibility access";
        // this check doesn't seem to work very well
//        return;
    }

    sysEl = AXUIElementCreateSystemWide();
    qDebug() << "Got system element";
}

static AXUIElementRef getFocusedWin() {
    CFTypeRef app;
    AXUIElementCopyAttributeValue(sysEl, kAXFocusedApplicationAttribute, &app);

    if (app) {
        CFTypeRef win;
        AXError result = AXUIElementCopyAttributeValue((AXUIElementRef) app, (CFStringRef)NSAccessibilityFocusedWindowAttribute, &win);

        CFRelease(app);

        if (result == kAXErrorSuccess) {
            return (AXUIElementRef) win;
        }
    }

    return 0;
}

static id getProperty(AXUIElementRef win, NSString* propType, id defaultValue) {
    CFTypeRef _someProperty;
    if (AXUIElementCopyAttributeValue(win, (CFStringRef)propType, &_someProperty) == kAXErrorSuccess)
        return CFBridgingRelease(_someProperty);

    return defaultValue;
}

static NSArray *getChildren(AXUIElementRef el) {
//    CFIndex count;
//    if(AXUIElementGetAttributeValueCount(uiElement, NSAccessibilityChildrenAttribute, &count) != kAXErrorSuccess) return;
    NSArray *children;
    if(AXUIElementCopyAttributeValues (el, (CFStringRef)NSAccessibilityChildrenAttribute, 0, 100, (CFArrayRef *)&children) != kAXErrorSuccess) return [NSArray array];
    return children;
}

static void walkTree(AXUIElementRef el) {
    qDebug() << [[UIElementUtilities stringDescriptionOfUIElement:el] UTF8String];
    NSArray *children = getChildren(el);
    for(id el in children) {
        walkTree((AXUIElementRef)el);
    }
}

AccessibilityProxy::AccessibilityProxy(QObject *parent) :
    QObject(parent)
{
    initAccessibility();
}

void AccessibilityProxy::testStuff() {
    qDebug() << "testing";
    AXUIElementRef win = getFocusedWin();
    NSString *title = getProperty(win, NSAccessibilityTitleAttribute, @"");
    qDebug() << [title UTF8String];
    NSString *descript = [UIElementUtilities descriptionForUIElement:win attribute:NSAccessibilityChildrenAttribute beingVerbose:YES];
    qDebug() << [descript UTF8String];
    walkTree(win);
}
