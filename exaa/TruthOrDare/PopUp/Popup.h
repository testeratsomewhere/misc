



#define kPopupMessage				@"Popup Message"
#define kPopupMessageTakePicture	@"Popup Message Take Picture"
#define kPopupMessageSuspend		@"Popup Message Suspend"
#define kPopupMessageLocation		@"Popup Message Location"
#define kPopupMessageError          @"Popup Message Error"
#define kPopupYesMessage			@"Popup Yes Message"
#define kPopupOkMessage				@"Popup Ok Message"
#define kPopupYesNoSuspendMessage	@"Popup Yes No Suspend Message"
#define kPopupMessageType           @"Popup Image Type"
#import <UIKit/UIKit.h>

@interface Popup : UIViewController
{
	IBOutlet UIImageView*	Imgview_m_background;
	IBOutlet UIView* View_holder_background;
	IBOutlet UILabel* LblpopupMessage;
	IBOutlet UIButton* button1;
	IBOutlet UIButton* button2;
	NSString *StradditionalMessage;
	
	NSDictionary*			Dicm_message;
	CGRect					m_normalFrame;
	id						m_delegate;
	
	UIView *bgView;
	NSString *Strtype;
	NSString *nib_name;
    
    IBOutlet UIImageView *popUpImage;
    
    UIDevice *thisDev;
}

@property (nonatomic, assign) NSDictionary* message;
@property (nonatomic, assign) id delegate;
//@property (assign) id<PopupViewControllerDelegate> delegate;

@property (nonatomic, assign) IBOutlet UILabel* LblpopupMessage;
@property (nonatomic, assign) UIView *bgView;
@property (nonatomic, assign) NSString *StradditionalMessage;
@property (nonatomic, assign) NSString* Strtype;
@property (nonatomic, assign) IBOutlet UIView* View_holder_background;
@property (nonatomic, assign) IBOutlet UIButton* button1;
@property (nonatomic, assign) IBOutlet UIButton* button2;
@property (nonatomic, retain) IBOutlet UIImageView *popUpImage;

- (IBAction)dismissAndNotify:(id)sender;
- (IBAction)dismissAndStop:(id)sender;
+ (void)popUpWithMessage:(NSDictionary*)message delegate:(id)delegate withType:(NSString*)type;
- (IBAction)decide:(id)sender;
@end


@protocol PopupViewControllerDelegate

- (void)popupViewControllerDidClose:(NSString*)actionType withResponse:(BOOL)response;

@end


