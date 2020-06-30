#include "HistorySearchModel.h"
#include <QMultiMap>
#include "MoveDB.h"
#include <QSqlQuery>
#include <iostream>

HistorySearchModel::HistorySearchModel(QGuiApplication &app,QQmlApplicationEngine &engine){
    QSqlQuery query;
    query.exec("select * from VedioInfo0");
    while (query.next()) {
        m_historyData.push_back(query.value(1).toString());
    }

    m_data = m_historyData;
    m_engine = &engine;
    m_app = &app;
}
int HistorySearchModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}
//columnCount（）函数是为了与各种视图互操作，但是默认情况下会通知视图该模型仅包含一列
int HistorySearchModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1;
}

//返回以给定角色存储的索引所引用项目的数据,如果没有要返回的值，请返回无效的QVariant而不是返回0
QVariant HistorySearchModel::data(const QModelIndex &index, int role) const
{
    if (index.row() < 0 || index.row() >= m_data.count())
        return QVariant();

    switch (role) {
    case Qt::DisplayRole://要以文本形式呈现的关键数据
        return m_data.at(index.row());//返回列表中索引位置i处的项目。i必须是列表中的有效索引位置（即0 <= i <size（））

    default:
        break;
    }

    return QVariant();
}
void HistorySearchModel::sortByKey(const QString &key)
{
    if(key.isEmpty()){
        beginResetModel();//重置模型
        m_data=m_historyData;
        endResetModel();
    }else{
        QMultiMap<int,QString> temp;
        for (auto str:m_historyData) {
            int ret=str.indexOf(key);//返回字符串str在此字符串中首次出现的索引位置，从索引位置from开始向前搜索。 如果找不到str，则返回-1
            if(ret==-1)continue;
            else {
                temp.insert(ret,str);
            }
        }

        beginResetModel();
        m_data.clear();
        if(!temp.isEmpty()){
            for (auto it=temp.begin();it!=temp.end();it++) {
                m_data.push_back(it.value());
            }
        }
        endResetModel();
    }
}
