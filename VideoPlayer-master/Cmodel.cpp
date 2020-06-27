//#include "Cmodel.h"
//Move::Move(const QString &title, const QString &director)
//    :m_title(title)
//    ,m_director(director)
//{

//}

//QString Move::title() const
//{
//    return m_title;
//}

//QString Move::director() const
//{
//    return m_director;
//}

//MoveModel::MoveModel(QObject *parent)
//    : QAbstractListModel(parent)
//{
//}

//MoveModel::~MoveModel()
//{
//}

//int MoveModel::rowCount(const QModelIndex &parent) const
//{
//    Q_UNUSED(parent);
//    return m_list.count();
//}

//QVariant MoveModel::data(const QModelIndex &index, int role) const
//{
//    int row = index.row();
//    if(row < 0 || row >= m_list.count()) {
//        return QVariant();
//    }

//    const Move &move = m_list[row];
//    switch (role) {
//    case TitleRole:
//        return move.title();
//        break;
//    case DirectorRole:
//        return move.director();
//        break;
//    }

//    return QVariant();
//}


//////dm : data model
//QHash<int, QByteArray> MoveModel::roleNames() const
//{
//    QHash<int, QByteArray> roles;
//    roles[TitleRole] = "dmTitle";
//    roles[DirectorRole] = "dmDirector";
//    return roles;
//    //    emit countChanged(m_data.count());
//}

//void MoveModel::insert(int index, const Move &move)
//{
//    if(index < 0 || index > m_list.count()) {
//        return;
//    }

//    emit beginInsertRows(QModelIndex(), index, index);
//    m_list.insert(index, move);
//    emit endInsertRows();
////    emit countChanged(m_data.count());
//}

//void MoveModel::remove(int index)
//{
//    if(index < 0 || index >= m_list.count()) {
//        return;
//    }

//    beginRemoveRows(QModelIndex(), index, index);
//    m_list.removeAt(index);
//    endRemoveRows();
//}


//void MoveModel::append(const QString &title,const QString &director)
//{
//    insert(count(), Move(title,director));
//}


//int MoveModel::count() const
//{
//    return rowCount(QModelIndex());
//}
