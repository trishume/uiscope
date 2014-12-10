#ifndef ACCESSIBILITYPROXY_H
#define ACCESSIBILITYPROXY_H

#include <QObject>
#include <QList>
#include <QRect>

struct __AXUIElement;
typedef const struct __AXUIElement *AXUIElementRef;
class AccessibilityProxy : public QObject
{
    Q_OBJECT
public:
    explicit AccessibilityProxy(QObject *parent = 0);
    QList <QRect> curRects;
signals:
    void newRects(const QList<QRect> &rects);

public slots:
    void update();

protected:
    void walkTree(AXUIElementRef el);
    void touch(AXUIElementRef el);
};

#endif // ACCESSIBILITYPROXY_H
