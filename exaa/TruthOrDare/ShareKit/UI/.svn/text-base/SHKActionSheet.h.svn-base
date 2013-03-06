

#import <Foundation/Foundation.h>
#import "SHK.h"

@interface SHKActionSheet : UIActionSheet <UIActionSheetDelegate>
{		
	NSMutableArray *sharers;
	
	SHKItem *item;
}

@property (retain) NSMutableArray *sharers;

@property (retain) SHKItem *item;

+ (SHKActionSheet *)actionSheetForType:(SHKShareType)type;
+ (SHKActionSheet *)actionSheetForItem:(SHKItem *)i;

@end