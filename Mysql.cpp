#include "Mysql.h"

Mysql::Mysql()
{

    //创建连接
    QSqlDatabase db ;
    if(QSqlDatabase::contains("qt_sql_default_connection"))
        db = QSqlDatabase::database("qt_sql_default_connection");
    else
        db = QSqlDatabase::addDatabase("QMYSQL");

    db.setHostName("localhost");
    db.setUserName("root");
    db.setPassword("root");
    db.setDatabaseName("VideoPlayer");
    if(!db.open()){
        qDebug()<<"failed";
    }else {
        qDebug()<<"successed";

    }
}
