

#import <UIKit/UIKit.h>
#import "SHKFormFieldSettings.h"
#import "SHKCustomFormFieldCell.h"

@interface SHKFormController : UITableViewController <UITextFieldDelegate>
{
	id delegate;
	SEL validateSelector;
	SEL saveSelector;	
	
	NSMutableArray *sections;
	NSMutableDictionary *values;
	
	CGFloat labelWidth;
	
	UITextField *activeField;
	
	BOOL autoSelect;
}

@property (retain) id delegate;
@property SEL validateSelector;
@property SEL saveSelector;

@property (retain) NSMutableArray *sections;
@property (retain) NSMutableDictionary *values;

@property CGFloat labelWidth;

@property (nonatomic, retain) UITextField *activeField;

@property BOOL autoSelect;


- (id)initWithStyle:(UITableViewStyle)style title:(NSString *)barTitle rightButtonTitle:(NSString *)rightButtonTitle;
- (void)addSection:(NSArray *)fields header:(NSString *)header footer:(NSString *)footer;

#pragma mark -

- (SHKFormFieldSettings *)rowSettingsForIndexPath:(NSIndexPath *)indexPath;

#pragma mark -
#pragma mark Completion

- (void)close;
- (void)cancel;
- (void)validateForm;
- (void)saveForm;

#pragma mark -

- (NSMutableDictionary *)formValues;
- (NSMutableDictionary *)formValuesForSection:(int)section;

@end
