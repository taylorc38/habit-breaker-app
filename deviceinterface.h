#ifndef DEVICEINTERFACE_H
#define DEVICEINTERFACE_H

#include <QObject>
#include <QDebug>
#include <QDate>
#include <QTime>
#include <QDateTime>

#ifdef Q_OS_IOS
#include "iosutility.h"
#endif

class DeviceInterface : public QObject {
    Q_OBJECT
public:
    DeviceInterface();
    void checkNotificationsPermitted();
    static void setPermissionGranted(bool granted);
    Q_INVOKABLE void scheduleDailyReminder(const QString title, const QString body, const int hour);
    void removePendingNotifications();
    static DeviceInterface* m_instance;
private slots:
    void askNotificationPermission(bool granted);
signals:
    void permissionChanged(bool granted);
private:
    bool m_permissionGranted;
};

#endif // DEVICEINTERFACE_H
