#include "fileio.h"
#include <QFile>
#include <QTextStream>

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
