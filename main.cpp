#include "debugwindow.h"
#include <QApplication>
#include "accessibilityproxy.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    AccessibilityProxy prox;

    DebugWindow w(&prox);
    w.show();

    return a.exec();
}
