
//Truth or Dare display screen
#import "TruthOrDareAppDelegate.h"
#import "IFNNotificationDisplay.h"
#import <iAd/iAd.h>
#import <AVFoundation/AVFoundation.h>
#import "MPAdView.h"
#import "Mopubclass.h"
@protocol FBSessionDelegate;
@interface TruthOrDareDisplayView : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,MPAdViewDelegate,UITextFieldDelegate>
{
    IBOutlet UILabel *lblPlayerName;
    IBOutlet UITextView *lblDisplayText;
    AVAudioPlayer *audioPlayer;
    
    NSString *strPlayerName1;
    NSString *strMode;
    NSArray *arrPlayerName;
    int randomNumber;
    int refreshRandomNumber;
    IBOutlet UIImageView *backgroundimage;
    
    TruthOrDareAppDelegate *appDelegate;
    
    NSDictionary *dictChangeDare;
    
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnCamera;
    IBOutlet UIButton *btnChangeDare;
    IBOutlet UIButton *btnTimer;
    
    IBOutlet UIButton *btnOk;
    UIImagePickerController *imgPicker;
    IBOutlet UILabel *lbltimer;
    NSTimer *clocktimer;
    NSInteger seconds;
     NSString *strstate;
    BOOL timerflag;
    NSString *displaytext;
    NSString *strpreviewmode;
    //ADBannerView *_bannerView;
    CFTimeInterval _ticks;
    
    NSString *strPlayerGender;
    NSMutableArray *playerArray;
    NSMutableArray *arrMale;
    NSMutableArray *arrFemale;
    
    NSMutableArray *arrayOfOppositeGender;
    NSMutableArray *arrayOfSameGender;
    
    NSArray *arrName;
    NSMutableArray *arrWithoutPlayer;
    NSMutableArray *genderWithoutPlayer;
    NSString *strTemp;
    
    BOOL notFromTestAdv;
    BOOL notFromCamera;
    NSString *genderforpreview;
    NSMutableDictionary *dictionary;
    Mopubclass *mopubclass;
    UIDevice *thisDevice;
    int changeQue;
   // MPAdView* mpAdView;
}
//@property(nonatomic,retain) MPAdView* mpAdView;
@property(nonatomic,retain)NSString *genderforpreview;
@property (nonatomic,retain) NSTimer *clocktimer;
@property (nonatomic,retain) NSMutableArray *arrWithoutPlayer;
@property (nonatomic,retain) NSMutableArray *genderWithoutPlayer;
@property(nonatomic, strong) IBOutlet UIView *contentView;
@property(nonatomic,copy) NSString *strpreviewmode;
@property(nonatomic,copy)NSString *strstate;
@property(nonatomic,copy)NSString *displaytext;
@property (nonatomic, copy) NSString *strPlayerName1;
@property (nonatomic, retain) NSString *strMode;
-(IBAction)back:(id)sender;
-(IBAction)confirm:(id)sender;
-(IBAction)facebookbtnAction:(id)sender;
-(IBAction)camerabtnAction:(id)sender;
-(IBAction)clockbtnAction:(id)sender;
-(IBAction)changeTruthOrDare:(id)sender;

-(int)generateMaleTruthId;
-(int)generateMaleDareId;
-(int)generateFemaleTruthId;
-(int)generateFemaleDareId;

-(NSMutableArray *)filter:(NSMutableArray *)array usedArray:(NSMutableArray *)usedArr andGenderArray:(NSMutableArray *)genderArray;
-(void)generateRandomQueryForTruth:(BOOL)generateNew;
-(void)generateRandomQueryForFalse:(BOOL)generateNew;
- (NSMutableDictionary *)checkIfCodePresent:(NSString*)string;
-(NSMutableDictionary *)checkPersonCodeForPreview:(NSString*)string;
-(void)update_UI;

@end
