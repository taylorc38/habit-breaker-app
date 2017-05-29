#ifndef IOSUTILITY_H
#define IOSUTILITY_H

#import <QString>

void scheduleDailyReminderIos(QString title, QString body, int hour);
void isNotificationsPermitted();
void askNotificationsPermission();
void pushNotification();
void removePendingNotificationsIos();

#endif // IOSUTILITY_H
