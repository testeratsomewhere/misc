//Speed,Auto Challenge and Player Selection screen

#import <UIKit/UIKit.h>

@interface PlayerselectionVC : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>
{
    IBOutlet UILabel *lblTitle;
    IBOutlet UILabel *lblselectedplayer;
    IBOutlet UIPickerView *picker;
    NSMutableArray *arrayNo;
    NSInteger player;
    NSInteger Value;
    NSString *language;
    NSString *strselection;
    IBOutlet UIButton *backbtn;
    
    NSUserDefaults *prefs;
    UIDevice *thisDevice;
}
@property(nonatomic,copy)NSString *strselection;
@property(nonatomic,retain) IBOutlet UIButton *backbtn;
@property(nonatomic) NSInteger player;
@property(nonatomic,retain)NSString *language;
-(IBAction)backbtnAction:(id)sender;
@end
