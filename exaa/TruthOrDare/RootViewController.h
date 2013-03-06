
//Display Player Name screen 
#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"



@interface RootViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tblPlayer;
    IBOutlet UITextField *txtPlayerName;
    IBOutlet UIButton *btnAddPlayer;
    
    IBOutlet UIButton *settingbtn;
    NSMutableArray *arrPlayers;
    NSMutableArray *arrPlayersGender;
    
    NSArray *arrPlayerName;
    NSArray *arrPlayerGender;
    
    NSString *strAlertMessage;
    NSMutableDictionary* dictAlertMessage;
    
    sqlite3 *database;
    sqlite3 *databaseOLD;
    IBOutlet UIButton *playbtn;
    TruthOrDareAppDelegate *appDelegate;
    IBOutlet UIView *alertview;
    IBOutlet UILabel *textview;
    IBOutlet UILabel *alerttitle;
    IBOutlet UILabel *lbltitle;
    
    IBOutlet UIView *alertforcouple;
    IBOutlet UILabel *alertforcoupletextview;
    IBOutlet UILabel *couplealerttitle;
    //IBOutlet UILabel *alertforcoupletitle;
    UIDevice *thisDevice;
    NSString *name;
    
    NSString *strLocal;
    
    IBOutlet UIButton *btnAddYes;
    IBOutlet UIButton *btnAddNo;
    IBOutlet UIButton *btnChangeYes;
    IBOutlet UIButton *btnChangeNo;

    IBOutlet UIButton *btnHeyZap;
    
    IBOutlet UIImageView *imgView;
    
    IBOutlet UIActivityIndicatorView *dbActivityIndicator;
    
    NSMutableArray *arrCustomTruths;
    NSMutableArray *arrCustomDares;
    

}
@property (nonatomic, retain) IBOutlet UITableView *tblPlayer;
@property (nonatomic, retain) IBOutlet UITextField *txtPlayerName;
@property (nonatomic, retain) IBOutlet UIButton *btnAddPlayer;

@property (nonatomic, retain) NSMutableArray *arrPlayers;
@property (nonatomic, retain) NSMutableArray *arrPlayersGender;


-(IBAction)addPlayer;
-(void)changesettings;
-(IBAction)play;
-(BOOL)checkNameExistence;
-(IBAction)goToSettings;
-(IBAction)YesbtnAction:(id)sender;
-(IBAction)NobtnAction:(id)sender;
-(IBAction)YesbtnActionforSetting:(id)sender;
-(IBAction)NobtnActionforSetting:(id)sender;
-(void)update_UI;

- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
-(void)initializeOldDatabase;
-(NSMutableArray *)executeQuery:(NSString*)str;

-(NSString*)encodedString:(const unsigned char *)ch;
-(NSString* )getOLDDatabasePath;
-(NSString* )getNEWDatabasePath;
-(void)insertCustomTruthsIntoNewDB;
-(void)insertCustomDaresIntoNewDB;
-(void)fetchCustomTruths;
-(void)fetchCustomDares;
-(IBAction)HeyBtnAction:(id)sender;
@end
