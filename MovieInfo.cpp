#include "MovieInfo.h"
#include <typeinfo>

using namespace std;

MovieInfo::MovieInfo(QGuiApplication &app, QQmlApplicationEngine &engine){
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

void MovieInfo::introduce(){
    int id = 0;
    QSqlQuery sql;
    vector<QString> string;



    string.push_back("机械画皮");
    string.push_back("哪吒之魔童降世");
    string.push_back("战狼2");
    string.push_back("夏洛特烦恼");
    string.push_back("红海行动");
    string.push_back("唐人街探案2");
    string.push_back("机械画皮");
    string.push_back("哪吒之魔童降世");
    string.push_back("战狼2");
    string.push_back("夏洛特烦恼");
    string.push_back("红海行动");
    string.push_back("唐人街探案2");
    for (int i = 0;i<string.size();i++) {
        qDebug()<<string[i];
        qDebug()<< i;
        QString str = QString("insert into MovieInfo(ve_id,ve_title) values('%1','%2')").arg(i+1).arg(string[i]);
        sql.exec(str);

    }
}

QString MovieInfo::getIntroduce(){



    vector<QString>temp;
    QSqlQuery sqlQuery;
    QString strql1 = "select ve_title from MovieInfo";
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

MovieInfo::~MovieInfo(){

}
