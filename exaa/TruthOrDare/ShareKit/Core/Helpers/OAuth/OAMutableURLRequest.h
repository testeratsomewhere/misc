


#import <Foundation/Foundation.h>
#import "OAConsumer.h"
#import "OAToken.h"
#import "OAHMAC_SHA1SignatureProvider.h"
#import "OASignatureProviding.h"
#import "NSMutableURLRequest+Parameters.h"
#import "NSURL+Base.h"


@interface OAMutableURLRequest : NSMutableURLRequest {
@protected
    OAConsumer *consumer;
    OAToken *token;
    NSString *realm;
    NSString *signature;
    id<OASignatureProviding> signatureProvider;
    NSString *nonce;
    NSString *timestamp;
	NSMutableDictionary *extraOAuthParameters;
	BOOL didPrepare;
}
@property(readonly) NSString *signature;
@property(readonly) NSString *nonce;

- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer *)aConsumer
			token:(OAToken *)aToken
            realm:(NSString *)aRealm
signatureProvider:(id<OASignatureProviding, NSObject>)aProvider;

- (id)initWithURL:(NSURL *)aUrl
		 consumer:(OAConsumer *)aConsumer
			token:(OAToken *)aToken
            realm:(NSString *)aRealm
signatureProvider:(id<OASignatureProviding, NSObject>)aProvider
            nonce:(NSString *)aNonce
        timestamp:(NSString *)aTimestamp;

- (void)prepare;

- (void)setOAuthParameterName:(NSString*)parameterName withValue:(NSString*)parameterValue;

@end
