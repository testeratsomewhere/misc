

#import "FBLoginDialog.h"
#import "FBSession.h"
#import "FBRequest.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kLoginURL = @"http://www.facebook.com/login.php";

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FBLoginDialog

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (void)connectToGetSession:(NSString*)token {
  _getSessionRequest = [[FBRequest requestWithSession:_session delegate:self] retain];
  NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObject:token forKey:@"auth_token"];
  if (!_session.apiSecret) {
    [params setObject:@"1" forKey:@"generate_session_secret"];
  }
  
  if (_session.getSessionProxy) {
    [_getSessionRequest post:_session.getSessionProxy params:params];
  } else {
    [_getSessionRequest call:@"facebook.auth.getSession" params:params];
  }
}

- (void)loadLoginPage {
  NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
    @"1", @"fbconnect", @"touch", @"connect_display", _session.apiKey, @"api_key",
    @"fbconnect://success", @"next", nil];

  [self loadURL:kLoginURL method:@"GET" get:params post:nil];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithSession:(FBSession*)session {
  if (self = [super initWithSession:session]) {
    _getSessionRequest = nil;
  }
  return self;
}

- (void)dealloc {
  _getSessionRequest.delegate = nil;
  [_getSessionRequest release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialog

- (void)load {
  [self loadLoginPage];
}

- (void)dialogWillDisappear {
  [_webView stringByEvaluatingJavaScriptFromString:@"email.blur();"];

  [_getSessionRequest cancel];
  
  if (![_session isConnected]) {
    [_session cancelLogin];
  }
}

- (void)dialogDidSucceed:(NSURL*)url {
  NSString* q = url.query;
  NSRange start = [q rangeOfString:@"auth_token="];
  if (start.location != NSNotFound) {
    NSRange end = [q rangeOfString:@"&"];
    NSUInteger offset = start.location+start.length;
    NSString* token = end.location == NSNotFound
      ? [q substringFromIndex:offset]
      : [q substringWithRange:NSMakeRange(offset, end.location-offset)];

    if (token) {
      [self connectToGetSession:token];
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

- (void)request:(FBRequest*)request didLoad:(id)result {
  NSDictionary* object = result;
  FBUID uid = [[object objectForKey:@"uid"] longLongValue];
  NSString* sessionKey = [object objectForKey:@"session_key"];
  NSString* sessionSecret = [object objectForKey:@"secret"];
  NSTimeInterval expires = [[object objectForKey:@"expires"] floatValue];
  NSDate* expiration = expires ? [NSDate dateWithTimeIntervalSince1970:expires] : nil;
  
  [_getSessionRequest release];
  _getSessionRequest = nil;

  [_session begin:uid sessionKey:sessionKey sessionSecret:sessionSecret expires:expiration];
  [_session resume];
  
  [self dismissWithSuccess:YES animated:YES];
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error {
  [_getSessionRequest release];
  _getSessionRequest = nil;

  [self dismissWithError:error animated:YES];
}
 
@end
