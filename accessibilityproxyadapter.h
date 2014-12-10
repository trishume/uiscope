#ifndef ACCESSIBILITYPROXYADAPTER_H
#define ACCESSIBILITYPROXYADAPTER_H

#include <QDBusAbstractAdaptor>
#include <QDBusArgument>
#include <QList>
#include <QRect>

QDBusArgument &operator<<(QDBusArgument &argument, const QRect &mystruct);
const QDBusArgument &operator>>(const QDBusArgument &argument, QRect &mystruct);


class AccessibilityProxy;
class AccessibilityProxyAdapter : public QDBusAbstractAdaptor
{
    Q_OBJECT
    Q_CLASSINFO("D-Bus Interface", "ca.thume.uiscope.accessibilityproxy")
public:
    explicit AccessibilityProxyAdapter(AccessibilityProxy *proxy);

signals:
    void newRects(const QList<QRect> &rects);

public slots:
    void update();
    void testPing();
    QList<QRect> getRects();
protected:
    AccessibilityProxy *proxy;
};

#endif // ACCESSIBILITYPROXYADAPTER_H
