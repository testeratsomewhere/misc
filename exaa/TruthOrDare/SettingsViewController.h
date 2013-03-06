//Setting  screen 

#import <UIKit/UIKit.h>
#import "TruthOrDareAppDelegate.h"
#import "SettingsSegmentCustomCell.h"
#import "Popup.h"
@interface SettingsViewController : UIViewController <SettingsSegmentDelegate, UITableViewDelegate, UITableViewDataSource, UIPopoverControllerDelegate>
{
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnAddDare;
    IBOutlet UITableView *tblSettings;
    IBOutlet UILabel *lblTitle;
    
    NSString *strTakesTrueInOrder;
    NSString *strMyDaresOnly;
    NSString *strAllowChangingDares;
    
    NSString *strAlertMessage;
    NSMutableDictionary* dictAlertMessage;
    
    NSString *strClean;
    NSString *strDirty;
    NSString *strSuperDirty;
    
    NSString *strTruthMode;
    NSString *strSpeed;
    NSString *strAutoTruth;
    NSString *strLanguage;
    
    UIDevice *thisDevice;
    NSDictionary *dictSettings;
    
    BOOL flgSpeed;
    BOOL flgAutoTruth;
    BOOL flagAutoTruth;
    BOOL flagLang;
    NSString *strSound1;
    NSString *strTemp;
    NSMutableArray *arrLang;
    TruthOrDareAppDelegate *appDelegate;
    UIPopoverController *popoverController;
    
   // NSArray *popoverValuesArr;
}

@property (nonatomic,retain) NSString *strSound1;
@property (nonatomic,readwrite) BOOL flagAutoTruth;
@property (nonatomic,retain) NSString *strTakesTrueInOrder;
@property (nonatomic,retain) NSString *strMyDaresOnly;
@property (nonatomic,retain) NSString *strAllowChangingDares;

@property (nonatomic,retain) NSString *strAlertMessage;
@property (nonatomic,retain) NSMutableDictionary* dictAlertMessage;

@property (nonatomic,retain) NSString *strClean;
@property (nonatomic,retain) NSString *strDirty;
@property (nonatomic,retain) NSString *strSuperDirty;

@property (nonatomic,retain) NSString *strTruthMode;
@property (nonatomic,retain) NSString *strSpeed;
@property (nonatomic,retain) NSString *strAutoTruth;
@property (nonatomic,retain) NSString *strLanguage;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic,retain) NSDictionary *dictSettings;

-(IBAction)back;
-(IBAction)addDare;
-(void)update_UI;
-(SettingsSegmentCustomCell *)setCellForiPhone:(SettingsSegmentCustomCell *)cell:(CGSize)size;
-(SettingsSegmentCustomCell *)setCellForiPad:(SettingsSegmentCustomCell *)cell :(CGSize)size;
@end
