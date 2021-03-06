#ifndef VIDEO_H
#define VIDEO_H

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

class VideoInfo : public QObject{
    Q_OBJECT
public:
    VideoInfo(QGuiApplication &app, QQmlApplicationEngine &engine);
    ~VideoInfo();
    Q_INVOKABLE void introduce();
    Q_INVOKABLE QString getIntroduce();

private:
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // VIDEO_H
