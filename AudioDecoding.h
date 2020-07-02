#ifndef AUDIODECODING_H
#define AUDIODECODING_H

#include <QObject>

class AudioDecoding : public QObject
{
    Q_OBJECT

public:
    AudioDecoding();
    Q_INVOKABLE int audioDecoding();

//    void  fill_audio(void *udata,Uint8 *stream,int len);
    ~AudioDecoding();

};

#endif // AUDIODECODING_H
