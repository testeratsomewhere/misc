

#import <UIKit/UIKit.h>
#import "SHK.h"

@class SHKFormController;

@interface SHKFormFieldCell : UITableViewCell 
{
	SHKFormFieldSettings *settings;
	
	CGFloat labelWidth;
	
	UITextField *textField;
	UISwitch *toggle;
	
	NSString *tmpValue;
	
	SHKFormController *form;
}

@property (retain) SHKFormFieldSettings *settings;

@property (nonatomic) CGFloat labelWidth;

@property (nonatomic, retain, getter=getTextField) UITextField *textField;
@property (nonatomic, retain) UISwitch *toggle;

@property (nonatomic, retain) NSString *tmpValue;

@property (nonatomic, assign) SHKFormController *form;

- (void)setValue:(NSString *)value;
- (NSString *)getValue;

@end
