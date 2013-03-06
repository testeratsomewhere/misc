//Filter Setting Screen

#import <UIKit/UIKit.h>
#import "TruthOrDareAppDelegate.h"
@interface FilterViewController : UIViewController<UIScrollViewDelegate>
{
    IBOutlet UIButton *btnBack;
    IBOutlet UILabel *lblTitle;
    
    IBOutlet UILabel *lblDirtiness;
    IBOutlet UILabel *lblMin;
    IBOutlet UILabel *lblMax;
    IBOutlet UILabel *lblSource;
    IBOutlet UILabel *lblActive;
    IBOutlet UILabel *lblGender;
    TruthOrDareAppDelegate *appDelegate;
    NSString *strMin;
    NSString *strMax;
    
    NSDictionary *dictFilter;
    IBOutlet UIScrollView *scrollview;
    
    IBOutlet UIButton *btnMax1;
    IBOutlet UIButton *btnMax2;
    IBOutlet UIButton *btnMax3;
    IBOutlet UIButton *btnMax4;
    IBOutlet UIButton *btnMax5;
    IBOutlet UIButton *btnMax6;    
    IBOutlet UIButton *btnMin1;
    IBOutlet UIButton *btnMin2;
    IBOutlet UIButton *btnMin3;
    IBOutlet UIButton *btnMin4;
    IBOutlet UIButton *btnMin5;
    IBOutlet UIButton *btnMin6;
    NSString *strbuildin;
    NSString *strmine;
    NSString *stractive;
    NSString *strinactive;
    NSString *strbothsexes;
    NSString *strformales;
    NSString *strforfemales;
    
    IBOutlet UIButton *btnactive;
    IBOutlet UIButton *btninactive;
    IBOutlet UIButton *btnbuildin;
    IBOutlet UIButton *btnmine;
    IBOutlet UIButton *btnbothsexes;
    IBOutlet UIButton *btnformales;
    IBOutlet UIButton *btnforfemales;
    
    IBOutlet UILabel *lblactive;
    IBOutlet UILabel *lblinactive;
    IBOutlet UILabel *lblbuildin;
    IBOutlet UILabel *lblmine;
    IBOutlet UILabel *lblbothsexes;
    IBOutlet UILabel *lblformales;
    IBOutlet UILabel *lblforfemales;
    
    int minCount;
    int maxCount;
    
    UIDevice *thisDevice;
}

@property (nonatomic,retain) NSString *strMin;
@property (nonatomic,retain) NSString *strMax;
@property (nonatomic,retain) NSDictionary *dictFilter;
@property (nonatomic,retain) NSString *strbuildin;
@property (nonatomic,retain) NSString *strmine;
@property (nonatomic,retain) NSString *stractive;
@property (nonatomic,retain) NSString *strinactive;
@property (nonatomic,retain) NSString *strbothsexes;
@property (nonatomic,retain) NSString *strformales;
@property (nonatomic,retain) NSString *strforfemales;

-(IBAction)back;
-(IBAction)Sourcebtnaction:(id)sender;
-(IBAction)Activebtnaction:(id)sender;
-(IBAction)gender:(id)sender;
-(IBAction)setMax:(id)sender;
-(IBAction)setMin:(id)sender;
-(void)checkMin;
-(void)checkMax;

@end
