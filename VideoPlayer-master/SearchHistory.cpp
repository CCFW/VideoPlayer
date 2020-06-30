#include "SearchHistory.h"
#include "Mysql.h"
//SearchHistory::SearchHistory()
//{}
//SearchHistory::~SearchHistory()
//{}
//SearchHistory::SearchHistory(QGuiApplication &app,QQmlApplicationEngine &engine)
//{
////    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

////    db.setHostName("localhost");  //database ip address
////    db.setUserName("root");   //database username
////    db.setPassword("mysql");   //database password
////    db.setDatabaseName("VideoPlayer");     //database table name
////    db.open();
////    QSqlQuery query;
////    if (!db.open())
////    {
////        qDebug() << "failed";
////    }
////    else
////    {
////        qDebug() << "succed";

////        query.exec("drop table VedioInfo");


////    }
//    m_engine = &engine;
//    m_app = &app;
//}
//int SearchHistory::setKey(QString key)
//{
//    m_key=key;
//    QSqlQuery query;
////    QString str1=QString("select * from VedioInfo0 where ve_name='%1'").arg(m_key);
////    query.exec(str1);
////    if(query.isValid()==false){
////        qDebug()<<"shibai1";
////        QString str2=QString("select * from VedioInfo1 where ve_name='%1'").arg(m_key);
////        query.exec(str2);
////        if(query.isValid()==false){
////            qDebug()<<"shibai2";
////        }else {
////            queryInfo("VedioInfo1");
////            qDebug()<<"2---------------";
////}
////    }else{
////        qDebug()<<query.value(1).toString();
////        queryInfo("VedioInfo0");
////        qDebug()<<"1---------------";
////        qDebug()<<query.exec(str1);
////    }
//    Mysql mysql;
//    mysql.queryInfo("VedioInfo0");
//    for(int i=0; i<mysql.getName().size();i++){
//        if(m_key==mysql.getName()[i]){
//            begin();
//            return 0;
//        }else{
//            mysql.clearVector();
//            mysql.queryInfo("VedioInfo1");
//            for(int i=0; i<mysql.getName().size();i++){
//                if(m_key==mysql.getName()[i]){
//                     begin();
//                    return 1;
//                }else{
//                    return -1;
//                }
//        }
//    }

//}
//}
//void SearchHistory::SearchHistoryIn()
//{
//    QSqlQuery query;
//    qDebug() << "fnu9difjqao";
//    qDebug()<<m_key;
//    query.exec("create table SearchHistory(search_id int primary key auto_increment, ve_key varchar(255))");
//    query.prepare("insert into SearchHistory(ve_key) values(:key)");

//    QVariantList ve_keyList;

//    ve_keyList<<m_key;
//    qDebug()<<m_key;
//    query.bindValue(":key",ve_keyList);
//    query.execBatch();
//}
//void SearchHistory::queryKey()
//{
//    QSqlQuery query;
//    query.exec("select * from SearchHistory");
//    while (query.next()) {
//        if(m_key==query.value(1).toString()){
//            qDebug()<<query.value(1).toString();
//            setQkey(query.value(1).toString());
//        }

//    }
////    Mysql mysql;
////    mysql.QueryInfo(query);


//}
//void SearchHistory::setKey(QString key)
//{
//    m_key=key;
//    qDebug()<<m_key;
//    QSqlQuery query;
//Mysql mysql;
//    QString str1=QString("select * from VedioInfo0 where ve_name='%1'").arg(m_key);
//    if(query.exec(str1)==false){
//        qDebug()<<"shibai1";
//        QString str1=QString("select * from VedioInfo1 where ve_name='%1'").arg(m_key);
//        if(query.exec()==false){
//            qDebug()<<"shibai2";
//        }else {
//            mysql.queryInfo("VedioInfo1");
//}
//    }else{
//        mysql.queryInfo("VedioInfo0");
//    }

//}
