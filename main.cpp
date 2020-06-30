#include <QApplication>
#include <FelgoApplication>

#include <QQmlContext>
#include <QQmlApplicationEngine>
#include "MoveDB.h"
#include "Mysql.h"
#include "Discuss.h"
#include "VideoInfo.h"

#include "HistorySearchModel.h"
//#include "FfmpegDecoding.h"


// uncomment this line to add the Live Client Module and use live reloading with your custom C++ code
//#include <FelgoLiveClient>


int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    FelgoApplication felgo;
//    qmlRegisterType<FfmpegDecoding>("FfmpegDecoding",1,0,"FfmpegDecoding");
    felgo.setPreservePlatformFonts(true);
    QQmlApplicationEngine engine;
    felgo.initialize(&engine);

    MoveDB dataManage(app,engine);
  engine.rootContext()->setContextProperty("dataManage",&dataManage);


  HistorySearchModel historySearch(app,engine);
  engine.rootContext()->setContextProperty("myModel",&historySearch);


    Mysql sql(app,engine);
    engine.rootContext()->setContextProperty("sql",&sql);

    Discuss danMuSql(app, engine);
    engine.rootContext()->setContextProperty("danMuSql",&danMuSql);

    VideoInfo introduceSql(app,engine);
    engine.rootContext()->setContextProperty("introduceSql",&introduceSql);

    felgo.setLicenseKey(PRODUCT_LICENSE_KEY);
    felgo.setMainQmlFileName(QStringLiteral("qml/Main.qml"));


    engine.load(QUrl(felgo.mainQmlFileName()));
    return app.exec();
}
