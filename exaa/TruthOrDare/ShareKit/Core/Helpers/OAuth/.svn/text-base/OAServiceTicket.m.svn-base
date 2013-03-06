


#import "OAServiceTicket.h"


@implementation OAServiceTicket
@synthesize request, response, data, didSucceed;

- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSHTTPURLResponse *)aResponse didSucceed:(BOOL)success 
{
	return [self initWithRequest:aRequest response:aResponse data:nil didSucceed:success];
}

- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSHTTPURLResponse *)aResponse data:(NSData *)aData didSucceed:(BOOL)success {
    [super init];
    request = aRequest;
    response = aResponse;
	data = aData;
    didSucceed = success;
    return self;
}

- (NSString *)body
{
	if (!data) {
		return nil;
	}
	
	return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
}

@end
