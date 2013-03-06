


#import "OAToken.h"


@implementation OAToken

@synthesize key, secret, sessionHandle;

#pragma mark init

- (id)init 
{
	if (self = [super init])
	{
		self.key = @"";
		self.secret = @"";
		self.sessionHandle = @"";
	}
    return self;
}

- (id)initWithKey:(NSString *)aKey secret:(NSString *)aSecret 
{
	if (self = [super init])
	{
		self.key = aKey;
		self.secret = aSecret;
	}
	return self;
}

- (id)initWithHTTPResponseBody:(NSString *)body 
{
	if (self = [super init])
	{
		NSArray *pairs = [body componentsSeparatedByString:@"&"];
		
		for (NSString *pair in pairs) {
			NSArray *elements = [pair componentsSeparatedByString:@"="];
			if ([[elements objectAtIndex:0] isEqualToString:@"oauth_token"]) {
				self.key = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			} else if ([[elements objectAtIndex:0] isEqualToString:@"oauth_token_secret"]) {
				self.secret = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			} else if ([[elements objectAtIndex:0] isEqualToString:@"oauth_session_handle"]) {
				self.sessionHandle = [[elements objectAtIndex:1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
			}
		}
	}    
    return self;
}

- (id)initWithUserDefaultsUsingServiceProviderName:(NSString *)provider prefix:(NSString *)prefix
{
	if (self = [super init])
	{
		NSString *theKey = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"OAUTH_%@_%@_KEY", prefix, provider]];
		NSString *theSecret = [[NSUserDefaults standardUserDefaults] stringForKey:[NSString stringWithFormat:@"OAUTH_%@_%@_SECRET", prefix, provider]];
		if (theKey == NULL || theSecret == NULL)
			return(nil);
		self.key = theKey;
		self.secret = theSecret;
	}
	return self;
}

- (void)dealloc
{
	[key release];
	[secret release];
	[sessionHandle release];
	[super dealloc];
}

#pragma mark -

- (int)storeInUserDefaultsWithServiceProviderName:(NSString *)provider prefix:(NSString *)prefix
{
	[[NSUserDefaults standardUserDefaults] setObject:self.key forKey:[NSString stringWithFormat:@"OAUTH_%@_%@_KEY", prefix, provider]];
	[[NSUserDefaults standardUserDefaults] setObject:self.secret forKey:[NSString stringWithFormat:@"OAUTH_%@_%@_SECRET", prefix, provider]];
	[[NSUserDefaults standardUserDefaults] synchronize];
	return(0);
}

@end
