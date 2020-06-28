#include <QApplication>
#include <FelgoApplication>
#include <QQmlApplicationEngine>
#include "MoveDB.h"

#include <QQmlContext>
// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
    FelgoApplication felgo;

    felgo.initialize(&engine);


    MoveDB dataManage(app,engine);
    engine.rootContext()->setContextProperty("dataManage",&dataManage);



    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);



    felgo.setPreservePlatformFonts(true);

    engine.load(QUrl(felgo.mainQmlFileName()));
    return app.exec();
}
