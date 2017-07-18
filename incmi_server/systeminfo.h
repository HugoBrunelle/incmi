#ifndef SYSTEMINFO_H
#define SYSTEMINFO_H
#include <QObject>
#include <qnetworkinterface.h>

class SystemInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString ipAdress READ ipAdress)
    Q_PROPERTY(QString subnetMask READ subnetMask);
public:
    explicit SystemInfo(QObject *parent = nullptr);
    QString ipAdress() const {
        QList<QNetworkInterface> interfaces = QNetworkInterface::allInterfaces();
        for(int i=0; i<interfaces.count(); i++)
        {
            QList<QNetworkAddressEntry> entries = interfaces.at(i).addressEntries();
            for(int j=0; j<entries.count(); j++)
            {
                if(entries.at(j).ip().protocol() == QAbstractSocket::IPv4Protocol)
                {
                    return entries.at(j).ip().toString();
                }
            }
        }
        return QString();
    }

    QString subnetMask() const {
        QList<QNetworkInterface> interfaces = QNetworkInterface::allInterfaces();
        for(int i=0; i<interfaces.count(); i++)
        {
            QList<QNetworkAddressEntry> entries = interfaces.at(i).addressEntries();
            for(int j=0; j<entries.count(); j++)
            {
                if(entries.at(j).ip().protocol() == QAbstractSocket::IPv4Protocol)
                {
                    return entries.at(j).netmask().toString();
                }
            }
        }
        return QString();
    }

signals:

public slots:
};
#endif // SYSTEMINFO_H
