#include "fileio.h"
#include <QFile>
#include <QTextStream>
#include <QDir>

QByteArray FileIO::readFileArray(const QString &filename)
{
QFile file(filename);
if (!file.open(QIODevice::ReadOnly))
    return QByteArray();

return file.readAll();
}

bool FileIO::writeFile(const QString& data)
{
if (sDir.isEmpty())
    return false;

QFile file(sDir);
if (!file.open(QFile::WriteOnly | QFile::Truncate))
    return false;

QTextStream out(&file);
out << data;

file.close();

return true;
}

bool FileIO::removeFile(const QString& filename){
    if (filename.isEmpty())
        return false;

    return cDir.remove(filename);
}

QString FileIO::getCurrentPath(){
    return QDir::currentPath();
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
    if (dir.entryList(QDir::Files,QDir::NoSort).isEmpty() && dir.entryList(QDir::AllDirs,QDir::NoSort).isEmpty()){
        QString bdir = dir.dirName();
        dir.cdUp();
        return dir.remove(bdir);
    }
    else {
        QStringList files = dir.entryList(QDir::Files,QDir::NoSort);
        if (!files.isEmpty()){
            for(int a = 0; a < files.count();a++){
                cDir.remove(files[a]);
            }
        }
        QStringList dirs = dir.entryList(QDir::AllDirs,QDir::NoSort);
        if(!dirs.isEmpty()){
            for(int b = 0; b<dirs.count();b++){
                QString idir = dir.currentPath() + dir.separator() + dirs[b];
                removeDirectory(idir);
            }
        }
        QString bdir = dir.dirName();
        dir.cdUp();
        return dir.remove(bdir);
    }
    return false;
}

bool FileIO::removeDirectory(const QString& dirpath){
     QDir dir = QDir(dirpath);
     return removeDirectoryFromDir(dir);
}

bool FileIO::removeCurrentDirectory(){
    return removeDirectoryFromDir(cDir);
}

QString FileIO::getCurrentDirName(){
    return cDir.dirName();
}
