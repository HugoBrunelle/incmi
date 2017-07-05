#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>

class FileIO: public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE QByteArray readFileArray(const QString &filename);
    Q_INVOKABLE bool writeFile(const QString &filename);
    QString sourceDir() { return sDir; };

public slots:
      void setSourceDir(const QString& source) { sDir = source; };
private:
        QString sDir;
};

#endif // FILEIO_H
