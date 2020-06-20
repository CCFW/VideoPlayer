#ifndef MYSQL_H
#define MYSQL_H

#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QMessageBox>
#include <QSqlQuery>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <vector>
#include <QFileDialog>
#include <QBuffer>
#include "Imagefile.h"
class Mysql: public QObject
{
    Q_OBJECT
public:
    Mysql(QGuiApplication& app, QQmlApplicationEngine &engine);
    void setid(int id);
    void setname(QString name);
    void setpassword(QString password);
    void setaccount(int account);
    void setavatar(QString avatar);
    void sethistory(QString history);
    void setdownload(QString download);
    ~Mysql();
    Q_INVOKABLE int loginvefied(QString account,QString password);
    Q_INVOKABLE int registersave(QString name,QString password1,QString password2);
    Q_INVOKABLE void exitlogin();
    Q_INVOKABLE int informationmadofy(QString name,QString oldpassword,QString newpassword1,QString newpassword2);
    Q_INVOKABLE void getavatorpath();

    Q_INVOKABLE int getid();
    Q_INVOKABLE QString getname();
    Q_INVOKABLE QString getpassword();
    Q_INVOKABLE int getaccount();
    Q_INVOKABLE QString getavatar();
    Q_INVOKABLE QString gethistory();
    Q_INVOKABLE QString getdownload();
    Q_INVOKABLE QString gettempavatar();
private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
    int m_id;
    QString m_name;
    QString m_password;
    int m_account;
    QString m_avatar;
    QString temp_avatar;
    QString m_history;
    QString m_download;
};

#endif // MYSQL_H
