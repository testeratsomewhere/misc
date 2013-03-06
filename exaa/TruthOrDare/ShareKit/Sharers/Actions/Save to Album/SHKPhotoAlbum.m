

#import "SHKPhotoAlbum.h"


@implementation SHKPhotoAlbum

#pragma mark -
#pragma mark Configuration : Service Definition

+ (NSString *)sharerTitle
{
	return @"Save to Photo Album";
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
	if (item.shareType == SHKShareTypeImage)
		UIImageWriteToSavedPhotosAlbum(item.image, nil, nil, nil);
	
	// Notify user
	[[SHKActivityIndicator currentIndicator] displayCompleted:@"Saved!"];
	
	return YES;
}

@end
