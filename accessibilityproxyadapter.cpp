#include "accessibilityproxyadapter.h"
#include "accessibilityproxy.h"

#include <QDebug>

QDBusArgument &operator<<(QDBusArgument &argument, const QRect &r)
{
    argument.beginStructure();
    argument << r.x() << r.y() << r.width() << r.height();
    argument.endStructure();
    return argument;
}

// Retrieve the MyStructure data from the D-Bus argument
const QDBusArgument &operator>>(const QDBusArgument &argument, QRect &r)
{
    int x,y,w,h;
    argument.beginStructure();
    argument >> x >> y >> w >> h;
    argument.endStructure();

    r.setX(x);
    r.setY(y);
    r.setWidth(w);
    r.setHeight(h);

    return argument;
}

AccessibilityProxyAdapter::AccessibilityProxyAdapter(AccessibilityProxy *prox) :
    QDBusAbstractAdaptor(prox), proxy(prox)
{
    setAutoRelaySignals(true);
}

void AccessibilityProxyAdapter::update() {
    proxy->update();
}

void AccessibilityProxyAdapter::testPing() {
    qDebug() << "ping";
}

QList<QRect> AccessibilityProxyAdapter::getRects() {
    return proxy->curRects;
}
