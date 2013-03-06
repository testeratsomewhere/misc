

#import "FBConnectGlobal.h"

@protocol FBSessionDelegate;
@class FBRequest;


@interface FBSession : NSObject {
  NSMutableArray* _delegates;
  NSString* _apiKey;
  NSString* _apiSecret;
  NSString* _getSessionProxy;
  FBUID _uid;
  NSString* _sessionKey;
  NSString* _sessionSecret;
  NSDate* _expirationDate;
  NSMutableArray* _requestQueue;
  NSDate* _lastRequestTime;
  int _requestBurstCount;
  NSTimer* _requestTimer;
}


@property(nonatomic,readonly) NSMutableArray* delegates;


@property(nonatomic,readonly) NSString* apiURL;


@property(nonatomic,readonly) NSString* apiSecureURL;


@property(nonatomic,readonly) NSString* apiKey;


@property(nonatomic,readonly) NSString* apiSecret;


@property(nonatomic,readonly) NSString* getSessionProxy;


@property(nonatomic,readonly) FBUID uid;


@property(nonatomic,readonly) NSString* sessionKey;


@property(nonatomic,readonly) NSString* sessionSecret;

@property(nonatomic,readonly) NSDate* expirationDate;

@property(nonatomic,readonly) BOOL isConnected;


+ (FBSession*)session;


+ (void)setSession:(FBSession*)session;

+ (FBSession*)sessionForApplication:(NSString*)key secret:(NSString*)secret
  delegate:(id<FBSessionDelegate>)delegate;

+ (FBSession*)sessionForApplication:(NSString*)key getSessionProxy:(NSString*)getSessionProxy
  delegate:(id<FBSessionDelegate>)delegate;


- (FBSession*)initWithKey:(NSString*)key secret:(NSString*)secret
  getSessionProxy:(NSString*)getSessionProxy;

- (void)begin:(FBUID)uid sessionKey:(NSString*)sessionKey sessionSecret:(NSString*)sessionSecret
  expires:(NSDate*)expires;

- (BOOL)resume;

- (void)cancelLogin;

- (void)logout;

- (void)send:(FBRequest*)request;
- (void)deleteFacebookCookies;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@protocol FBSessionDelegate <NSObject>

- (void)session:(FBSession*)session didLogin:(FBUID)uid;

@optional

- (void)sessionDidNotLogin:(FBSession*)session;
- (void)session:(FBSession*)session willLogout:(FBUID)uid;

- (void)sessionDidLogout:(FBSession*)session;

@end
