#ifndef DEVICEINTERFACE_H
#define DEVICEINTERFACE_H

#include <QObject>
#include <QDebug>

#ifdef Q_OS_IOS
#include "iosUtility.h"
#endif

class DeviceInterface : public QObject {
    Q_OBJECT
public:
    DeviceInterface();
    void checkNotificationsPermitted();
    static void setPermissionGranted(bool granted);
    Q_INVOKABLE void scheduleDailyReminder(const int hour);
    static DeviceInterface* m_instance;
private slots:
    void askNotificationPermission(bool granted);
signals:
    void permissionChanged(bool granted);
private:
    bool m_permissionGranted;
};

#endif // DEVICEINTERFACE_H
