#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <systeminfo.h>
#include <qquickwindow.h>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    app.setOrganizationName("AR productions");
    app.setOrganizationDomain("arproductions.com");
    app.setApplicationName("Incmi");
    QQmlApplicationEngine engine;
    SystemInfo info;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    QObject *item = (QObject *)engine.rootObjects().first();
    if (item) {
        item->setProperty("ipv4", info.ipAdress());
        item->setProperty("subnetmask", info.subnetMask());
    }
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
