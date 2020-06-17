#include <QApplication>
#include <FelgoApplication>
#include <QQmlApplicationEngine>
#include "Mysql.h"

// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    FelgoApplication felgo;
    felgo.setPreservePlatformFonts(true);
    QQmlApplicationEngine engine;
    felgo.initialize(&engine);
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));

    Mysql *sql = new Mysql();

    engine.load(QUrl(felgo.mainQmlFileName()));
    return app.exec();
}
