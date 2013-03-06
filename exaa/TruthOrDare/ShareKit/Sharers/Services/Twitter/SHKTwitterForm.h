

#import <UIKit/UIKit.h>


@interface SHKTwitterForm : UIViewController <UITextViewDelegate>
{
	id delegate;
	UITextView *textView;
	UILabel *counter;
	BOOL hasAttachment;
}

@property (nonatomic, retain) id delegate;
@property (nonatomic, retain) UITextView *textView;
@property (nonatomic, retain) UILabel *counter;
@property BOOL hasAttachment;

- (void)layoutCounter;

@end
