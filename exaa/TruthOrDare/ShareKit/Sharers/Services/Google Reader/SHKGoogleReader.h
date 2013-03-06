

#import <Foundation/Foundation.h>
#import "SHKSharer.h"

@interface SHKGoogleReader : SHKSharer 
{
	NSMutableDictionary *session;
	BOOL sendAfterLogin;
}

@property (nonatomic, retain) NSMutableDictionary *session;
@property (nonatomic) BOOL sendAfterLogin;

- (void)sendWithToken:(NSString *)token;
- (void)getSession:(NSString *)email password:(NSString *)password;
- (void)signRequest:(SHKRequest *)aRequest;

@end
