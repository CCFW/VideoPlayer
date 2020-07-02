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

    void settitle(QString title);
    void setdirector(QString director);
    void setintroduce(QString introduce);
    void setrole(QString role);
    void setportrait(QString portrait);
    ~Mysql();
    Q_INVOKABLE int loginvefied(QString account,QString password);
    Q_INVOKABLE int registersave(QString name,QString password1,QString password2);
    Q_INVOKABLE void exitlogin();
    Q_INVOKABLE int informationmadofy(QString name,QString oldpassword,QString newpassword1,QString newpassword2);
    Q_INVOKABLE void getavatorpath();
    Q_INVOKABLE int historysave(QString history);
    Q_INVOKABLE int getid();
    Q_INVOKABLE QString getname();
    Q_INVOKABLE QString getpassword();
    Q_INVOKABLE int getaccount();
    Q_INVOKABLE QString getavatar();
    Q_INVOKABLE QString gethistory();
    Q_INVOKABLE QString getdownload();
    Q_INVOKABLE QString gettempavatar();
    Q_INVOKABLE void gethistroys();

    Q_INVOKABLE std::vector<QString> gettileName(){return m_title;}
    Q_INVOKABLE std::vector<QString> getDirector(){return m_director;}
    Q_INVOKABLE std::vector<QString> getIntroduce(){return m_introduce;}
    Q_INVOKABLE std::vector<QString> getRole(){return m_role;}
    Q_INVOKABLE std::vector<QString>getEpisodes(){return m_portrait;}

    Q_INVOKABLE void clearVector(){
        m_title.clear();
        m_director.clear();
        m_introduce.clear();
        m_role.clear();
        m_portrait.clear();
    }
private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
    int m_id;
    int ve_id;
    QString m_name;
    QString m_password;
    int m_account;
    QString m_avatar;
    QString temp_avatar;
    QString m_history;
    QString m_download;
    std::vector<QString> m_title;
    std::vector<QString> m_director;
    std::vector<QString> m_introduce;
    std::vector<QString> m_role;
    std::vector<QString> m_portrait;

};

#endif // MYSQL_H
