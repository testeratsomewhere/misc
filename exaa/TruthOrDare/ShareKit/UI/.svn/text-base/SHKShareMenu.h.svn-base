

#import <UIKit/UIKit.h>
#import "SHK.h"

@interface SHKShareMenu : UITableViewController 
{
	SHKItem *item;
	NSMutableArray *tableData;
	NSMutableDictionary *exclusions;
}

@property (retain) SHKItem *item;
@property (retain) NSMutableArray *tableData;
@property (retain) NSMutableDictionary *exclusions;


- (void)rebuildTableDataAnimated:(BOOL)animated;
- (NSMutableArray *)section:(NSString *)section;
- (NSDictionary *)rowDataAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark -
#pragma mark Toolbar Buttons

- (void)cancel;
- (void)edit;
- (void)save;



@end
