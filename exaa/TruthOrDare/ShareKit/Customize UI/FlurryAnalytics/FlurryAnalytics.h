
#import <UIKit/UIKit.h>



@interface FlurryAnalytics : NSObject {
}

+ (void)setAppVersion:(NSString *)version;		// override the app version
+ (NSString *)getFlurryAgentVersion;			// get the Flurry Agent version number
+ (void)setShowErrorInLogEnabled:(BOOL)value;	// default is NO
+ (void)setDebugLogEnabled:(BOOL)value;			// generate debug logs for Flurry support, default is NO
+ (void)setSessionContinueSeconds:(int)seconds; // default is 10 seconds
+ (void)setSecureTransportEnabled:(BOOL)value; // set data to be sent over SSL, default is NO


+ (void)startSession:(NSString *)apiKey;


+ (void)logEvent:(NSString *)eventName;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;
+ (void)logError:(NSString *)errorID message:(NSString *)message exception:(NSException *)exception;
+ (void)logError:(NSString *)errorID message:(NSString *)message error:(NSError *)error;


+ (void)logEvent:(NSString *)eventName timed:(BOOL)timed;
+ (void)logEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters timed:(BOOL)timed;
+ (void)endTimedEvent:(NSString *)eventName withParameters:(NSDictionary *)parameters;	// non-nil parameters will update the parameters


+ (void)logAllPageViews:(id)target;		// automatically track page view on UINavigationController or UITabBarController
+ (void)logPageView;					// manually increment page view by 1


+ (void)setUserID:(NSString *)userID;	// user's id in your system
+ (void)setAge:(int)age;				// user's age in years
+ (void)setGender:(NSString *)gender;	// user's gender m or f


+ (void)setLatitude:(double)latitude longitude:(double)longitude horizontalAccuracy:(float)horizontalAccuracy verticalAccuracy:(float)verticalAccuracy;

+ (void)setSessionReportsOnCloseEnabled:(BOOL)sendSessionReportsOnClose;	// default is YES
+ (void)setSessionReportsOnPauseEnabled:(BOOL)setSessionReportsOnPauseEnabled;	// default is NO
+ (void)setEventLoggingEnabled:(BOOL)value;		// default is YES

@end
