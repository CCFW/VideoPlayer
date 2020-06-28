#include <QApplication>
#include <FelgoApplication>
#include <QQmlApplicationEngine>
#include "Mysql.h"
#include "SearchHistory.h"

#include <QQmlContext>
#include "Cmodel.h"
// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;
        FelgoApplication felgo;

    felgo.initialize(&engine);


    Mysql dataManage(app,engine);
//    MoveModel model;
//    model.append("heoo","woefd");
//    engine.rootContext()->setContextProperty("move",&model);
engine.rootContext()->setContextProperty("dataManage",&dataManage);
//    SearchHistory searchHistory(app,engine);
//    engine.rootContext()->setContextProperty("searchHistory",&searchHistory);



     felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));
    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);



    felgo.setPreservePlatformFonts(true);

    engine.load(QUrl(felgo.mainQmlFileName()));

    return app.exec();
}
