

#import "SHKSafari.h"


@implementation SHKSafari



#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return SHKLocalizedString(@"Open in Safari");
}

+ (BOOL)canShareURL
{
	return YES;
}

+ (BOOL)shareRequiresInternetConnection
{
	return NO;
}

+ (BOOL)requiresAuthentication
{
	return NO;
}



#pragma mark -
#pragma mark Configuration : Dynamic Enable

- (BOOL)shouldAutoShare
{
	return YES;
}


#pragma mark -
#pragma mark Share API Methods

- (BOOL)send
{	
	self.quiet = YES;
	
	[[UIApplication sharedApplication] openURL:item.URL];
	
	[self sendDidFinish];
	
	return YES;
}

@end
