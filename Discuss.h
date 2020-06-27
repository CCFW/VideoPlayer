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

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
    int m_id;
};

#endif // DISCUSS_H
