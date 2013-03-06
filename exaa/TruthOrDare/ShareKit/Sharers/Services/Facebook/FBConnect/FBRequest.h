

#import "FBConnectGlobal.h"

@protocol FBRequestDelegate;
@class FBSession;

@interface FBRequest : NSObject {
  FBSession*            _session;
  id<FBRequestDelegate> _delegate;
  NSString*             _url;
  NSString*             _method;
  id                    _userInfo;
  NSMutableDictionary*  _params;
  NSObject*             _dataParam;
  NSDate*               _timestamp;
  NSURLConnection*      _connection;
  NSMutableData*        _responseText;
}


+ (FBRequest*)request;


+ (FBRequest*)requestWithDelegate:(id<FBRequestDelegate>)delegate;

+ (FBRequest*)requestWithSession:(FBSession*)session;


+ (FBRequest*)requestWithSession:(FBSession*)session delegate:(id<FBRequestDelegate>)delegate;

@property(nonatomic,assign) id<FBRequestDelegate> delegate;


@property(nonatomic,readonly) NSString* url;


@property(nonatomic,readonly) NSString* method;


@property(nonatomic,retain) id userInfo;

@property(nonatomic,readonly) NSDictionary* params;

@property(nonatomic,readonly) NSObject* dataParam;

@property(nonatomic,readonly) NSDate* timestamp;


@property(nonatomic,readonly) BOOL loading;

- (id)initWithSession:(FBSession*)session;
 
- (void)call:(NSString*)method params:(NSDictionary*)params;

- (void)call:(NSString*)method params:(NSDictionary*)params dataParam:(NSData*)dataParam;
- (void)post:(NSString*)url params:(NSDictionary*)params;

- (void)cancel;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@protocol FBRequestDelegate <NSObject>

@optional


- (void)requestLoading:(FBRequest*)request;

- (void)request:(FBRequest*)request didReceiveResponse:(NSURLResponse*)response;


- (void)request:(FBRequest*)request didFailWithError:(NSError*)error;


- (void)request:(FBRequest*)request didLoad:(id)result;


- (void)requestWasCancelled:(FBRequest*)request;

@end
