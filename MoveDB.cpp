#include "MoveDB.h"
MoveDB::MoveDB(QGuiApplication &app,QQmlApplicationEngine &engine)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QMYSQL");

    db.setHostName("localhost");  //database ip address
    db.setUserName("root");   //database username
    db.setPassword("mysql");   //database password
    db.setDatabaseName("VideoPlayer");     //database table name
    db.open();
    QSqlQuery query;
    if (!db.open())
    {
        qDebug() << "failed";
    }
    else
    {
        qDebug() << "succed";
        query.exec("drop table VedioInfo0");
        InsertInfo1();
    }
    m_engine = &engine;
    m_app = &app;
}
void MoveDB::InsertInfo1(){
    QSqlQuery query;

    query.exec("create table VedioInfo0(chen_id int primary key auto_increment, ve_name varchar(255), ve_director varchar(255),introduce varchar(255), ve_role varchar(255),ve_episodes int, ve_image longblob, ve_time int,ve_source varchar(255))");

    query.prepare("insert into VedioInfo0(ve_name, ve_director,introduce, ve_role,ve_episodes,ve_image,ve_time,ve_source) values(:name, :director, :introduce, :role, :episodes,:moveimage,:time, :source)");
    QVariantList ve_nameList;
    ve_nameList << "传闻中的陈芊芊"<<"传闻中的陈芊芊片段1"<<"传闻中的陈芊芊片段2"<< "传闻中的陈芊芊2"<<"传闻中的陈芊芊片段3"<< "隐秘的角落"<<"《隐秘的角落》花絮：小演员们疯狂吐槽"<<"《隐秘的角落》花絮：哭到情绪崩溃是一种怎样的体验";

    QVariantList ve_directorList;
    ve_directorList << "查传谊"<< "用户分享"<< "用户分享"<<"查传谊1"<< "用户分享"<< "辛爽"<< "用户分享"<< "用户分享";

    QVariantList introduceList;
    introduceList <<"母胎单身七流编剧陈小千呕心沥血写了一部古装题材大剧，原可顺利开机，却因为演员韩明星对剧本感情戏质疑过多而崩盘。愤懑难平发誓要证明自己能力的她，意外卡进了自己的剧本，变身花垣城地位尊贵但恶.."<<"陈芊芊把字写好了，又叫梓锐拿着字去寻个裱糊匠裱起来，挂在了自己的案头。她把这个字理解成座右铭，又或者叫陈氏鸡汤。不管叫什么，总之她是抱定了一个想法..."<<"传闻中的陈芊芊： 韩烁伤透了心瞬间黑化，对芊芊不留情"<<"1111母胎单身七流编剧陈小千呕心沥血写了一部古装题材大剧，原可顺利开机，却因为演员韩明星对剧本感情戏质疑过多而崩盘。愤懑难平发誓要证明自己能力的她，意外卡进了自己的剧本，变身花垣城地位尊贵但恶.."<<"222陈芊芊把字写好了，又叫梓锐拿着字去寻个裱糊匠裱起来，挂在了自己的案头。她把这个字理解成座右铭，又或者叫陈氏鸡汤。不管叫什么，总之她是抱定了一个想法..."<<"讲述了沿海小城的三个孩子在景区游玩时无意拍摄记录了一次谋杀，他们的冒险也由此展开。扑朔迷离的案情，将几个家庭裹挟其中，带向不可预知的未来......"<<"少年严良为了找父亲，带着伙伴普普从孤儿院跑回宁市，找到自己儿时伙伴“好学生”..."<<" 结婚第四年，徐静有了外遇，并向张东升提出离婚。作为上门女婿入赘的张东升，婚前有过财产公证，一旦离婚，几乎是净身出户。左思右想之后，他决定做几件事改变这个结局...";

    QVariantList ve_roleList;
    ve_roleList <<"赵露思/丁禹兮/盛英豪/周紫馨"<<"赵露思/丁禹兮"<<"赵露思/丁禹兮"<<"赵露思/丁禹兮/盛英豪/周紫馨1"<<"赵露思/丁禹兮2"<<" 秦昊/王景春/荣梓杉/王圣迪"<<"秦昊/王景春"<<"秦昊/王景春";

    QVariantList ve_episodesList;
    ve_episodesList <<20<<0<<0<<20<<0<<20<<0<<0;

    QVariantList ve_imageList;
    for (int i=0;i<8;i++) {
        ve_imageList<<QString("../../assets/search/move%1.%2").arg(i).arg("jpg");
    }

    QVariantList ve_timeList;
    ve_timeList<<5<<20<<10<<800<<45<<800<<2<<45;

    QVariantList ve_sourceList;

    ve_sourceList<<"../../assets/video/vedio1.mp4"<<"../../assets/video/audio.mp4"<<"http://192.168.43.104/1.mp4"<<"http://192.168.43.104/2.mp4"<<"../../assets/video/vedio1.mp4"<<"../../assets/video/audio.mp4"<<"../../assets/video/vedio1.mp4"<<"../../assets/video/audio.mp4";

//    QVariantList moveImageList;
//    for (int i=0; i<2;i++) {

//       moveImageList<<"../../assets/move"QString(1)+".png";
//      qDebug()<<moveImageList[i];
//    }

    query.bindValue(":name",ve_nameList);
    query.bindValue(":director",ve_directorList);
    query.bindValue(":introduce",introduceList);
    query.bindValue(":role",ve_roleList);
    query.bindValue(":episodes",ve_episodesList);
    query.bindValue(":moveimage",ve_imageList);
    query.bindValue(":time",ve_timeList);
    query.bindValue(":source",ve_sourceList);

    query.execBatch();
}

void MoveDB::queryInfo()
{
    QSqlQuery query;
    QString str1=QString("select * from VedioInfo0 where ve_name like '%1'").arg('%'+m_timeSearch+'%');
    query.exec(str1);
    while (query.next()) {
        setName(query.value(1).toString());
        setDirector(query.value(2).toString());
        setIntroduce(query.value(3).toString());
        setRole(query.value(4).toString());
        setEpisodes(query.value(5).toInt());
        setmoveImage(query.value(6).toString());
        setTime(query.value(7).toInt());
        setSource(query.value(8).toString());
    }
}

int MoveDB::setKey(QString key)
{
    m_key=key;
    m_timeSearch=key;
    QSqlQuery query;
    QString str1=QString("select * from VedioInfo0 where ve_name like '%1'").arg('%'+m_key+'%');
    query.exec(str1);
    if(query.size()!=0){
        qDebug()<<query.exec(str1);
        while (query.next()) {
            setName(query.value(1).toString());
            setDirector(query.value(2).toString());
            setIntroduce(query.value(3).toString());
            setRole(query.value(4).toString());
            setEpisodes(query.value(5).toInt());
            setmoveImage(query.value(6).toString());
            setTime(query.value(7).toInt());
            setSource(query.value(8).toString());
             qDebug()<<query.value(8).toString();
        }
        return 0;
        }else{
        return -1;
        }
}

MoveDB::~MoveDB(){

}
