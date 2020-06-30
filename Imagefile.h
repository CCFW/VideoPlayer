#ifndef IMAGEFILE_H
#define IMAGEFILE_H

#include <QDialog>
#include <QFileDialog>
class Imagefile: public QDialog{
    Q_OBJECT
public:
    Imagefile(QWidget *parent = nullptr);
    ~Imagefile();

    QString getimagepath();
    void setimagepath();
private:
    QString m_imagepath;
};

#endif // IMAGEFILE_H
