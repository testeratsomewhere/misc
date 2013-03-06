
#import <Foundation/Foundation.h>
#import "FBStreamDialog.h"

@interface SHKFBStreamDialog : FBStreamDialog
{
	NSString *defaultStatus;
}

@property (nonatomic, retain) NSString *defaultStatus;

@end
