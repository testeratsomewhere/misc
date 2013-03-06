
// Select Truth or Dare Display screen
#import "TruthOrDareAppDelegate.h"
#import <iAd/iAd.h>
#import "DirtyViewController.h"
#import "Mopubclass.h"
#define PUB_ID_320x50 @"agltb3B1Yi1pbmNyDAsSBFNpdGUYkaoMDA"
@interface SelectionViewController : UIViewController<MPAdViewDelegate>
{
    IBOutlet UILabel *lblPlayerName;
    IBOutlet UIButton *btnTruth;
    IBOutlet UIButton *btnDare;
     TruthOrDareAppDelegate *appDelegate;
    NSString *strPlayerName;
   
    NSInteger Numberofplayer;
    NSString *strTruthMode;
    NSString *strClean;
    NSString *strDirty;
    NSString *strSuperDirty;
    NSString *strSource;
    NSString *strGender;
    
    NSString *strAlertMessage;
    NSMutableDictionary* dictAlertMessage;
    NSString *mode;
    //ADBannerView *_bannerView;
    CFTimeInterval _ticks;
    
    NSDictionary *dicSettings;
    NSMutableArray *arrDirtinesNumber;
    NSString *strDirtinessValue;
    NSString *strPlayerGender;
   
    NSString *strGenderCode;
    int players;
    
    NSString *strFemaleTruthQuery;
    NSString *strFemaleDareQuery;
    NSString *strMaleTruthQuery;
    NSString *strMaleDareQuery;
    BOOL autoTruthFlag;
    DirtyViewController *dirtyView;
    
    UIDevice *thisDevice;
    
    NSString *strCheckLanguage;
    // MPAdView* mpAdView;
    Mopubclass *mopubclass;
}
//@property(nonatomic,retain) MPAdView* mpAdView;
@property(nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) NSString *strPlayerName;
@property (nonatomic, retain) NSString *strPlayerGender;
@property (nonatomic, retain) NSString *mode;
@property (nonatomic, retain)  NSString *strTruthMode;
@property(nonatomic, retain) NSString *strClean;
@property(nonatomic, retain) NSString *strDirty;
@property(nonatomic, retain) NSString *strSuperDirty;
@property(nonatomic, retain) NSString *strSource;
@property(nonatomic, retain) NSString *strGender;
@property(nonatomic,retain) NSString *strGenderCode;

@property(nonatomic, retain) NSString *strAlertMessage;
@property(nonatomic, retain) NSMutableDictionary* dictAlertMessage;
@property(nonatomic, retain) NSDictionary *dicSettings;
@property(nonatomic, retain) NSMutableArray *arrDirtinesNumber;
@property(nonatomic, retain) NSString *strFemaleTruthQuery;
@property(nonatomic, retain) NSString *strFemaleDareQuery;
@property(nonatomic, retain) NSString *strMaleTruthQuery;
@property(nonatomic, retain) NSString *strMaleDareQuery;
-(IBAction)PickmeBtnAction:(id)sender;
-(void)resetTruthCountOfPlayer;
-(void)increaseTruthCountOfPlayer;
-(void)resetDareCountOfPlayer;
-(void)checkForAutoTruth;
-(void)increaseDareCountOfPlayer;
-(IBAction)back:(id)sender;
-(IBAction)displayTruthOrDare:(id)sender;
-(NSString* )getDatabasePath;
-(NSString*)encodedString:(const unsigned char *)ch;
-(NSMutableArray *)executeQuery:(NSString*)str;
-(NSString *)getDirtinessString;
-(NSString *)getGenderString;
-(void)checkForSpeed;
-(void)increaseSpeedCountOfPlayer;
-(void)resetSpeedCountOfPlayer;
-(void)Buildin:(NSInteger)tag;
-(void)Minemode:(NSInteger)tag;
//-(void)checkminemode:(NSInteger)tag;
-(void)update_UI;
@end
