#ifndef DEBUGWINDOW_H
#define DEBUGWINDOW_H

#include <QMainWindow>

namespace Ui {
class DebugWindow;
}

class AccessibilityProxy;
class DebugWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit DebugWindow(AccessibilityProxy *prox);
    ~DebugWindow();

private:
    Ui::DebugWindow *ui;
    AccessibilityProxy *proxy;
};

#endif // DEBUGWINDOW_H
