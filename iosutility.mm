#include "iosutility.h"

#import <QString>
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#include "deviceinterface.h"

@interface IosUtility : NSObject

@end

@implementation IosUtility

void isNotificationsPermitted() {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
      if (settings.authorizationStatus != UNAuthorizationStatusAuthorized) {
        // Notifications not allowed
          DeviceInterface::setPermissionGranted(false);
      } else {
          DeviceInterface::setPermissionGranted(true);
      }
    }];
}

void askNotificationsPermission() {
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:options
     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        #pragma unused (error)
        // Handle refusal Qt-side
        DeviceInterface::setPermissionGranted(granted);
    }];
}

void scheduleDailyReminderIos(int hour) {
    NSInteger hourInt = (NSInteger) hour;
    NSString *hourStr = [@(hourInt) stringValue];
    NSLog(hourStr);


}

@end
