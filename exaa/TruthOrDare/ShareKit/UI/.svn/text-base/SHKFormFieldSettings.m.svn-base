

#import "SHKFormFieldSettings.h"


@implementation SHKFormFieldSettings

@synthesize label, key, type, start;

- (void)dealloc
{
	[label release];
	[key release];
	[start release];
	
	[super dealloc];
}

+ (id)label:(NSString *)l key:(NSString *)k type:(SHKFormFieldType)t start:(NSString *)s
{
	SHKFormFieldSettings *settings = [[SHKFormFieldSettings alloc] init];
	settings.label = l;
	settings.key = k;
	settings.type = t;	
	settings.start = s;
	return [settings autorelease];
}

@end
