//Person code Selection screen
#import <UIKit/UIKit.h>

@protocol PersonCodeDelegate;

typedef enum
{
    PersonCodeX = 0,
    PersonCodeXY = 1,
    PersonCodeXX = 2,
    PersonCodeX2 = 3,
    PersonCodeXY2 =4,
    PersonCodeXX2 = 5,
}PersonCodeType;

typedef enum
{
    MultipleCodeHe = 11,
    MultipleCodeHis = 12,
    MultipleCodeHim = 13,
}MultipleCodeType;

@interface PersonCodeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    id <PersonCodeDelegate> delegate;
    NSString *strPassedCode;
    NSString *strRecievedMessage;
    
    IBOutlet UITableView *tblPersonCode;
    IBOutlet UITableView *tblSelectCode;
    
    NSMutableArray *arrCode;
    NSMutableArray *arrCodeCopy;
    
    PersonCodeType selectedPersonCode;
    MultipleCodeType selectedMultipleType;
    
    UIDevice *thisDevice;
}

@property (nonatomic, retain) id <PersonCodeDelegate> delegate;
@property (nonatomic, retain) NSString *strPassedCode;
@property (nonatomic, retain)  NSString *strRecievedMessage;
-(IBAction)back:(id)sender;
-(NSString *)determineSelectionCode:(PersonCodeType)personCode;
-(NSString *)determineSelectCodeString:(PersonCodeType)personCode;
-(NSString *)determineMultipleSelectionCode:(MultipleCodeType)multipleType;
@end

@protocol PersonCodeDelegate
- (void)PersonCodeViewControllerDidFinish:(PersonCodeViewController *)controller;
-(void)addPersonCodeAtTheProperRange:(NSString *)prsnCode andPop:(PersonCodeViewController *)controller;
@end
