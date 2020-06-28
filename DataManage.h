#ifndef DATAMANAGE_H
#define DATAMANAGE_H

#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QMessageBox>
#include <QSqlQuery>

#include <string>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <vector>
class DataManage:public QObject{
    Q_OBJECT
public:
    DataManage(QGuiApplication &app,QQmlApplicationEngine &engine);
    DataManage();
    ~DataManage();
    void InsertInfo1();
//    void InsertInfo2();
    void queryInfo(QString num);

    Q_INVOKABLE std::vector<QString> getName(){return m_name;}
    Q_INVOKABLE std::vector<QString> getDirector(){return m_director;}
    Q_INVOKABLE std::vector<QString> getIntroduce(){return m_introduce;}
    Q_INVOKABLE std::vector<QString> getRole(){return m_role;}
    Q_INVOKABLE std::vector<int> getEpisodes(){return m_episodes;}
    Q_INVOKABLE int setKey(QString key);
    Q_INVOKABLE std::vector<QString> getmoveImage(){return m_moveImage;}

//    Q_INVOKABLE void write(QJsonObject &json);
    void setName(QString name){m_name.push_back(name);}
    void setDirector(QString director){m_director.push_back(director);}
    void setIntroduce(QString introduce){m_introduce.push_back(introduce);}
    void setRole(QString role){m_role.push_back(role);}
    void setEpisodes(int episodes){m_episodes.push_back(episodes);}
    void setmoveImage(QString moveImage){m_moveImage.push_back(moveImage);}

    Q_INVOKABLE void clearVector(){
        m_name.clear();
        m_director.clear();
        m_introduce.clear();
        m_role.clear();
        m_episodes.clear();
        m_moveImage.clear();
    }

private:
    QString m_key;
    std::vector<QString> m_name;
    std::vector<QString> m_director;
    std::vector<QString> m_introduce;
    std::vector<QString> m_moveImage;
    std::vector<QString> m_role;
    std::vector<int> m_episodes;
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};
#endif // DATAMANAGE_H
