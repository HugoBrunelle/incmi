#ifndef FILEIO_H
#define FILEIO_H

#include <QObject>
#include <QDir>

class FileIO: public QObject
{
    Q_OBJECT

public:
    Q_INVOKABLE QString readFile(const QString &filename);
    Q_INVOKABLE bool writeFile(const QString &data, const QString &filename);
    Q_INVOKABLE bool removeFile(const QString &filename);
    Q_INVOKABLE QString getApplicationPath();
    Q_INVOKABLE QString getPath();
    Q_INVOKABLE bool makeDirectory(const QString &dirName);
    Q_INVOKABLE void refresh();
    Q_INVOKABLE bool cd(const QString &dirname);
    Q_INVOKABLE bool cdUp();
    Q_INVOKABLE QStringList getFileNames();
    Q_INVOKABLE QStringList getDirectoryNames();
    Q_INVOKABLE bool removeCurrentDirectory();
    Q_INVOKABLE bool removeDirectory(const QString &dirpath);
    Q_INVOKABLE bool dirExist(const QString &dirname);
    Q_INVOKABLE QString getCurrentDirName();
    Q_INVOKABLE void resetDirectory();
    Q_INVOKABLE QStringList getFilteredNames(const QString& filterString,const QString& sortString);
    QString sourceDir() { return sDir; };

public slots:
      void setSourceDir(const QString& source) { sDir = source; };
private:
        QString sDir;
        QDir cDir = QDir::current();
        bool removeDirectoryFromDir(QDir dir);
        std::map<QString, QDir::Filter> m_filterFlags = {
                    { "dirs", QDir::Dirs },
                    { "alldirs", QDir::AllDirs },
                    { "files", QDir::Files },
                    { "drives", QDir::Drives },
                    { "nosymlinks", QDir::NoSymLinks },
                    { "nodotanddotdot", QDir::NoDotAndDotDot },
                    { "nodot", QDir::NoDot },
                    { "nodotdot", QDir::NoDotDot },
                    { "allentries", QDir::AllEntries },
                    { "readable", QDir::Readable },
                    { "writable", QDir::Writable },
                    { "Executable", QDir::Executable },
                    { "modified", QDir::Modified },
                    { "hidden", QDir::Hidden },
                    { "system", QDir::System },
                    { "casesensitive", QDir::CaseSensitive }
                };
        std::map<QString, QDir::SortFlag> m_sortFlags = {
                    { "name", QDir::Name },
                    { "time", QDir::Time },
                    { "size", QDir::Size },
                    { "type", QDir::Type },
                    { "unsorted", QDir::Unsorted },
                    { "nosort", QDir::NoSort },
                    { "dirsfirst", QDir::DirsFirst },
                    { "dirslast", QDir::DirsLast },
                    { "reversed", QDir::Reversed },
                    { "ignorecase", QDir::IgnoreCase },
                    { "localeaware", QDir::LocaleAware }
                };
};

#endif // FILEIO_H
