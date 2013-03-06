
// Turn Display screen
#import "TruthOrDareAppDelegate.h"
#import <iAd/iAd.h>
#import "Mopubclass.h"
@interface PlayViewController : UIViewController<MPAdViewDelegate>
{
    IBOutlet UIView *viewPlayerName;
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblPlayText;
    
    NSMutableArray *arrPlayerName;
    NSMutableArray *arrPlayerGender;
    
    TruthOrDareAppDelegate *appDelegate;
    
    NSDictionary *dictTruthOrder;
    NSString *strOrder;
   //  ADBannerView *_bannerView;
  
    CFTimeInterval _ticks;
    NSTimer *timer;
     NSUInteger number;
    
    IBOutlet UIButton *playbtn;
    NSMutableArray *jumbleArray;
    NSString *urTurnPlayer;
    BOOL fromTestAdv;
    Mopubclass *mopubclass;
    //MPAdView* mpAdView;
    UIDevice *thisDevice;
}
@property (nonatomic,retain) NSTimer *timer;
@property(nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, retain) IBOutlet UIView *viewPlayerName;
@property (nonatomic, retain) IBOutlet UILabel *lblName;
@property (nonatomic, retain) IBOutlet UILabel *lblPlayText;
@property (nonatomic, retain) NSMutableArray *arrPlayerName;
@property (nonatomic, retain) NSMutableArray *arrPlayerGender;

-(IBAction)back:(id)sender;
-(IBAction)selection:(id)sender;
-(void) showPlayerName;
-(void)rotateplayername;
-(void)showPlayerNameInRandomFashion;
-(NSMutableArray*)jummbleArray:(NSMutableArray *)array;
-(void)update_UI;
@end
