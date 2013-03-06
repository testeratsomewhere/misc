

#import <Foundation/Foundation.h>
#import "SHKSharer.h"
#import "SHKOAuthView.h"
#import "OAuthConsumer.h"

@interface SHKOAuthSharer : SHKSharer
{
	NSString *consumerKey;
	NSString *secretKey;
	NSURL *authorizeCallbackURL;
	
	NSURL *authorizeURL;
	NSURL *accessURL;
	NSURL *requestURL;
	
	OAConsumer *consumer;
	OAToken *requestToken;
	OAToken *accessToken;
	
	id<OASignatureProviding> signatureProvider;
	
	NSDictionary *authorizeResponseQueryVars;
}

@property (nonatomic, retain) NSString *consumerKey;
@property (nonatomic, retain) NSString *secretKey;
@property (nonatomic, retain) NSURL *authorizeCallbackURL;

@property (nonatomic, retain) NSURL *authorizeURL;
@property (nonatomic, retain) NSURL *accessURL;
@property (nonatomic, retain) NSURL *requestURL;

@property (retain) OAConsumer *consumer;
@property (retain) OAToken *requestToken;
@property (retain) OAToken *accessToken;

@property (retain) id<OASignatureProviding> signatureProvider;

@property (nonatomic, retain) NSDictionary *authorizeResponseQueryVars;



#pragma mark -
#pragma mark OAuth Authorization

- (void)tokenRequest;
- (void)tokenRequestModifyRequest:(OAMutableURLRequest *)oRequest;
- (void)tokenRequestTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)tokenRequestTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error;

- (void)tokenAuthorize;

- (void)tokenAccess;
- (void)tokenAccess:(BOOL)refresh;
- (void)tokenAccessModifyRequest:(OAMutableURLRequest *)oRequest;
- (void)tokenAccessTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)tokenAccessTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error;

- (void)storeAccessToken;
- (BOOL)restoreAccessToken;
- (void)refreshToken;


@end
