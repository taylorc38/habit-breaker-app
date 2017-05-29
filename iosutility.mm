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

void pushNotification() {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    // Content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    [content setValue:@YES forKey:@"shouldAlwaysAlertWhileAppIsForeground"];
    content.title = @"Don't forget";
    content.body = @"Buy some milk";
    content.sound = [UNNotificationSound defaultSound];

    // Trigger
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5
                                      repeats:NO];

    NSString *identifier = @"HabitBreakerLocalNotification";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                      content:content trigger:trigger];

    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
    }];
}

// Hour needs to be in GMT timezone
void scheduleDailyReminderIos(QString title, QString body, int hour) {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];

    // Content
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    [content setValue:@YES forKey:@"shouldAlwaysAlertWhileAppIsForeground"];
    NSString* nssTitle = title.toNSString();
    NSString* nssBody = body.toNSString();
    content.title = nssTitle;
    content.body = nssBody;
//    content.title = @"Don't forget";
//    content.body = @"Buy some milk";
    content.sound = [UNNotificationSound defaultSound];
    
    // Trigger
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setHour:(NSInteger) hour];
    [comps setMinute:0];
    [comps setSecond:0];
    
    UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:comps
                                                                                                      repeats:YES];
    
    // Schedule it
    NSString *identifier = @"EndOfDayReport";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier
                                                                          content:content trigger:trigger];
    
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"Something went wrong: %@",error);
        }
        // Get all pending notification requests from the Notification service.
        [center getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> *requests) {
            for (NSUInteger i = 0; i < [requests count]; i++) {
                UNNotificationRequest *request = (UNNotificationRequest*) [requests objectAtIndex:i];
                NSLog(@"Request identifier: %@", request.identifier);
                NSLog(@"Trigger date: %@", [request.trigger nextTriggerDate].description);
            }
        }];
    }];
}

void removePendingNotificationsIos() {
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center removeAllPendingNotificationRequests];
}

@end
