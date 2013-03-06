// dirtyness selection screen

#import <UIKit/UIKit.h>
#import "TruthOrDareAppDelegate.h"

@interface DirtyViewController : UIViewController
{
    IBOutlet UIButton *btnStar1;
    IBOutlet UIButton *btnStar2;
    IBOutlet UIButton *btnStar3;
    IBOutlet UIButton *btnHeart1;
    IBOutlet UIButton *btnHeart2;
    IBOutlet UIButton *btnLips;
    TruthOrDareAppDelegate *appDelegate;
    NSDictionary *dicSettings;
    
   
    
    NSString *strClean;
    NSString *strDirty;
    NSString *strSuperDirty;
    NSString *strMyDaresOnly;
    
    UIDevice *thisDevice;
    IBOutlet UIImageView *imgViewDirtiness;
}

@property (nonatomic, retain) IBOutlet UIButton *btnStar1;
@property (nonatomic, retain) IBOutlet UIButton *btnStar2;
@property (nonatomic, retain) IBOutlet UIButton *btnStar3;
@property (nonatomic, retain) IBOutlet UIButton *btnHeart1;
@property (nonatomic, retain) IBOutlet UIButton *btnHeart2;
@property (nonatomic, retain) IBOutlet UIButton *btnLips;

-(IBAction)changeDirtiness:(id)sender;
-(void)resetSpeedCountOfPlayer;
-(void)checkdirtiness;
-(void)checkdirtinessValue;
-(void)checkformine;
-(void)update_UI;
@end
