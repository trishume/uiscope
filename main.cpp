#include "debugwindow.h"
#include "accessibilityproxy.h"
#include "accessibilityproxyadapter.h"

#include "stdio.h"

#include <QApplication>
#include <QDBusMetaType>
#include <QDBusConnection>
#include <QDebug>
#include <QRect>
#include <QList>
#include <QString>
#include <QFile>
#include <QDateTime>

void customMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg)
{
   Q_UNUSED(context);

   QString dt = QDateTime::currentDateTime().toString("dd/MM/yyyy hh:mm:ss");
   QString txt = QString("[%1] ").arg(dt);

   switch (type)
   {
      case QtDebugMsg:
         txt += QString("{Debug} \t\t %1").arg(msg);
         break;
      case QtWarningMsg:
         txt += QString("{Warning} \t %1").arg(msg);
         break;
      case QtCriticalMsg:
         txt += QString("{Critical} \t %1").arg(msg);
         break;
      case QtFatalMsg:
         txt += QString("{Fatal} \t\t %1").arg(msg);
         abort();
         break;
   }
   printf(txt.toLatin1().data());

   QFile outFile("/Users/tristan/misc/uiscope.log");
   outFile.open(QIODevice::WriteOnly | QIODevice::Append);

   QTextStream textStream(&outFile);
   textStream << txt << endl;
}

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    qInstallMessageHandler(customMessageHandler);

    AccessibilityProxy prox;
    qDBusRegisterMetaType<QRect>();
    qDBusRegisterMetaType<QList<QRect> >();
    new AccessibilityProxyAdapter(&prox);
    QDBusConnection::sessionBus().registerObject("/ca/thume/uiscope/accessibilityproxy", &prox);

    if(!QDBusConnection::sessionBus().registerService("ca.thume.uiscope")) {
        qDebug() << "Couldn't grab DBus service.";
        exit(0);
    }

    DebugWindow w(&prox);
    w.show();

    return a.exec();
}
