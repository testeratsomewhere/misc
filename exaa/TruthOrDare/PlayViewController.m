


#import "PlayViewController.h"
#import "SelectionViewController.h"
#import "UserDefaultSettings.h"


@implementation PlayViewController

@synthesize viewPlayerName, lblName, lblPlayText;
@synthesize arrPlayerName, arrPlayerGender;
@synthesize contentView = _contentView;
@synthesize timer;

- (void)adViewDidFailToLoadAd:(MPAdView *)view
{
    NSLog(@"Failed");
}
- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGRect newFrame = view.frame;
    newFrame.size = size;
    newFrame.origin.x = (self.view.bounds.size.width - size.width) / 2;
    view.frame = newFrame;
     NSLog(@"sucsess");
}
- (void)willPresentModalViewForAd:(MPAdView *)view
{
    fromTestAdv = YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
   thisDevice = [UIDevice currentDevice];
    //[self.view addSubview:mopubclass.mpAdView];
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    dictTruthOrder = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    strOrder = [dictTruthOrder objectForKey:@"Takes True In Order"];
    if ([strOrder isEqualToString:@"ON"]) {
        playbtn.userInteractionEnabled=YES;
    }
    else
    {
       playbtn.userInteractionEnabled=NO; 
    }
   // _bannerView.userInteractionEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    mopubclass=[Mopubclass sharedInstance];
    CGRect frame = mopubclass.mpAdView.frame;
    CGSize size = [mopubclass.mpAdView adContentViewSize];
    frame.origin.y = self.view.bounds.size.height - size.height;
    mopubclass.mpAdView.frame = frame;
    [self.view addSubview:mopubclass.mpAdView];
	mopubclass.mpAdView.delegate = self;
	[mopubclass.mpAdView loadAd];
    
    [self update_UI];
    playbtn.enabled=YES ;
    if (!fromTestAdv) {
//        _bannerView.multipleTouchEnabled = NO;
//        _bannerView.userInteractionEnabled = NO;
       
        if ([strOrder isEqualToString:@"ON"]) 
        {
            playbtn.userInteractionEnabled=YES;
        }
        else
        {
            playbtn.userInteractionEnabled=NO; 
        }
        

        
        if(appDelegate.playerCount == [arrPlayerName count])
        {
            appDelegate.playerCount = 0;
        }
        
        if(appDelegate.playerCount < [arrPlayerName count])
        {
            lblName.text = [arrPlayerName objectAtIndex:appDelegate.playerCount];
        }
        else
        {
             appDelegate.playerCount = 0;
            lblName.text = [arrPlayerName objectAtIndex:appDelegate.playerCount];
        }
        
        
        lblPlayText.text=NSLocalizedString(@"It's your turn", @"");//[[NSString alloc]initWithString:NSLocalizedString(@"It's your turn", @"")];
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            self.viewPlayerName.frame = CGRectMake(-768, 100, 768, 435);
            self.viewPlayerName.hidden = YES;

            [lblPlayText setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:60.0]];
            [lblName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:60.0]];

        }
        else
        {
            self.viewPlayerName.frame = CGRectMake(-320, 60, 320, 200);
            self.viewPlayerName.hidden = YES;
            [lblPlayText setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
            [lblName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];

        }
        [lblPlayText setTextColor:[UIColor whiteColor]];
        [lblName setTextColor:[UIColor whiteColor]]; 

    }
}

-(void)viewDidAppear:(BOOL)animated
{
    if (!fromTestAdv) {
        
        self.viewPlayerName.hidden = NO;
        [self showPlayerName];
       // [self layoutAnimated:NO];
        
        if ([strOrder isEqualToString:@"ON"]) 
        {
            if(appDelegate.playerCount == [arrPlayerName count])
            {
                appDelegate.playerCount = 0;
            }
            
            if(appDelegate.playerCount < [arrPlayerName count])
            {
                lblName.text = [arrPlayerName objectAtIndex:appDelegate.playerCount];
            }
            
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [lblPlayText setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:60.0]];

            }
            else
            {
                [lblPlayText setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];

            }
            
            [lblPlayText setTextColor:[UIColor whiteColor]];
            //  _bannerView.userInteractionEnabled = YES;
        }
        else // random robin fashion
        {
            [self showPlayerNameInRandomFashion];        
        }
        }
    fromTestAdv = NO;

}
//Player Animation Methods
#pragma mark Rotate methods
-(NSMutableArray*)jummbleArray:(NSMutableArray *)array
{
    NSMutableArray *anotherArr = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    NSMutableArray *jumbledArray = [[NSMutableArray alloc] init];
    NSUInteger num = 0;
    
    while (num < [array count]) {
        NSUInteger no = arc4random() % [anotherArr count];
        
        [jumbledArray addObject:[anotherArr objectAtIndex:no]];
        [anotherArr removeObjectAtIndex:no];
         num ++;
    }
    return [jumbledArray autorelease];
}               
                 
-(void)onTimer
{
    if (number < [jumbleArray count])
    {
        lblName.text = [jumbleArray objectAtIndex:number];
        number ++;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            lblName.frame = CGRectMake(-300, 160, 0, 80);
        }
        else
        {
            lblName.frame = CGRectMake(-130, 19, 0, 50);
        }
        
        lblName.alpha = 1.0;
      
        [UIView beginAnimations:@"AnimateIn" context:nil];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration: 0.3];
        [UIView setAnimationCurve: UIViewAnimationCurveLinear];
        [UIView setAnimationDidStopSelector:@selector(rotateplayername)];
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lblName.frame = CGRectMake(40, 160, 700, 80);
        }
        else
        {
            lblName.frame = CGRectMake(10, 19, 300, 50);
        }
        
        [UIView commitAnimations];

        }
    else   
    {
        [timer invalidate];
        self.timer = nil;
        lblName.alpha = 1.0; 
        
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            lblName.frame = CGRectMake(-300, 160, 0, 80);
        }
        else
        {
            lblName.frame = CGRectMake(-130, 19, 0, 50);
        }

        [UIView beginAnimations:@"AnimateIn" context:nil];
        [UIView setAnimationCurve: UIViewAnimationCurveLinear];
        [UIView setAnimationDuration: 0.5];

        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(playerLabelAnimationCompleted)];
        
        lblName.text = urTurnPlayer;
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lblName.frame = CGRectMake(40, 160, 700, 80);
        }
        else
        {
            lblName.frame = CGRectMake(10, 19, 300, 50);
        }

        [UIView commitAnimations];
        
        for (int i = 0; i<[appDelegate.stackArr count]; i++) {
            if ([[appDelegate.stackArr objectAtIndex:i] isEqualToString:urTurnPlayer])
            {
                appDelegate.playerCount = i;
                break;
            }
        }
        
    }
    
}
-(void)playerLabelAnimationCompleted
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.lblName cache:NO];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [UIView commitAnimations];
    lblPlayText.hidden=NO;
     playbtn.userInteractionEnabled=YES;
     //_bannerView.userInteractionEnabled = YES;
}
-(void)rotateplayername
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationTransition: UIViewAnimationTransitionFlipFromRight forView:self.lblName cache:NO];
    lblName.alpha = 0.0; 
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.20];
    [UIView commitAnimations];

}

-(void)showPlayerNameInRandomFashion
{
    lblPlayText.hidden = YES;
    number = 0;
    if ([appDelegate.stackArr count]==0)
    {
        appDelegate.stackArr = [NSMutableArray arrayWithArray:arrPlayerName];
        appDelegate.stackGenderArr = [NSMutableArray arrayWithArray:arrPlayerGender];
    }
    
    jumbleArray = [[self jummbleArray:appDelegate.stackArr] retain];
    
    NSUInteger nowShowNo=0;
    urTurnPlayer = nil;
    
    if ([jumbleArray count]>0) {
        nowShowNo = arc4random() % [jumbleArray count];
        
        urTurnPlayer = [[NSString alloc] initWithFormat:@"%@",[jumbleArray objectAtIndex:nowShowNo]];
        
        [jumbleArray removeObjectAtIndex:nowShowNo];
    }

    
    self.timer = [NSTimer timerWithTimeInterval:0.5
                                    target:self 
                                  selector:@selector(onTimer) 
                                  userInfo:nil 
                                   repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [timer fire];
    
    
}


#pragma mark custom methods

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnPlay = nil;
    NSString *str=nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        str=[NSString stringWithFormat:@"play_btn_iPad_%@",CurrentLang];
        imgBtnPlay = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
        [playbtn setImage:imgBtnPlay forState:UIControlStateNormal];
    }
    else
    {
        str=[NSString stringWithFormat:@"play_%@",CurrentLang];
        imgBtnPlay = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
        [playbtn setImage:imgBtnPlay forState:UIControlStateNormal];        
    }
    str=nil;
    [str release];
}



-(void) showPlayerName
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.viewPlayerName.frame = CGRectMake(0,100,768,400);
    }
    else
    {
        self.viewPlayerName.frame = CGRectMake(0,60,320,200);
    }
    
    [UIView commitAnimations];

}
//go to  Display Player Name screen Method
#pragma mark custom methods
-(IBAction)back:(id)sender
{
    appDelegate.playerCount = 0;
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(IBAction)selection:(id)sender
{
    playbtn.enabled=NO;
    CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:self.viewPlayerName cache:NO];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	[UIView commitAnimations];
    
    self.viewPlayerName.hidden = YES;
    
    [self performSelector:@selector(pushSelectionView) withObject:nil afterDelay:0.5];
    
    
}
//go to  Select Truth or Dare Display screen Method
-(void)pushSelectionView
{
    
    SelectionViewController *selectObj;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        selectObj =  [[SelectionViewController alloc] initWithNibName:@"SelectionViewController_iPad" bundle:nil];
    }
    else
    {
        selectObj =  [[SelectionViewController alloc] initWithNibName:@"SelectionViewController" bundle:nil];
    }
   
    
    
    if([strOrder isEqualToString:@"ON"])
    {
        if ([self.arrPlayerName count]>appDelegate.playerCount) {
            selectObj.strPlayerName = [self.arrPlayerName objectAtIndex:appDelegate.playerCount];
            selectObj.strPlayerGender = [self.arrPlayerGender objectAtIndex:appDelegate.playerCount];
            appDelegate.strCurrentPlayerName = [self.arrPlayerName objectAtIndex:appDelegate.playerCount];
            appDelegate.strCurrentPlayerGender = [self.arrPlayerGender objectAtIndex:appDelegate.playerCount];
            
            appDelegate.playerCount = appDelegate.playerCount + 1;
        }
        else
        {
           
            appDelegate.playerCount=0;
            selectObj.strPlayerName = [self.arrPlayerName objectAtIndex:appDelegate.playerCount];
            selectObj.strPlayerGender = [self.arrPlayerGender objectAtIndex:appDelegate.playerCount];
            appDelegate.strCurrentPlayerName = [self.arrPlayerName objectAtIndex:appDelegate.playerCount];
            appDelegate.strCurrentPlayerGender = [self.arrPlayerGender objectAtIndex:appDelegate.playerCount];
        }
        
    }
    else
    {
        selectObj.strPlayerName = [appDelegate.stackArr objectAtIndex:appDelegate.playerCount];
        selectObj.strPlayerGender = [appDelegate.stackGenderArr objectAtIndex:appDelegate.playerCount];
        appDelegate.strCurrentPlayerName = [appDelegate.stackArr objectAtIndex:appDelegate.playerCount];
        appDelegate.strCurrentPlayerGender = [appDelegate.stackGenderArr objectAtIndex:appDelegate.playerCount];
        
        [appDelegate.stackArr removeObjectAtIndex:appDelegate.playerCount];
        [appDelegate.stackGenderArr removeObjectAtIndex:appDelegate.playerCount];
        
    }
    
    [self.navigationController pushViewController:selectObj animated:YES];
    [selectObj release];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)dealloc
{
    //[mopubclass.mpAdView release];
    //_bannerView.delegate = nil;
    mopubclass.mpAdView.delegate=nil;
    [jumbleArray release];     
    [urTurnPlayer release];
    
    [viewPlayerName release];
    [lblName release];
    [lblPlayText release];
    if (timer) {
        [timer invalidate];
        self.timer = nil;
    }
    [playbtn release];

    
    [super dealloc];
}

@end
