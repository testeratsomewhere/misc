


#import "NSURL+Base.h"


@implementation NSURL (OABaseAdditions)

- (NSString *)URLStringWithoutQuery 
{
    NSArray *parts = [[self absoluteString] componentsSeparatedByString:@"?"];
    return [parts objectAtIndex:0];
}

@end
