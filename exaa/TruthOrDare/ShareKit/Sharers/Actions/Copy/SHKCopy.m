

#import "SHKCopy.h"


@implementation SHKCopy

#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return SHKLocalizedString(@"Copy");
}

+ (BOOL)canShareURL
{
	return YES;
}

+ (BOOL)canShareImage
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
	if (item.shareType == SHKShareTypeURL)
		[[UIPasteboard generalPasteboard] setString:item.URL.absoluteString];
	
	else
		[[UIPasteboard generalPasteboard] setImage:item.image];
	
	// Notify user
	[[SHKActivityIndicator currentIndicator] displayCompleted:SHKLocalizedString(@"Copied!")];
	
	// Notify delegate, but quietly
	self.quiet = YES;
	[self sendDidFinish];
	
	return YES;
}

@end
