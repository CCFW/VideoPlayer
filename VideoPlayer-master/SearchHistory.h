#ifndef SEARCHHISTORY_H
#define SEARCHHISTORY_H

#include <QtSql/QSqlDatabase>
#include <QDebug>
#include <QSqlQuery>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

class SearchHistory:public QObject{
Q_OBJECT

public:
    SearchHistory(QGuiApplication &app,QQmlApplicationEngine &engine);
//    SearchHistory();
//    ~SearchHistory();

//    void SearchHistoryIn();
//    void queryKey();
//    QString getKey(){return m_key;}
//    Q_INVOKABLE QString getQKey(){return m_qmlkey;}
//    Q_INVOKABLE void printa(){qDebug()<<"bunengyonga";}

//    Q_INVOKABLE void setKey(QString key);

//    void setQkey(QString Qkey){m_qmlkey=Qkey;}
//     Q_INVOKABLE int setKey(QString key);
//signals:
//    void begin();
private:
QString m_key;
//    QString m_qmlkey;
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;


};

#endif // SEARCHHISTORY_H
