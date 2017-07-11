#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QDir>
#include <QTextCodec>

// Static methods, no overide required:

QString FileIO::getApplicationPath(){
    return QDir::currentPath();
}

// All methods linked to the working directory
QString FileIO::readFile(const QString &filename)
{
QFile file(cDir.path() + cDir.separator() + filename);
if (!file.open(QIODevice::ReadOnly))
    return "cant read";
QByteArray data = file.readAll();
QString result = QString(data);
return result;
}

bool FileIO::writeFile(const QString& data, const QString& filename)
{
if (filename.isEmpty())
    return false;

QFile file(cDir.path() + cDir.separator() + filename);
if (!file.open(QFile::WriteOnly | QFile::Truncate))
    return false;

QTextStream out(&file);
out << data;

file.close();

return true;
}

QString FileIO::getPath(){
    return cDir.path();
}

bool FileIO::removeFile(const QString& filename){
    if (filename.isEmpty())
        return false;

    return cDir.remove(filename);
}

bool FileIO::makeDirectory(const QString& dirname){
    if (dirname.isEmpty())
        return false;

    return cDir.mkdir(dirname);
}

void FileIO::refresh(){
    cDir.refresh();
}

bool FileIO::cd(const QString& dirname){
    if (dirname.isEmpty())
        return false;
    return cDir.cd(dirname);
}

bool FileIO::cdUp(){
    return cDir.cdUp();
}

QStringList FileIO::getFileNames(){
    return cDir.entryList(QDir::Files,QDir::NoSort);
}

QStringList FileIO::getDirectoryNames(){
    return cDir.entryList(QDir::Dirs, QDir::NoSort);
}

bool FileIO::removeDirectoryFromDir(QDir dir){
    return dir.removeRecursively();
}

bool FileIO::removeCurrentDirectory(){
    return removeDirectoryFromDir(cDir);
}

QString FileIO::getCurrentDirName(){
    return cDir.dirName();
}

bool FileIO::dirExist(const QString& dirname){
    return cDir.exists(dirname);
}

void FileIO::resetDirectory(){
    cDir = QDir::current();
}

QStringList FileIO::getFilteredNames(const QString& filterString,const QString& sortString)
{
    // Initialise filter and sort with default value
    QDir::Filter filter = QDir::AllEntries;
    QDir::SortFlag sortFlag = QDir::NoSort;

    // If the filter exist apply it
    if(m_filterFlags.find(filterString) != m_filterFlags.end()) {
        filter = m_filterFlags.at(filterString);
    }

    // If the sort flag exist apply it
    if(m_sortFlags.find(sortString) != m_sortFlags.end()) {
        sortFlag = m_sortFlags.at(sortString);
    }

    return cDir.entryList(filter, sortFlag);
}


// Insert all methods with overloads to do the functions but from a specified path...

bool FileIO::removeDirectory(const QString& dirpath){
     QDir dir = QDir(dirpath);
    return removeDirectoryFromDir(dir);
}
