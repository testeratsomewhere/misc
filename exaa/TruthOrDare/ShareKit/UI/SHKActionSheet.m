
#import "SHKActionSheet.h"
#import "SHK.h"
#import "SHKSharer.h"
#import "SHKCustomShareMenu.h"
#import <Foundation/NSObjCRuntime.h>

@implementation SHKActionSheet

@synthesize item, sharers;

- (void)dealloc
{
	[item release];
	[sharers release];
	[super dealloc];
}

+ (SHKActionSheet *)actionSheetForType:(SHKShareType)type
{
	SHKActionSheet *as = [[SHKActionSheet alloc] initWithTitle:SHKLocalizedString(@"Share")
													  delegate:self
											 cancelButtonTitle:nil
										destructiveButtonTitle:nil
											 otherButtonTitles:nil];
	as.item = [[[SHKItem alloc] init] autorelease];
	as.item.shareType = type;
	
	as.sharers = [NSMutableArray arrayWithCapacity:0];
	NSArray *favoriteSharers = [SHK favoriteSharersForType:type];
		
	// Add buttons for each favorite sharer
	id class;
	for(NSString *sharerId in favoriteSharers)
	{
		class = NSClassFromString(sharerId);
		if ([class canShare])
		{
			[as addButtonWithTitle: [class sharerTitle] ];
			[as.sharers addObject:sharerId];
		}
	}
	
	// Add More button
	[as addButtonWithTitle:SHKLocalizedString(@"More...")];
	
	// Add Cancel button
	[as addButtonWithTitle:SHKLocalizedString(@"Cancel")];
	as.cancelButtonIndex = as.numberOfButtons -1;
	
	return [as autorelease];
}

+ (SHKActionSheet *)actionSheetForItem:(SHKItem *)i
{
	SHKActionSheet *as = [self actionSheetForType:i.shareType];
	as.item = i;
	return as;
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated
{
    [NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
    
   
	[super dismissWithClickedButtonIndex:buttonIndex animated:animated];
}

@end