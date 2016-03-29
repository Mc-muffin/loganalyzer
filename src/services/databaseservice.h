#ifndef DATABASESERVICE_H
#define DATABASESERVICE_H

#include <QObject>
#include <QString>


class DatabaseService
{

public:
    DatabaseService();
    static bool createConnection();
    static bool setupTables();
    static QString getAppData(QString name);
    static bool setAppData(QString name, QString value);
    static bool reinitializeDiskDatabase();
    static bool removeDiskDatabase();

private:
    static QString getDiskDatabasePath();
    static bool createMemoryConnection();
    static bool createDiskConnection();
};

#endif // DATABASESERVICE_H
