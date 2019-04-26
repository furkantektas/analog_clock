#import "AnalogClockPlugin.h"
#import <analog_clock/analog_clock-Swift.h>

@implementation AnalogClockPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAnalogClockPlugin registerWithRegistrar:registrar];
}
@end
