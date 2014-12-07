#ifndef ACCESSIBILITYPROXY_H
#define ACCESSIBILITYPROXY_H

#include <QObject>

class AccessibilityProxy : public QObject
{
    Q_OBJECT
public:
    explicit AccessibilityProxy(QObject *parent = 0);
signals:

public slots:
    void testStuff();

protected:
};

#endif // ACCESSIBILITYPROXY_H
