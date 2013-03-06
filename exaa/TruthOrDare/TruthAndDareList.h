//Truth and dare list screen

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"
#import "Mopubclass.h"

@interface TruthAndDareList : UIViewController <UITableViewDelegate, UITableViewDataSource,MPAdViewDelegate>
{
    IBOutlet UITableView *tblTruth;
    TruthOrDareAppDelegate *appDelegate;
   
    NSMutableArray *arrTruth;

    NSMutableArray *arrDare;

    IBOutlet UIActivityIndicatorView *activity;
   sqlite3 *database;
    BOOL flgTruth;
    BOOL flgDare;
    BOOL  refresh;
    
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnTruth;
    IBOutlet UIButton *btnDare;
    
    UIDevice *thisDevice;
    IBOutlet UIImageView *imgTitle;
    
    IBOutlet UIButton *btnAdd;
    IBOutlet UIButton *btnFilter;

    NSUserDefaults *defaults;
    NSArray *languages;
    NSString *currentLanguage;
    Mopubclass *mopubclass;
    NSString *strTitle;
    //Spinner *spinner;
}
@property (nonatomic,retain) NSMutableArray *arrDare;
@property (nonatomic,retain) NSMutableArray *arrTruth;
@property(nonatomic, strong) IBOutlet UIView *contentView;
-(NSMutableArray *)executeQuery:(NSString*)str;
-(NSString* )getDatabasePath;
-(NSString*)encodedString:(const unsigned char *)ch;
-(IBAction)truthList;
-(IBAction)dareList;

-(void)getTruthList;
-(void)getDareList;
-(NSString *)getDirtinessString:(NSString *)stingmax:(NSString *)stringmin;
-(IBAction)back;
-(IBAction)filter;
-(IBAction)add;
-(void)update_UI;
- (void)layoutAnimated:(BOOL)animated;
@end
