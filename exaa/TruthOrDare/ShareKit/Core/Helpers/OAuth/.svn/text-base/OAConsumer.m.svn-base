

#import "OAConsumer.h"


@implementation OAConsumer
@synthesize key, secret;

#pragma mark init

- (id)initWithKey:(NSString *)aKey secret:(NSString *)aSecret 
{
	if (self = [super init])
	{
		self.key = aKey;
		self.secret = aSecret;
	}
	return self;
}

- (void)dealloc
{
	[key release];
	[secret release];
	[super dealloc];
}

@end
