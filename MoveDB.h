#ifndef MOVEDB_H
#define MOVEDB_H

#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QMessageBox>
#include <QSqlQuery>

#include <string>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <vector>

class MoveDB:public QObject{
    Q_OBJECT
public:
    MoveDB(QGuiApplication &app,QQmlApplicationEngine &engine);
    ~MoveDB();

    void InsertInfo1();
    Q_INVOKABLE void queryInfo();

    Q_INVOKABLE std::vector<QString> getName(){return m_name;}
    Q_INVOKABLE std::vector<QString> getDirector(){return m_director;}
    Q_INVOKABLE std::vector<QString> getIntroduce(){return m_introduce;}
    Q_INVOKABLE std::vector<QString> getRole(){return m_role;}
    Q_INVOKABLE std::vector<int> getEpisodes(){return m_episodes;}
    Q_INVOKABLE int setKey(QString key);
    Q_INVOKABLE std::vector<QString> getmoveImage(){return m_moveImage;}
    Q_INVOKABLE std::vector<int> getTime(){return m_time;}

    void setName(QString name){m_name.push_back(name);}
    void setDirector(QString director){m_director.push_back(director);}
    void setIntroduce(QString introduce){m_introduce.push_back(introduce);}
    void setRole(QString role){m_role.push_back(role);}
    void setEpisodes(int episodes){m_episodes.push_back(episodes);}
    void setmoveImage(QString moveImage){m_moveImage.push_back(moveImage);}
    void setTime(int time){m_time.push_back(time);}

    Q_INVOKABLE void clearVector(){
        m_name.clear();
        m_director.clear();
        m_introduce.clear();
        m_role.clear();
        m_episodes.clear();
        m_moveImage.clear();
        m_time.clear();
    }

private:
    QString m_key;
    std::vector<QString> m_name;
    std::vector<QString> m_director;
    std::vector<QString> m_introduce;
    std::vector<QString> m_moveImage;
    std::vector<QString> m_role;
    std::vector<int> m_episodes;
    std::vector<int> m_time;
    QString m_timeSearch;
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};
#endif // DATAMANAGE_H

