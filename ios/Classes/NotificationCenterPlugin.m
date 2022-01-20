#import "NotificationCenterPlugin.h"
#if __has_include(<notification_center/notification_center-Swift.h>)
#import <notification_center/notification_center-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "notification_center-Swift.h"
#endif

@implementation NotificationCenterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftNotificationCenterPlugin registerWithRegistrar:registrar];
}
@end
