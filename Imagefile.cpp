#include "Imagefile.h"

Imagefile::Imagefile(QWidget *parent) :
    QDialog(parent)
{
    m_imagepath = "";
}

Imagefile::~Imagefile(){

}

QString Imagefile::getimagepath()
{
    setimagepath();
    return m_imagepath;
}

void Imagefile::setimagepath()
{


    QString imagepath = QFileDialog::getOpenFileName(
                this,
                "Please select yours avatar ",
                "../root/",
                "Images (*.png *.xpm *.jpg)");
    m_imagepath = imagepath;

}
