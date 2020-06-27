#include "Discuss.h"
#include "Mysql.h"
#include <typeinfo>
using namespace std;
//#define MIN 0
//#define MAX 9

Discuss::Discuss(QGuiApplication &app, QQmlApplicationEngine &engine){
    
    //    //创建连接
    //    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL"); //database driver
    //    db.setHostName("localhost");  //database ip address
    //    db.setUserName("root");   //database username
    //    db.setPassword("root");   //database password
    //    db.setDatabaseName("VideoPlayer");     //database table name
    //    if (true == db.open())
    //    {
    //        qDebug() << "successed";
    //    }
    //    else
    //    {
    //        qDebug() << "failed";
    //        exit(0);
    //    }
    
    m_app = &app;
    m_engine = &engine;
    m_id = 0;
}

void Discuss::danMu(QString comment){
    //    srand((unsigned) time(NULL));
    //    int rand_id = MIN + (rand()%(MAX-MIN+1));
    //    qDebug() << rand_id;
    int id = 0;
    
    vector<int>temp;
    QSqlQuery sqlQuery;
    QString strql1 = "select d_id from Discuss";
    sqlQuery.exec(strql1);
    
    //查找discuss数据表当前d_id的最大值
    while(sqlQuery.next()){
        id = sqlQuery.value(0).toInt();
        temp.push_back(sqlQuery.value(0).toInt());
    }
    for(auto i:temp){
        if(i>id){
            id = i;
        }
    }
    //加1为下一位d_id的值
    id = id + 1;
    //    qDebug() << comment;
    QSqlQuery ql;
    
    int u_id = m_id;
    //    id = id + 1;
    qDebug() << id;
    qDebug() << u_id;
    qDebug() << "comment:"+comment;
    QString strql = QString("insert into Discuss(d_id,u_id, d_danMu) values('%1','%2','%3')").arg(id).arg(u_id).arg(comment);
    ql.exec(strql);
}

//获取弹幕内容
QString Discuss::getDanMu(){
    
    //    QString arr;
    
    QSqlQuery sqlQuery;
    QString strql1 = "select d_danMu from Discuss";
    sqlQuery.exec(strql1);
    
    vector<QString> arr1;
    while (sqlQuery.next()) {
        arr1.push_back(sqlQuery.value(0).toString());
    }
    //    qDebug() << arr1.size();
    
    static int i = -1;
    //    qDebug() << i;
    i = i + 1;
    //    qDebug() << i;
    //    qDebug() << "vdscvvsd"+arr1[i];
    
    return arr1[i];
    
}

//获取弹幕数量
int Discuss::getDanMuCount(){
    
    QSqlQuery sqlQuery;
    QString strql1 = "select d_danMu from Discuss";
    sqlQuery.exec(strql1);
    
    int count = 0;
    while (sqlQuery.next()) {
        count ++;
    }
    //    qDebug() << count;
    return count;
}

void Discuss::setId(int id)
{
    m_id = id;
}

Discuss::~Discuss(){
    
}
