#include "VideoInfo.h"
#include <typeinfo>

using namespace std;

VideoInfo::VideoInfo(QGuiApplication &app, QQmlApplicationEngine &engine){
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");
    db.setHostName("localhost");
    db.setUserName("root");
    db.setPassword("mysql");
    db.setDatabaseName("VideoPlayer");

    if(true == db.open())
    {
        qDebug() << "success";
    }
    else {
        qDebug() << "failed";
        exit(0);
    }
    introduce();
    m_app = &app;
    m_engine = &engine;
}

void VideoInfo::introduce(){
    int id = 0;
    QSqlQuery sql;
    vector<QString> string;



    string.push_back("月上重火");
    string.push_back("隐秘的角落");
    string.push_back("怪你过分美丽");
    string.push_back("传闻中的陈芊芊");
    string.push_back("美人为陷");
    string.push_back("幸福，触手可及！");
    for (int i = 0;i<string.size();i++)
        for (int i = 0;i<string.size();i++) {
            //        qDebug()<<string[i];
            //        qDebug()<< i;
            QString str = QString("insert into VideoInfo(ve_id,ve_title) values('%1','%2')").arg(i+1).arg(string[i]);
            sql.exec(str);

        }
}

QString VideoInfo::getIntroduce(){



    vector<QString>temp;
    QSqlQuery sqlQuery;
    QString strql1 = "select ve_title from VideoInfo";
    sqlQuery.exec(strql1);

    while(sqlQuery.next()){
        temp.push_back(sqlQuery.value(0).toString());

    }
    static int count = -1;
    //    qDebug() <<temp;

    count = count + 1;

    //    qDebug() << count;
    //    qDebug() <<temp[count];

    return temp[count];
}

VideoInfo::~VideoInfo(){

}
