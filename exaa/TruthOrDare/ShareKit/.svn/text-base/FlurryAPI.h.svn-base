
#import <UIKit/UIKit.h>

@class CLLocationManager;
@class CLLocation;

@interface FlurryAPI : NSObject {
}


+ (void)setAppVersion:(NSString *)version;		// override the app version
+ (NSString *)getFlurryAgentVersion;			// get the Flurry Agent version number
+ (void)setAppCircleEnabled:(BOOL)value;		// default is NO
+ (void)setShowErrorInLogEnabled:(BOOL)value;	// default is NO
+ (void)unlockDebugMode:(NSString*)debugModeKey apiKey:(NSString *)apiKey;	// generate debug logs for Flurry support
+ (void)setPauseSecondsBeforeStartingNewSession:(int)seconds; // default is 10 seconds


+ (void)startSession:(NSString *)apiKey;


+ (void)logEvent:(NSString *)eventName;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;


+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;	// non-nil parameters will update the parameters


+ (void)countPageViews:(id)target;		// automatically track page view on UINavigationController or UITabBarController
+ (void)countPageView;					// manually increment page view by 1


+ (void)setUserID:(NSString *)userID;	// user's id in your system
+ (void)setAge:(int)age;				// user's age in years
+ (void)setGender:(NSString *)gender;	// user's gender m or f


+ (void)setSessionReportsOnCloseEnabled:(BOOL)sendSessionReportsOnClose;	// default is YES
+ (void)setSessionReportsOnPauseEnabled:(BOOL)setSessionReportsOnPauseEnabled;	// default is YES
+ (void)setEventLoggingEnabled:(BOOL)value;		// default is YES


+ (UIView *)getHook:(NSString *)hook xLoc:(int)x yLoc:(int)y view:(UIView *)view;

+ (UIView *)getHook:(NSString *)hook xLoc:(int)x yLoc:(int)y view:(UIView *)view attachToView:(BOOL)attachToView orientation:(NSString *)orientation canvasOrientation:(NSString *)canvasOrientation autoRefresh:(BOOL)refresh canvasAnimated:(BOOL)canvasAnimated;

+ (void)updateHook:(UIView *)banner;

+ (void)removeHook:(UIView *)banner;

+ (void)openCatalog:(NSString *)hook canvasOrientation:(NSString *)canvasOrientation canvasAnimated:(BOOL)canvasAnimated;

+ (void)setAppCircleDelegate:(id)delegate;

@end
