#include "Mysql.h"
#include <typeinfo>
#define MIN 10000
#define MAX 100000
using namespace std;
Mysql::Mysql(QGuiApplication& app, QQmlApplicationEngine &engine)
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
    m_id = 0;
    m_name = "请登录";
    m_password = "";
    m_account = 0;
    m_avatar = "";
    m_history = "";
    m_download = "";
    temp_avatar = "";
    m_app = &app;
    m_engine = &engine;
}

void Mysql::setid(int id)
{
    m_id = id;
}

void Mysql::setname(QString name)
{
    m_name = name;
}

void Mysql::setpassword(QString password)
{
    m_password = password;
}

void Mysql::setaccount(int account)
{
    m_account = account;
}

void Mysql::setavatar(QString avatar)
{
    m_avatar = avatar;
}

void Mysql::sethistory(QString history)
{
    m_history = history;
}

void Mysql::setdownload(QString download)
{
    m_download = download;
}
int Mysql::loginvefied(QString account,QString password)
{
    qDebug() << account;
    qDebug() << password;

    if(account == "" || password == ""){
        return 3;
    }
    QSqlQuery ql;
    QString strql = QString("select * from User where u_account = '%1'").arg(account);
    ql.exec(strql);
    if(ql.next()){
        if(ql.value(2).toString() == password){
            qDebug() << "登录成功";
            setid(ql.value(0).toInt());
            setname(ql.value(1).toString());
            setpassword(ql.value(2).toString());
            setaccount(ql.value(3).toInt());
            setavatar(ql.value(4).toString());
            sethistory(ql.value(5).toString());
            setdownload(ql.value(6).toString());

            //            qDebug() <<m_id;
            qDebug() <<"name = " +m_name;
            //            qDebug() <<"password = " +m_password;
            //            qDebug() <<m_account;
            //            qDebug() <<"avatar = " +m_avatar;
            //            qDebug() <<"history = " +m_history;
            //            qDebug() <<"download = " +m_download;
            return 1;
        }
        else{
            qDebug() << "密码错误";
            return 0;
        }
        //            }
    }else {
        qDebug() << "未有帐号，请先注册";
        return 2;
    }

}

int Mysql::registersave(QString name, QString password1, QString password2)
{

    //    int account = MIN+ (rand()%(MAX-MIN));

    //    qDebug() << account;
    qDebug() << name;
    qDebug() << password1;
    qDebug() << password2;
    QSqlQuery ql;

    QString strql = "select u_account from User";
    ql.exec(strql);

    QSqlQuery ql1;
    QString strql1 = QString("select * from User where u_name = '%1'").arg(name);
    ql1.exec(strql1);

    if(name == "" || password1 == "" || password2 == "")
    {
        return 0;
    }
    else if (password1 != password2) {
        return 1;
    }
    else if(ql1.next()){
        return 2;
    }
    else{
        vector<int> temp;
        int id = 0;
        int account = 10000;
        strql = "select u_id from User";
        ql.exec(strql);
        while(ql.next()){
            id = ql.value(0).toInt();
            temp.push_back(ql.value(0).toInt());
        }
        for(auto i:temp){
            if(i>id){
                id = i;
            }
        }
        id = id + 1 ;

        QSqlQuery ql2;
        QString strql2 = "select u_account from User ";
        ql2.exec(strql2);
        while (ql2.next()) {
            account = ql2.value(0).toInt();
        }
        account = account + 1;
        //ON DUPLICATE KEY UPDATE u_id=u_id+1
        strql = QString("INSERT INTO User (u_id,u_name,u_password,u_account) VALUES ('%1','%2','%3','%4')").arg(id).arg(name).arg(password1).arg(account);

        ql.exec(strql);

        setid(id);
        setname(name);
        setpassword(password1);
        setaccount(account);

        //        qDebug() <<m_id;
        //        qDebug() <<"name = " +m_name;
        //        qDebug() <<"password = " +m_password;
        //        qDebug() <<m_account;
        return 3;
    }
}

void Mysql::exitlogin()
{
    m_id = 0;
    m_name = "请登录";
    m_password = "";
    m_account = 0;
    m_avatar = "";
    m_history = "";
    m_download = "";
    temp_avatar = "";

}

int Mysql::informationmadofy(QString name, QString oldpassword, QString newpassword1, QString newpassword2)
{
    //    QSqlQuery ql;
    //    QString strql = "select u_name from User ";
    //    ql.exec(strql);
    //    bool result = false;
    //    while (ql.next()) {
    //        if(ql.value(0).toString() == name){
    //            result = true;
    //        }
    //    }

    if( name == m_name && m_avatar == temp_avatar && (oldpassword == "" || newpassword1 == "" || newpassword2 == "")){
        return 0;
    }
    else if (newpassword1 != newpassword2 && newpassword1 != "" && newpassword2 != ""){
        return 1;
    }
    else if (oldpassword != getpassword() && oldpassword != ""){
        return 2;
    }
    else if(oldpassword == newpassword1 && oldpassword != "" && newpassword1 != ""){
        return 3;
    }
    else if(m_avatar != temp_avatar && m_name == name && (oldpassword == "" || newpassword1 == "" || newpassword2 == "")){
        QSqlQuery ql;
        QString avatarpath = temp_avatar;
        ql.prepare("update User set u_avatar = ? where u_id = ?");
        ql.addBindValue(avatarpath);
        ql.addBindValue(getid());
        ql.exec();
        setavatar(avatarpath);
        return 4;
    }
    else if(m_avatar != temp_avatar && m_name != name && (oldpassword == "" || newpassword1 == "" || newpassword2 == "")){
        QSqlQuery ql;
        QString avatarpath = temp_avatar;
        QString strql = QString("update User set u_name = '%1' where u_id = '%2'").arg(name).arg(getid());
        ql.exec(strql);
        ql.prepare("update User set u_avatar = ? where u_id = ?");
        ql.addBindValue(avatarpath);
        ql.addBindValue(getid());
        ql.exec();
        setavatar(avatarpath);
        setname(name);
        return 5;
    }
    else if(m_avatar == temp_avatar && m_name != name && (oldpassword == "" || newpassword1 == "" || newpassword2 == "")){
        QSqlQuery ql;
        QString strql = QString("update User set u_name = '%1'  where u_id = '%3'").arg(name).arg(getid());
        ql.exec(strql);
        setname(name);
        return 6;
    }
//    if(m_avatar != temp_avatar && m_name != name && oldpassword != "" && newpassword1 != "" && newpassword2 != "")
    else if(oldpassword != "" && newpassword1 != "" && newpassword2 != ""){
        QSqlQuery ql;
        setname(name);
        setpassword(newpassword1);
        QString avatarpath = temp_avatar;

        QByteArray data;
        QFile* file=new QFile(avatarpath); //fileName为二进制数据文件名
        file->open(QIODevice::ReadOnly);
        data = file->readAll();
        file->close();
        QVariant var(data);


        QString strql = QString("update User set u_name = '%1' ,u_password = '%2'  where u_id = '%3'").arg(name).arg(newpassword1).arg(getid());
        ql.exec(strql);

        //        QString strql1 = QString("update User set u_avatar = '%1' where u_id = '%3'").arg(var).arg(getid());
        //        ql.exec(strql1);
        //        QString strql1 = "update User set u_avatar = ? where u_id = ?";
        ql.prepare("update User set u_avatar = ? where u_id = ?");
        ql.addBindValue(avatarpath);
        ql.addBindValue(getid());
        ql.exec();
        setavatar(avatarpath);
        return 7;
    }
}

void Mysql::getavatorpath()
{
    Imagefile avatarpath;
    QString imagepath = avatarpath.getimagepath();
    qDebug()<<"imagepath : "+imagepath;
    temp_avatar = imagepath;
}

int Mysql::getid()
{
    return m_id;
}

QString Mysql::getname()
{
    return m_name;
}

QString Mysql::getpassword()
{
    return m_password;
}

int Mysql::getaccount()
{
    return m_account;
}

QString Mysql::getavatar()
{
    return m_avatar;
}

QString Mysql::gethistory()
{
    return m_history;
}

QString Mysql::getdownload()
{
    return m_download;
}

QString Mysql::gettempavatar()
{
    return temp_avatar;
}
Mysql::~Mysql(){

}
