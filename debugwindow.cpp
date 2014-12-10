#include "debugwindow.h"
#include "ui_debugwindow.h"

#include "accessibilityproxy.h"

DebugWindow::DebugWindow(AccessibilityProxy *prox) :
    QMainWindow(0),
    ui(new Ui::DebugWindow), proxy(prox)
{
    ui->setupUi(this);
    QObject::connect(ui->testButton,SIGNAL(clicked()),proxy,SLOT(update()));
}

DebugWindow::~DebugWindow()
{
    delete ui;
}
