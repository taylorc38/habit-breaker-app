#include "deviceinterface.h"

DeviceInterface::DeviceInterface() {
    m_permissionGranted = false;
    QObject::connect(this, SIGNAL(permissionChanged(bool)),
                     this, SLOT(askNotificationPermission(bool)));
}

// Keep a pointer to the object stored in cotext properties to emit signals from static methods.
DeviceInterface* DeviceInterface::m_instance = 0;

void DeviceInterface::checkNotificationsPermitted() {
#ifdef Q_OS_IOS
    isNotificationsPermitted();
#else
    QDebug() << "Asking for notification permission is not supported on this platform!";
#endif
}

void DeviceInterface::askNotificationPermission(bool granted) {
#ifdef Q_OS_IOS
    if (!granted) {
        askNotificationsPermission();
    } else {
        qDebug() << "Notification permission has already been granted, no need to ask again.";
    }
#else
    QDebug() << "Asking for notification permission is not supported on this platform!";
#endif
}

// Static method easily accessible from Objective-C
void DeviceInterface::setPermissionGranted(bool granted) {
    DeviceInterface* instance = DeviceInterface::m_instance;
    if (instance->m_permissionGranted != granted) {
        instance->m_permissionGranted = granted;
        emit instance->permissionChanged(granted);
    }
}

void DeviceInterface::scheduleDailyReminder(const int hour) {
#ifdef Q_OS_IOS
    scheduleDailyReminderIos(hour);
#else
    QDebug() << "Scheduling push notifications is not supported on this platform!";
#endif
}
