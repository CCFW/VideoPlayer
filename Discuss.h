#ifndef MYSQL_H
#define MYSQL_H

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

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // MYSQL_H
