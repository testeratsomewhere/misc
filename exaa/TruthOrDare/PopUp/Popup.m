




#import "Popup.h"
#import "UIView-AlertAnimations.h"
#import "TruthOrDareAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
@implementation Popup

@synthesize message = Dicm_message;
@synthesize delegate = m_delegate;
@synthesize LblpopupMessage,StradditionalMessage;
@synthesize bgView;
@synthesize Strtype;
@synthesize View_holder_background;
@synthesize button1, button2;
@synthesize popUpImage;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
	
	thisDev = [UIDevice currentDevice];
    if(thisDev.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        nib_name = @"Popup_iPad";
    }
    else
    {
        nib_name = @"Popup";
	
    }
    if ( self == [super initWithNibName: nib_name bundle: nibBundleOrNil] )
    {
        self.wantsFullScreenLayout = YES;
    }
    return self;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
		return NO;
}

#pragma mark - Animation
- (void)startBorderedViewAnimation2
{
	[UIView beginAnimations: @"Border View Animation 2" context: NULL];
	[UIView setAnimationDuration: 0.1];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(animationDidStop:finished:context:)];
	Imgview_m_background.frame = m_normalFrame;
	[UIView commitAnimations];
}

- (void)animationDidStop:(NSString*)animationID finished:(NSNumber*)finished context:(void*)context
{
	if ( [animationID isEqualToString: @"Border View Animation 1"] )
		[self startBorderedViewAnimation2];
}

- (void)animateFadeOut
{
	[UIView beginAnimations: @"fade out" context: NULL];
	[UIView setAnimationDuration: 0.5];
	[UIView setAnimationDelegate: self];
	[UIView setAnimationDidStopSelector: @selector(animateFadeOutEnded)];
	self.view.alpha = 0.0;
	[UIView commitAnimations];
}

- (void) animateFadeOutEnded {
	[self.view removeFromSuperview];
	[self release];
}

- (void)close:(id)sender
{ 
	BOOL answer;
	answer = NO;
	if ([sender class] == [UIButton class]) {
		if (((UIButton*)sender).tag == 0) {//X mark on the popup
			answer = NO;
		} else if (((UIButton*)sender).tag == 1) {//the first on the bottom
			answer = YES;
		} else if (((UIButton*)sender).tag == 2) {//the second button on the bottom - not yet used
			answer = YES;
		} 		
	}
	
	if ( [m_delegate respondsToSelector: @selector(popupViewControllerDidClose:withResponse:)] ){
		[(id<PopupViewControllerDelegate>) m_delegate popupViewControllerDidClose: self.Strtype withResponse:answer];
	} else {
	}
	[self animateFadeOut];
}


#pragma mark -

- (IBAction)decide:(id)sender
{
	
	if (self.delegate == nil) {
		[self dismissAndStop:sender];
	} else {
		[self dismissAndNotify:sender];
	}
	 
	
}

- (IBAction)dismissAndStop:(id)sender
{
	[self animateFadeOut];
	
}

- (IBAction)dismissAndNotify:(id)sender
{
	[self close:(id)sender];
	
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    if(thisDev.userInterfaceIdiom == UIUserInterfaceIdiomPad)
//    {
//        [LblpopupMessage setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
//        
//    }
//    else
//    {
//        [LblpopupMessage setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:13.0]];
//        
//    }
//}
- (void)viewDidLoad
{
	[super viewDidLoad];
	
    
	self.button2.hidden = YES;
	
	if ([self.Strtype isEqualToString:kPopupMessageTakePicture]) {
		if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
			} else {//no camera is available, display the 'Choose Existing' button
			}


	} else if ([self.Strtype isEqualToString:kPopupMessageLocation] || [self.Strtype isEqualToString:kPopupMessageSuspend]) {
		[self.button1 setImage:[UIImage imageNamed:@"opt_search_profile_with_photo_off.png"] forState: UIControlStateNormal];
		[self.button1 setImage:[UIImage imageNamed:@"opt_search_profile_with_photo_on.png"] forState: UIControlStateHighlighted];
	}
	else if ([self.Strtype isEqualToString:kPopupYesMessage]) {
		[self.button1 setImage:[UIImage imageNamed:@"btn_yes.png"] forState: UIControlStateNormal];
		[self.button1 setFrame:CGRectMake(104, 315, 111, 44)];
	}
	else if ([self.Strtype isEqualToString:kPopupOkMessage]) {
		[self.button1 setImage:[UIImage imageNamed:@"btn_ok_popup.png"] forState: UIControlStateNormal];
	}
	else if ([self.Strtype isEqualToString:kPopupYesNoSuspendMessage]) {
		[self.button1 setImage:[UIImage imageNamed:@"btn_popup_yes.png"] forState:UIControlStateNormal];
		[self.button2 setImage:[UIImage imageNamed:@"btn_popup_no.png"] forState:UIControlStateNormal];
		[self.button1 setFrame:CGRectMake(69, 323, 93, 31)];
		[self.button2 setFrame:CGRectMake(161, 323, 93, 31)];
		self.button2.hidden = NO;
	}

	self.button1.contentMode = UIViewContentModeCenter;
	m_normalFrame = Imgview_m_background.frame;	

	CGRect frame = self.view.frame;
    
	self.bgView = [[[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, frame.size.width, frame.size.height + 20.0)]autorelease];
	self.bgView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.7];
	[self.view addSubview:self.bgView];
	
	[self.view addSubview:View_holder_background];
	
    thisDev = [ UIDevice currentDevice];
    if(thisDev.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [LblpopupMessage setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
        if (![CurrentLang isEqualToString:@"en"]) 
             popUpImage.image = [UIImage imageNamed:@"logo_iPad.png"];
        else
            popUpImage.image = [UIImage imageNamed:@"logo_iPad.png"];
    }
    else
    {
        [LblpopupMessage setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:17.0]];
        
        if (![CurrentLang isEqualToString:@"en"]) 
            popUpImage.image = [UIImage imageNamed:@"logo.png"];
        else
            popUpImage.image = [UIImage imageNamed:@"logo.png"];

    }
       [LblpopupMessage setTextColor:[UIColor whiteColor]];
	self.LblpopupMessage.text = [Dicm_message objectForKey:kPopupMessage];
	[View_holder_background doPopInAnimationX];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    
}
- (void)dealloc
{
	self.message = nil;
	self.delegate = nil;
	[super dealloc];
	
}

#pragma mark -

+ (void)popUpWithMessage:(NSDictionary*)message delegate:(id)delegate withType:(NSString*) type
{

	TruthOrDareAppDelegate *appDelegate = (TruthOrDareAppDelegate *)[UIApplication sharedApplication].delegate;
	UIWindow* win = appDelegate.window;
	Popup* viewCtrl = nil;
	if (YES) {
        
        UIDevice* thisDevice = [UIDevice currentDevice];
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            // iPad
            viewCtrl = [[Popup alloc] initWithNibName: @"Popup_iPad" bundle: nil];	
        }
        else
        {
            // iPhone
            viewCtrl = [[Popup alloc] initWithNibName: @"Popup" bundle: nil];
            
        }
				
	} 
	viewCtrl.Strtype = type;
	viewCtrl.message = message;
	viewCtrl.delegate = delegate;
    
    
	[win addSubview: viewCtrl.view];
}

@end
