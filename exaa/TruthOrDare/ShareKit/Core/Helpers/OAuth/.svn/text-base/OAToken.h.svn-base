

#import <Foundation/Foundation.h>

@interface OAToken : NSObject {
@protected
	NSString *key;
	NSString *secret;
	NSString *sessionHandle;
}
@property(retain) NSString *key;
@property(retain) NSString *secret;
@property(retain) NSString *sessionHandle;

- (id)initWithKey:(NSString *)aKey secret:(NSString *)aSecret;
- (id)initWithUserDefaultsUsingServiceProviderName:(NSString *)provider prefix:(NSString *)prefix;
- (id)initWithHTTPResponseBody:(NSString *)body;
- (int)storeInUserDefaultsWithServiceProviderName:(NSString *)provider prefix:(NSString *)prefix;

@end
