#ifndef FFMPEGDECODING_H
#define FFMPEGDECODING_H

#include <QObject>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

class FfmpegDecoding : public QObject
{
    Q_OBJECT

//    Q_PROPERTY(int source);

public:
    FfmpegDecoding();
//    FfmpegDecoding(QGuiApplication &app, QQmlApplicationEngine &engine);
    Q_INVOKABLE int ffmpeg1();
    ~FfmpegDecoding();

private:
//    QGuiApplication *m_app;
//    QQmlApplicationEngine *m_engine;
};
#endif // FFMPEGDECODING_H
