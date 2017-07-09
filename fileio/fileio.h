#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QDir>

class FileIO: public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE QByteArray readFileArray(const QString &filename);
    Q_INVOKABLE bool writeFile(const QString &filename);
    Q_INVOKABLE bool removeFile(const QString &filename);
    Q_INVOKABLE QString getCurrentPath();
    Q_INVOKABLE bool makeDirectory(const QString &dirName);
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool cd(const QString &dirname);
    Q_INVOKABLE bool cdUp();
    Q_INVOKABLE QStringList getFileNames();
    Q_INVOKABLE QStringList getDirectoryNames();
    Q_INVOKABLE bool removeCurrentDirectory();
    Q_INVOKABLE bool removeDirectory(const QString &dirpath);
    Q_INVOKABLE QString getCurrentDirName();
    QString sourceDir() { return sDir; };

public slots:
      void setSourceDir(const QString& source) { sDir = source; };
private:
        QString sDir;
        QDir cDir = QDir::current();
        bool removeDirectoryFromDir(QDir dir);
};

#endif // FILEIO_H
