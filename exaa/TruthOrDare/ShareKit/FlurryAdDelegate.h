

#import <UIKit/UIKit.h>


@protocol FlurryAdDelegate <NSObject>

@optional

- (void)dataAvailable;

- (void)dataUnavailable;

- (void)canvasWillDisplay:(NSString *)hook;

- (void)canvasWillClose;

@end
