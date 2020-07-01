#ifndef DISCUSS_H
#define DISCUSS_H

#include <QObject>

#include <QCoreApplication>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlTableModel>
#include <QSqlError>
#include <QDebug>
#include <QSqlQuery>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <vector>

using namespace std;

class Discuss : public QObject{

    Q_OBJECT
public:
    Discuss(QGuiApplication &app, QQmlApplicationEngine &engine);
    ~Discuss();
    Q_INVOKABLE void danMu(QString comment);
    Q_INVOKABLE QString getDanMu();
    Q_INVOKABLE int getDanMuCount();
    Q_INVOKABLE void setId(int id);
    Q_INVOKABLE void setName(QString name);
    Q_INVOKABLE void setComments(QString comments);
    Q_INVOKABLE QString getComments();
    Q_INVOKABLE int getCommentsCount();
    Q_INVOKABLE QString getName();
    Q_INVOKABLE QString getAvatar();

    vector<int> getId();

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
    int m_id;
    QString m_name;
    QString m_avatar;

};

#endif // DISCUSS_H
