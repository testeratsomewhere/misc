
// Custom cell for Setting Screen

#import <UIKit/UIKit.h>

@class SettingsSegmentCustomCell;

@protocol SettingsSegmentDelegate <NSObject>

-(void)settingsTag:(SettingsSegmentCustomCell*)cell;

@end

@interface SettingsSegmentCustomCell : UITableViewCell
{
    UISegmentedControl *segmentedControl;
    UILabel *lbl;
    id<SettingsSegmentDelegate> delegate;
    
    UIDevice *thisDevice;
}

@property (nonatomic,assign) id<SettingsSegmentDelegate> delegate;
@property(nonatomic,retain) UISegmentedControl *segmentedControl;
@property(nonatomic,retain) UILabel *lbl;

@end
