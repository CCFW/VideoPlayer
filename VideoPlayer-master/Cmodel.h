#ifndef CMODEL_H
#define CMODEL_H

#include <QAbstractListModel>

//class Move{
//public:
//    Move(const QString &type,const QString &size);

//    QString title() const;
//    QString director() const;

//private:
//    QString m_title;
//    QString m_director;
//};

//class MoveModel:public QAbstractListModel{
//    Q_OBJECT
//public:
//    enum DataRoles{
//        TitleRole=Qt::UserRole+1,
//        DirectorRole
//    };
//    MoveModel(QObject *parent=0);
//    ~MoveModel();
//    int rowCount(const QModelIndex & parent=QModelIndex()) const override;
//    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const override;

//    Q_INVOKABLE void insert(int index, const Move &move);
//    Q_INVOKABLE void append(const QString &title, const QString &director);
//    Q_INVOKABLE void remove(int index);
//    int count() const;

//signals:
//    void countChanged(int arg);

//protected:
//    QHash<int, QByteArray> roleNames() const;

//private:

//    QList<Move> m_list;
//};

#endif // CMODEL_H
