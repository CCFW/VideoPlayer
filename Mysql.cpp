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

    db.setPassword("mysql");

    db.setPassword("mysql");

    db.setDatabaseName("VideoPlayer");
    if(!db.open()){
        qDebug()<<"failed";
    }else {
        qDebug()<<"successed";

    }
    m_id = 0;
    ve_id = 0;
    m_name = "请登录";
    m_password = "";
    m_account = 0;
    m_avatar = "./../assets/touxiang.png";

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

void Mysql::settitle(QString title)
{
    m_title.push_back(title);
}

void Mysql::setdirector(QString director)
{
    m_director.push_back(director);
}

void Mysql::setintroduce(QString introduce)
{
    m_introduce.push_back(introduce);
}

void Mysql::setrole(QString role)
{
    m_role.push_back(role);
}

void Mysql::setportrait(QString portrait)
{
    m_portrait.push_back(portrait);
}
int Mysql::loginvefied(QString account,QString password)
{
//    qDebug() << account;
//    qDebug() << password;


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
            accounts.push_back(ql2.value(0).toInt());
        }
        for(auto i:accounts){
            if(i>account){
                account = i;
            }

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
    ve_id = 0;
    m_name = "请登录";
    m_password = "";
    m_account = 0;
    m_avatar = "../../assets/touxiang.png";
    m_history = "";
    m_download = "";
    temp_avatar = "";

}

int Mysql::informationmadofy(QString name, QString oldpassword, QString newpassword1, QString newpassword2)
{
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

        QString avatarpath = temp_avatar;
        //        QByteArray bytes;
        //        QBuffer buffer(&bytes);
        //        buffer.open(QIODevice::WriteOnly);
        //         pictureLabel->pixmap()->save(&buffer,"JPG");
        //        QByteArray data;
        //        QSqlQuery query;
        //        QString path = avatarpath;
        //        QFile* file=new QFile(path); //fileName为二进制数据文件名
        //        file->open(QIODevice::ReadOnly);
        //        data = file->readAll();
        //        file->close();
        //        //         std::QVariant
        //        QVariant var(data);

        //        //        QString sql = "insert into images(Image) values(?)";
        //        QString strQSL = QString("update User set u_avatar = ? where u_id = '%1'").arg(getid());
        //        query.prepare(strQSL);

        //        query.addBindValue(var);
        //        query.exec();


        //        //将照片以二进制流的方式存到数据库
        //        QPixmap pixmap(avatarpath);
        //        QByteArray byteArray = QByteArray();
        //        QBuffer buffer(&byteArray);
        //        buffer.open(QIODevice::WriteOnly);
        //        pixmap.save(&buffer,"png",0);
        //        //        QString str = QString("22");//图片ID
        //        //插入数据库 TEST_PIC为数据库表明  CONTENT为存储照片字段 为Blob类型
        //        QString strQSL = QString("update User set u_avatar = ? where u_id = '%1'").arg(getid());
        //        QSqlQuery query;
        //        query.prepare(strQSL);
        //        query.addBindValue(byteArray);
        //        qDebug()<<"byteArray :"+byteArray;
        //        query.exec();


        QSqlQuery ql;
        //        QString avatarpath = temp_avatar;
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
//    qDebug()<<"imagepath : "+imagepath;
    temp_avatar = imagepath;
}

int Mysql::historysave(QString history)
{

    int flag = 1;

    QSqlQuery ql;
    QString strql;

    strql = QString("select u_history from User where u_account = '%1'").arg(m_account);
    ql.exec(strql);
    while(ql.next()){
//        qDebug()<<"history : "+history;
//        qDebug()<<"value : "+ql.value(0).toString();
        if(ql.value(0).toString() == history){
            flag = 0;
        }
    }
    if(flag==1){
        vector<int> temp;
        int id = 0;
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

        strql = QString("INSERT INTO User (u_id,u_name,u_password,u_account,u_avatar,u_history) VALUES ('%1','%2','%3','%4','%5','%6')").arg(id).arg(m_name).arg(m_password).arg(m_account).arg(m_avatar).arg(history);
        ql.exec(strql);
    }

    return flag;
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

void Mysql::gethistroys()
{
    QSqlQuery ql;
    QString strql;
    strql = QString("select u_history from User where u_account = '%1'").arg(m_account);
    ql.exec(strql);
    while(ql.next()){
//        qDebug()<<ql.value(0).toString();
        QSqlQuery ql1;
      QString strql1 = QString("select * from VedioInfo0 where ve_name = '%1'").arg(ql.value(0).toString());
      ql1.exec(strql1);
      while(ql1.next()){
          settitle(ql1.value(1).toString());
          setdirector(ql1.value(2).toString());
          setintroduce(ql1.value(3).toString());
          setrole(ql1.value(4).toString());
          setportrait(ql1.value(6).toString());
      }
    }
}
Mysql::~Mysql(){

}
