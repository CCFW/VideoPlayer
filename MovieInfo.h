#ifndef MOVIEINFO_H
#define MOVIEINFO_H

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

class MovieInfo : public QObject{
    Q_OBJECT
public:
    MovieInfo(QGuiApplication &app, QQmlApplicationEngine &engine);
    ~MovieInfo();
    Q_INVOKABLE void introduce();
    Q_INVOKABLE QString getIntroduce();

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // MOVIEINFO_H
