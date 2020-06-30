#ifndef HISTORYSEARCHMODEL_H
#define HISTORYSEARCHMODEL_H

#include <QAbstractListModel>
#include <QGuiApplication>
#include <QQmlApplicationEngine>
class HistorySearchModel:public QAbstractListModel
{
    Q_OBJECT
public:
    HistorySearchModel(QGuiApplication &app,QQmlApplicationEngine &engine);
    virtual int rowCount(const QModelIndex &parent=QModelIndex()) const override;
    virtual int columnCount(const QModelIndex &parent=QModelIndex()) const override;

    virtual QVariant data(const QModelIndex &index, int role=Qt::DisplayRole) const override;

    Q_INVOKABLE void sortByKey(const QString &key);

private:
    QList<QString> m_data;
    QList<QString> m_historyData;
    QGuiApplication *m_app;
    QQmlApplicationEngine *m_engine;
};

#endif // HISTORYSEARCHMODEL_H
