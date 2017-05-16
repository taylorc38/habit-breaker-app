#include "iosutility.h"

#import <QString>
#import <Foundation/Foundation.h>

@interface IosUtility : NSObject

@end

@implementation IosUtility

void testLog() {
    NSLog(@"TEST LOG :: ");
}

void getDatabasePath() {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"database" ofType:@"sqlite"];
    NSURL *fileURL = [NSURL fileURLWithPath:path];
//    return NSStringToQString(path);
}

@end
