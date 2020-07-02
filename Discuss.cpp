#include "Discuss.h"
#include "Mysql.h"
#include <typeinfo>
#include <iostream>
//using namespace std;

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
    m_name = "";
    m_avatar = "";
    m_vename = "";


}

void Discuss::danMu(QString comment){
    //    srand((unsigned) time(NULL));
    //    int rand_id = MIN + (rand()%(MAX-MIN+1));
    //    qDebug() << rand_id;
    int id = 0;
    
    std::vector<int>temp;

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
    QString u_name = m_name;
    //    id = id + 1;
//    qDebug() << id;
//    qDebug() << u_id;
//    qDebug() << "d_danMu:"+comment;
//    qDebug() << "u_name:"+u_name;
    QString strql = QString("insert into Discuss(d_id,u_id,ve_name,d_danMu,u_name) values('%1','%2','%3','%4','%5')").arg(id).arg(u_id).arg(m_vename).arg(comment).arg(u_name);

    ql.exec(strql);
}

//获取弹幕内容
std::vector<QString>  Discuss::getDanMu(){
    
    //    QString arr;
    
    qDebug() <<"m_vename :"+m_vename;
    QSqlQuery sqlQuery;
    QString strql1 = QString("select d_danMu from Discuss where ve_name = '%1'").arg(m_vename);
    sqlQuery.exec(strql1);
    
    std::vector<QString> arr1={};
    while (sqlQuery.next()) {
//        qDebug() <<"value :"+sqlQuery.value(0).toString();
        if(sqlQuery.value(0).toString() != ""){
            qDebug() << sqlQuery.value(0).toString();
            arr1.push_back(sqlQuery.value(0).toString());
        }

    }
    //    qDebug() << arr1.size();
//        qDebug() << "vdscvvsd";
//    static int i = -1;

    //    qDebug() << i;
//    i = i + 1;

//        cout<<"i:" <<  i;
//    qDebug()<<i;
//        qDebug() << "vdscvvsd"+arr1[i];
    
    return arr1;
//    m_vename = "";
}

//获取弹幕数量
int Discuss::getDanMuCount(){
    
    QSqlQuery sqlQuery;
    QString strql1 = QString("select d_danMu from Discuss where ve_name = '%1'").arg(m_vename);

    sqlQuery.exec(strql1);
    
    int count = 0;
    while (sqlQuery.next()) {
        if(sqlQuery.value(0).toString() != ""){
            count ++;
        }

    }
        qDebug() << count;

    return count;
}

void Discuss::setId(int id)
{
    m_id = id;
}

void Discuss::setName(QString name)
{
    m_name = name;
}

void Discuss::setComments(QString comments)
{
//    qDebug() << "comments: " + comments;
    QSqlQuery sqlQuery;
    QString strql = "select d_id from Discuss";
    sqlQuery.exec(strql);

    int id = 0;
    std::vector<int>temp;

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
//    qDebug() << id;
//    qDebug() << m_id;
//    qDebug() << "d_comment:"+comments;
//    qDebug() << "u_name:"+m_name;

    int u_id = m_id;
    QString u_name = m_name;

    QSqlQuery ql;
    QString strql1 = QString("insert into Discuss(d_id,u_id,ve_name,d_comment,u_name) values('%1','%2','%3','%4','%5')").arg(id).arg(u_id).arg(m_vename).arg(comments).arg(u_name);

    ql.exec(strql1);

}

//获取所有的评论
std::vector<QString> Discuss::getComments()
{
    QSqlQuery sqlQuery;
    QString strql1 = QString("select d_comment from Discuss where ve_name = '%1'").arg(m_vename);
    sqlQuery.exec(strql1);

    std::vector<QString> arr1;
    while (sqlQuery.next()) {
        if(sqlQuery.value(0).toString() != ""){
            arr1.push_back(sqlQuery.value(0).toString());
//            qDebug() << sqlQuery.value(0).toString();
        }
    }

//    qDebug() << arr1.size();

//    static int i = -1;
//    i = i + 1;


    return arr1;

//    m_vename = "";

}

//获取评论的总数量
int Discuss::getCommentsCount()
{
    QSqlQuery sqlQuery;
    QString strql1 = QString("select d_comment from Discuss where ve_name = '%1'").arg(m_vename);
    sqlQuery.exec(strql1);

    int count = 0;
    while (sqlQuery.next()) {
        if(sqlQuery.value(0).toString() != ""){
            count ++;
        }
    }
    //    qDebug() << count;
    return count;
}

//获取所有评论过的昵称
std::vector<QString> Discuss::getName()
{
    QSqlQuery sqlQuery;
    QString strql1 = QString("select d_comment, u_name from Discuss where ve_name = '%1'").arg(m_vename);
    sqlQuery.exec(strql1);

    std::vector<QString> arr1;

    while (sqlQuery.next()) {
        if(sqlQuery.value(0).toString() != ""){
            arr1.push_back(sqlQuery.value(1).toString());
//            qDebug() << sqlQuery.value(1).toString();
        }

    }

//    qDebug() << arr1.size();

//    static int i = -1;
//    i = i + 1;


    return arr1;
}

//根据Discuss表中用户的ID去User表中找该用户的头像
std::vector<QString> Discuss::getAvatar()
{
    std::vector<QString> arr1;

    std::vector<int> arr = getId();
//    qDebug() << arr;

    QSqlQuery sqlQuery;
    QString strql1 = "select u_account,u_avatar from User";
    sqlQuery.exec(strql1);

    for (int i = 0; i < arr.size(); i++) {
        while (sqlQuery.next()) {
            if(sqlQuery.value(0).toInt() == arr[i]){
                arr1.push_back(sqlQuery.value(1).toString());
//                qDebug() << sqlQuery.value(1).toString();
                break;
            }
        }
        //找下一个用户头像时重新执行User表中选择的语句
        sqlQuery.exec(strql1);
    }

//    static int i = -1;
//    i = i + 1;


    return arr1;

}

void Discuss::setVeName(QString vename)
{
    m_vename = vename;
//    qDebug()<<"m_vename :"+m_vename;

}


//在Discuss表中获取每一个评论用户的ID
std::vector<int> Discuss::getId()

{
    QSqlQuery sqlQuery;
    QString strql1 = "select u_id,d_comment from Discuss";
    sqlQuery.exec(strql1);

    std::vector<int> arr1;

    while (sqlQuery.next()) {
        //找到评论内容不为空的用户ID
        if(sqlQuery.value(1).toString() != ""){
            arr1.push_back(sqlQuery.value(0).toInt());
//            qDebug() << sqlQuery.value(0).toInt();
        }
    }
    return arr1;
}

Discuss::~Discuss(){
    
}
