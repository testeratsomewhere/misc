//Edit Truth or Dare display

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "TruthOrDareAppDelegate.h"
#import "PersonCodeViewController.h"
@interface EditTruthOrDareViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, PersonCodeDelegate>
{
    IBOutlet UIButton *btnBack;
    IBOutlet UIButton *btnSave;
    IBOutlet UILabel *lblTitle;
    IBOutlet UITextView *txtEdit;
    IBOutlet UITableView *tblEdit;
    BOOL flagplayer;
    NSString *strBuiltin;
    NSString *strTitle;
    NSString *strValue;
    
    NSString *strPrimaryKey;
    NSString *strDirtiness;
    NSString *strGender;
    NSString *strPlayers;
    NSString *strActive;
    
    NSString *strOrigin;
    
    NSUInteger custom;
    
    NSString *strLastId;
    
    sqlite3 *database;
    TruthOrDareAppDelegate *appDelegate;
    
    NSString *strAlertMessage;
    NSMutableDictionary *dictAlertMessage;
    
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UIButton *btn4;
    UIButton *btn5;
    UIButton *btn6;
    BOOL flgpreview;
    
    BOOL flgCategory;
    NSString *strFirstCategory;
    NSString *strSecondCategory;
    NSString *strThirdCategory;
    NSInteger pktruthordare;
    BOOL flgPersonCode;
    NSRange textEditRange;
    IBOutlet UIView *alertview;
    IBOutlet UILabel *textview;
    IBOutlet UILabel *alerttitle;
    
    UIDevice *thisDevice;
    IBOutlet UIImageView *imgView;
    UIImage *imgText;

    NSString *strLocal;
    NSString *strTemp;
    
    IBOutlet UIButton *btnDeleteYes;
    IBOutlet UIButton *btnDeleteNo;
    
}
@property(nonatomic)NSInteger pktruthordare;
@property(nonatomic) NSUInteger custom;
@property (nonatomic, retain) NSString *strTitle;
@property (nonatomic, retain) NSString *strValue;
@property (nonatomic, retain) NSString *strPrimaryKey;
@property (nonatomic, retain) NSString *strDirtiness;
@property (nonatomic, retain) NSString *strGender;
@property (nonatomic, retain) NSString *strPlayers;
@property (nonatomic, retain) NSString *strActive;
@property (nonatomic, retain) NSString *strOrigin;
@property (nonatomic, retain) NSString *strLastId;

@property (nonatomic, retain) IBOutlet UIButton *btnBack;
@property (nonatomic, retain) IBOutlet UIButton *btnSave;
@property (nonatomic, retain) IBOutlet UILabel *lblTitle;
@property (nonatomic, retain) IBOutlet UITextView *txtEdit;
@property (nonatomic, retain) IBOutlet UITableView *tblEdit;

@property (nonatomic, retain) UIImage *imgText;
@property (nonatomic, retain) IBOutlet UIImageView *imgView;

-(NSString* )getDatabasePath;
-(NSString*)encodedString:(const unsigned char *)ch;
-(NSMutableArray *)executeQuery:(NSString*)str;
-(IBAction)back;
-(IBAction)save:(id)sender;
-(void)updateDatabase;
-(IBAction)YesbtnAction:(id)sender;
-(IBAction)NobtnAction:(id)sender;
-(void)update_UI;
-(void)getDatabasePathForAddingAndUpdating;


@end
