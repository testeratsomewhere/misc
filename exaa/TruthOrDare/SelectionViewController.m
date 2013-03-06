

#import "SelectionViewController.h"
#import "TruthOrDareDisplayView.h"
#import "DirtyViewController.h"
#import "UserDefaultSettings.h"
#import "TruthOrDareAppDelegate.h"
#import "Popup.h"
@implementation SelectionViewController
@synthesize strPlayerName;
@synthesize strPlayerGender;
@synthesize mode;
@synthesize contentView = _contentView;
@synthesize strTruthMode;
@synthesize strClean;
@synthesize strDirty;
@synthesize strSuperDirty;
@synthesize strSource;
@synthesize strGender;
@synthesize strAlertMessage;
@synthesize dictAlertMessage;
@synthesize dicSettings;
@synthesize arrDirtinesNumber;
@synthesize strFemaleDareQuery;
@synthesize strFemaleTruthQuery;
@synthesize strMaleDareQuery;
@synthesize strMaleTruthQuery;
@synthesize strGenderCode;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
// check All Truth and All Dare  count
-(void)checkForAutoTruth
{
    NSMutableDictionary *currentPlayerDict = nil;
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        NSUInteger autoTruthCount = [[dicSettings objectForKey:@"Auto Truth"] intValue];
        
        NSUInteger dareNumber = [[currentPlayerDict objectForKey:@"DareNumber"] intValue];
        NSUInteger truthNumber = [[currentPlayerDict objectForKey:@"TruthNumber"] intValue];
        
        if (autoTruthCount == dareNumber) {
            self.strTruthMode = @"All Truth";
            [currentPlayerDict setObject:[NSString stringWithFormat:@"0"] forKey:@"DareNumber"];
        }
        
        if (autoTruthCount==truthNumber) {
            self.strTruthMode = @"All Dare";
            [currentPlayerDict setObject:[NSString stringWithFormat:@"0"] forKey:@"TruthNumber"];
        }
    }
}
// check Speed  count
-(void)checkForSpeed
{
    NSMutableDictionary *currentPlayerDict = nil;
    BOOL checkspeed=NO;
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        //--------Speed-------
        NSUInteger Speed=[[dicSettings objectForKey:@"Speed"] intValue];
        for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
            NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
            NSInteger SpeedNumber=[[dict objectForKey:@"SpeedNo"] integerValue];
            if (Speed<=SpeedNumber) 
            {
                checkspeed=YES;
            }
            else
            {
                checkspeed=NO;
                break;
            }
        }
        if (checkspeed==YES) {
            
            
            NSMutableArray *Array=[NSMutableArray arrayWithArray:appDelegate.arrDirtinesNumber];
            [Array removeObject:@"0"];
            NSString *strvalue=[Array lastObject];
            NSString *currentobject;
            if ([self.strSource isEqualToString:@"1"]) {
                
                currentobject=[NSString stringWithFormat:@"%d",appDelegate.dirtystartValueformine];
            }
            else
            {
                currentobject=[NSString stringWithFormat:@"%d",appDelegate.dirtystartValue];
            }
            
            if (![currentobject isEqualToString:strvalue]) {
                NSInteger indexValue=[Array indexOfObject:currentobject];
                indexValue++;
                NSString *strvalue1=[Array objectAtIndex:indexValue];
                appDelegate.dirtystartValue=strvalue1.integerValue;  
                appDelegate.dirtystartValueformine=strvalue1.integerValue;  
                if (appDelegate.dirtystartValue>=appDelegate.Dirtyvalue) {
                    appDelegate.Dirtyvalue=appDelegate.dirtystartValue;
                    
                    
                }
                if (appDelegate.dirtystartValueformine>=appDelegate.Dirtyvalue) {
                    appDelegate.Dirtyvalue=appDelegate.dirtystartValueformine;
                }
            }
            else
            {
                
                appDelegate.Dirtyvalue=strvalue.integerValue;
                
            }
            if([appDelegate.arrDelegateMaleDare count] > 0)
            {
                [appDelegate.arrDelegateMaleDare removeAllObjects];
                [appDelegate.arrMaleDareChallengeId removeAllObjects];
            }
            if([appDelegate.arrDelegateMaleTruth count] > 0)
            {
                [appDelegate.arrDelegateMaleTruth removeAllObjects];
                [appDelegate.arrMaleTruthChallengeId removeAllObjects];
            }
            if([appDelegate.arrDelegateFemaleDare count] > 0)
            {
                [appDelegate.arrDelegateFemaleDare removeAllObjects];
                [appDelegate.arrFemaleDareChallengeId removeAllObjects];
            }
            if([appDelegate.arrDelegateFemaleTruth count] > 0)
            {
                [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                [appDelegate.arrFemaleTruthChallengeId removeAllObjects];
            }
            
            for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
                NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
                [dict setObject:@"0" forKey:@"SpeedNo"];
            }
            BOOL flagroud=NO;
            NSUInteger Speed1=1;
            for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
                NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
                NSInteger SpeedNumber=[[dict objectForKey:@"SpeedNo"] integerValue];
                if (Speed1==SpeedNumber) {
                    flagroud=YES;
                }
                else
                {
                    flagroud=NO;
                    break;
                }
                if (flagroud==YES)
                {
                    if([appDelegate.arrDelegateMaleDare count] > 0)
                    {
                        [appDelegate.arrDelegateMaleDare removeAllObjects];
                        [appDelegate.arrMaleDareChallengeId removeAllObjects];
                    }
                    if([appDelegate.arrDelegateMaleTruth count] > 0)
                    {
                        [appDelegate.arrDelegateMaleTruth removeAllObjects];
                        [appDelegate.arrMaleTruthChallengeId removeAllObjects];
                    }
                    if([appDelegate.arrDelegateFemaleDare count] > 0)
                    {
                        [appDelegate.arrDelegateFemaleDare removeAllObjects];
                        [appDelegate.arrFemaleDareChallengeId removeAllObjects];
                    }
                    if([appDelegate.arrDelegateFemaleTruth count] > 0)
                    {
                        [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                        [appDelegate.arrFemaleTruthChallengeId removeAllObjects];
                    }
                }
            }
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisDevice = [ UIDevice currentDevice];
    
   // [self.view addSubview:mopubclass.mpAdView];
    strDirtinessValue = [[NSString alloc] init];
    if ([CurrentLang isEqualToString:@"en"])
    {
       strCheckLanguage = @"ln_EN";
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strCheckLanguage = @"ln_ES";
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strCheckLanguage = @"ln_FR";
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
       strCheckLanguage = @"ln_DE";
    } 
    
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
    btnTruth.enabled=YES;
    btnDare.enabled=YES;
    
    appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    self.dicSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    autoTruthFlag = [[dicSettings objectForKey:@"AutoTruthFlag"] boolValue];
    self.strTruthMode = [dicSettings objectForKey:@"Truth Mode"];
    self.strClean = [dicSettings objectForKey:@"Clean"];
    self.strDirty = [dicSettings objectForKey:@"Dirty"];
    self.strSuperDirty = [dicSettings objectForKey:@"Super Dirty"];
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:60.0]];
    }
    else
    {
        [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
    }
    [lblPlayerName setTextColor:[UIColor whiteColor]]; 
    lblPlayerName.text = strPlayerName;
    NSString *strType = [dicSettings objectForKey:@"My Dares Only"];
    if([strType isEqualToString:@"ON"])
    {
        self.strSource = @"1";
      
        appDelegate.Dirtyvalue=appDelegate.dirtystartValueformine;
    }
    else
        self.strSource = @"0";
    
    [self checkForSpeed];
    
    if (autoTruthFlag)
    {
        [self checkForAutoTruth];
    }
    
    //setting the gender
    if([self.strPlayerGender isEqualToString:@"Male"])
        self.strGender = @"1";
    else
        self.strGender = @"2";

    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        dirtyView = [[DirtyViewController alloc] initWithNibName:@"DirtyViewController" bundle:nil];
        
        CGRect dirtyVwFr = dirtyView.view.frame;
        dirtyVwFr.origin.x = (self.view.frame.size.width/2) - (dirtyView.view.frame.size.width/2);
        dirtyVwFr.origin.y = 320;
        dirtyView.view.frame = dirtyVwFr;
    }
    else
    {
        dirtyView = [[DirtyViewController alloc] initWithNibName:@"DirtyViewController_iPad" bundle:nil];
            dirtyView.view.frame = CGRectMake(35, 620, 700, 120);            
    }
    dirtyView.view.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:dirtyView.view];
    [self update_UI];
    
}

#pragma mark custom methods

//Update Images method
-(void)update_UI
{
    NSString *str = nil;
    UIImage *img = nil;

    NSString *str1 = nil;
    UIImage *img1 = nil;
    
    if ([CurrentLang isEqualToString:@"fr"]) 
    {
        if (thisDevice.userInterfaceIdiom==UIUserInterfaceIdiomPhone) 
        {
            btnDare.frame=CGRectMake(10, 145, 300, 78);
            btnTruth.frame=CGRectMake(10, 231, 300, 78);
        }
        else
        {
            btnDare.frame=CGRectMake(35, 280, 703 , 139);
            btnTruth.frame=CGRectMake(35, 450, 703, 139);
        }
    }

    if ([self.strTruthMode isEqualToString:@"All Truth"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            str = [NSString stringWithFormat:@"truth_iPad_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];
            [btnTruth setImage:img forState:UIControlStateNormal];
        }
        else
        {
            str = [NSString stringWithFormat:@"truth_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];
            [btnTruth setImage:img forState:UIControlStateNormal];        
        }
        
    }

    else if([self.strTruthMode isEqualToString:@"All Dare"])

    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            str = [NSString stringWithFormat:@"dare_iPad_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];
            [btnTruth setImage:img forState:UIControlStateNormal];
        }
        else
        {
            str = [NSString stringWithFormat:@"dare_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];
            [btnTruth setImage:img forState:UIControlStateNormal];
        }
    }
    else
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            str = [NSString stringWithFormat:@"dare_iPad_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];

            
            str1 = [NSString stringWithFormat:@"truth_iPad_%@",CurrentLang];
            img1 =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str1 ofType:@"png"]];
            [btnTruth setImage:img1 forState:UIControlStateNormal];
            
        }
        else
        {
            str = [NSString stringWithFormat:@"dare_%@",CurrentLang];
            img =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str ofType:@"png"]];
            [btnDare setImage:img forState:UIControlStateNormal];
            
            
            str1 = [NSString stringWithFormat:@"truth_%@",CurrentLang];
            img1 =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:str1 ofType:@"png"]];
            [btnTruth setImage:img1 forState:UIControlStateNormal];        
        }
    }
    
    str=nil;
    [str release];
    str1=nil;
    [str1 release];
}


-(IBAction)PickmeBtnAction:(id)sender
{
    [self increaseSpeedCountOfPlayer];
    [FlurryAnalytics logEvent:@"'Pick For Me' mystery box button pressed"];
    NSArray *Array=[[[NSArray alloc]initWithObjects:@"1",@"2",nil]autorelease];  
    NSInteger Value= arc4random() % [Array count];
    NSInteger Value1=[[Array objectAtIndex:Value] intValue];
    NSArray *arrPlayers = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
    players = [arrPlayers count];
    NSString *strNumberOfPlayers = [NSString stringWithFormat:@"%d", players];
    Numberofplayer=strNumberOfPlayers.integerValue;
    strDirtinessValue = [NSString stringWithFormat:@"dirty='%d'",appDelegate.dirtystartValue];
    self.strGenderCode = [self getGenderString];
    if (Value1==1) {
        btnDare.enabled=NO;
    }
    else
    {
        btnTruth.enabled=NO;
    }
    if ([strSource isEqualToString:@"0"]) 
    {
        [self Buildin:Value1];
    }
    else
    {
        strDirtinessValue = [NSString stringWithFormat:@"dirty='%d'",appDelegate.dirtystartValueformine];
        [self Minemode:Value1];
    }
    
}
//Go to Turn Display screen Method
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
//Truth and Dare Selection Method
-(IBAction)displayTruthOrDare:(id)sender
{
    [self increaseSpeedCountOfPlayer];
    
    UIButton *btn = (UIButton *)sender;
    NSArray *arrPlayers = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
    players = [arrPlayers count];
    NSString *strNumberOfPlayers = [NSString stringWithFormat:@"%d", players];
    Numberofplayer=strNumberOfPlayers.integerValue;
    strDirtinessValue = [NSString stringWithFormat:@"dirty='%d'",appDelegate.dirtystartValue];
    self.strGenderCode = [self getGenderString];
    if (btn.tag==1) {
        btnDare.enabled=NO;
    }
    else
    {
        btnTruth.enabled=NO;
    }
    if ([strSource isEqualToString:@"0"]) 
    {
        [self Buildin:btn.tag];
    }
    else
    {
        strDirtinessValue = [NSString stringWithFormat:@"dirty='%d'",appDelegate.dirtystartValueformine];
        [self Minemode:btn.tag];
    }
}
//Truth or dare if My dare off 
-(void)Buildin:(NSInteger)tag
{
    TruthOrDareDisplayView *displayObj;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        displayObj = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView_iPad" bundle:nil];
    }
    else
    {
        displayObj = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView" bundle:nil];
    }
    
    
    displayObj.strPlayerName1 = self.strPlayerName;
    if(tag == 1)
    {
        if ([strTruthMode isEqualToString:@"All Dare"])
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a dare"];
            displayObj.strMode = @"Dare";
            self.mode = @"Dare"; 
            if (autoTruthFlag)
            {
                [self increaseDareCountOfPlayer];
                [self resetTruthCountOfPlayer];
            }
            
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleDare count] > 0)
                {
                    [appDelegate.arrDelegateMaleDare removeAllObjects];
                    
                }
                
                
                self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                
            }
            else
            {
                if([appDelegate.arrDelegateFemaleDare count] > 0)
                {
                    [appDelegate.arrDelegateFemaleDare removeAllObjects];
                }
                
                
                self.strFemaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery];
                
            }
            
        }
        else
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a truth"]; 
            displayObj.strMode = @"Truth";
            self.mode = @"Truth"; 
            
            if (autoTruthFlag) {
                [self resetDareCountOfPlayer];
                [self increaseTruthCountOfPlayer];
            }
            
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateMaleTruth removeAllObjects];
                }
                
                self.strMaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery];
            }
            else
            {
                if([appDelegate.arrDelegateFemaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                }
                
                self.strFemaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery];
                
            }
        }
    }
    //-----------------------btn tag2------------------------------------------------------------------------
    else 
    {
        if ([strTruthMode isEqualToString:@"All Truth"]) 
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a truth"]; 
            if (autoTruthFlag) {
                [self resetDareCountOfPlayer];
                [self increaseTruthCountOfPlayer];
            }
            displayObj.strMode = @"Truth";
            self.mode = @"Truth";
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateMaleTruth removeAllObjects];
                }
                
                self.strMaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery];
                
                
                
            }
            else
            {
                if([appDelegate.arrDelegateFemaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                    
                }
                
                self.strFemaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery];
                
                
            }
            
        } 
        else
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a dare"]; 
            displayObj.strMode = @"Dare";
            self.mode = @"Dare";
            if (autoTruthFlag) {
                [self increaseDareCountOfPlayer];// for auto truth
                [self resetTruthCountOfPlayer];
            }
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleDare count] > 0)
                {
                    [appDelegate.arrDelegateMaleDare removeAllObjects];
                    
                }
                
                
                self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                
                
            }
            else
            {
                
                
                if([appDelegate.arrDelegateFemaleDare count] > 0)
                {
                    [appDelegate.arrDelegateFemaleDare removeAllObjects];
                    
                }
                
                self.strFemaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery];
                
                
            }
            
        }
    }
    displayObj.strPlayerName1=strPlayerName;
    [self.navigationController pushViewController:displayObj animated:YES];
    [displayObj release]; 
    
}
//Truth or dare if My dare On 
-(void)Minemode:(NSInteger)tag
{
    TruthOrDareDisplayView *displayObj;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        displayObj = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView_iPad" bundle:nil];
    }
    else
    {
        displayObj = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView" bundle:nil];
    }
    
    displayObj.strPlayerName1 = self.strPlayerName;
    if(tag == 1)
    {
        if ([strTruthMode isEqualToString:@"All Dare"])
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a dare"];
            displayObj.strMode = @"Dare";
            self.mode = @"Dare"; 
            if (autoTruthFlag) {
                [self increaseDareCountOfPlayer];// for auto truth
                [self resetTruthCountOfPlayer];
            }
            
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleDare count] > 0)
                {
                    [appDelegate.arrDelegateMaleDare removeAllObjects];
                    
                }
                
                
                self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                
                if ([appDelegate.arrDelegateMaleDare count]==0) {
                    
                    self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
            }
            else
            {
                if([appDelegate.arrDelegateFemaleDare count] > 0)
                {
                    [appDelegate.arrDelegateFemaleDare removeAllObjects];
                }
                
                
                self.strFemaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery];
                
                
                
                if ([appDelegate.arrDelegateFemaleDare count]==0) {
                    
                    self.strFemaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='0'and active='1'  and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
            }
            
        }
        else
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a truth"];
            displayObj.strMode = @"Truth";
            self.mode = @"Truth"; 
            
            if (autoTruthFlag) {
                [self resetDareCountOfPlayer];
                [self increaseTruthCountOfPlayer];
            }
            
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                
                if([appDelegate.arrDelegateMaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateMaleTruth removeAllObjects];
                }
                
                self.strMaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery];
                
                
                if ([appDelegate.arrDelegateMaleTruth count]==0) {
                    
                     
                    self.strMaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
            }
            else
            {
                if([appDelegate.arrDelegateFemaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                }
                
                
                self.strFemaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1'  and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery];
                
                
                if ([appDelegate.arrDelegateFemaleTruth count]==0) {
                    
                    self.strFemaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
            }
        }
    }
    //-----------------------btn tag2-------------------------------------------------------------------------
    else 
    {
        if ([strTruthMode isEqualToString:@"All Truth"]) 
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a truth"];
            if (autoTruthFlag) {
                [self resetDareCountOfPlayer];
                [self increaseTruthCountOfPlayer];
            }
            displayObj.strMode = @"Truth";
            self.mode = @"Truth";
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateMaleTruth removeAllObjects];
                    
                }
                
                self.strMaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery];
                
                if ([appDelegate.arrDelegateMaleTruth count]==0) {
                    
                    
                    NSString *strMaleTruthQuery2=[NSString stringWithFormat:@"select * from tblTruth where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateMaleTruth=[self executeQuery:strMaleTruthQuery2];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
            }
            else
            {
                if([appDelegate.arrDelegateFemaleTruth count] > 0)
                {
                    [appDelegate.arrDelegateFemaleTruth removeAllObjects];
                    
                }
                
                self.strFemaleTruthQuery=[NSString stringWithFormat:@"select * from tblTruth where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery];
                
                if ([appDelegate.arrDelegateFemaleTruth count]==0) {
                    
                    NSString *strFemaleTruthQuery1=[NSString stringWithFormat:@"select * from tblTruth where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateFemaleTruth=[self executeQuery:strFemaleTruthQuery1];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
            }
            
        } 
        else
        {
            [FlurryAnalytics logEvent:@"Auto Challenge forced a dare"]; 
            displayObj.strMode = @"Dare";
            self.mode = @"Dare";
            if (autoTruthFlag) {
                [self increaseDareCountOfPlayer];// for auto truth
                [self resetTruthCountOfPlayer];
            }
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                if([appDelegate.arrDelegateMaleDare count] > 0)
                {
                    [appDelegate.arrDelegateMaleDare removeAllObjects];
                }
                
                
                self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                
                if ([appDelegate.arrDelegateMaleDare count]==0) {
                    
                    self.strMaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateMaleDare=[self executeQuery:strMaleDareQuery];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
            }
            else
            {
                
                
                if([appDelegate.arrDelegateFemaleDare count] > 0)
                {
                    [appDelegate.arrDelegateFemaleDare removeAllObjects];
                }
                
                self.strFemaleDareQuery=[NSString stringWithFormat:@"select * from tblDare where source='%@' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL",strSource, Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery];
                
                
                if ([appDelegate.arrDelegateFemaleDare count]==0) {
                    
                    NSString *strFemaleDareQuery1=[NSString stringWithFormat:@"select * from tblDare where source='0' and active='1' and minplayers<=%d and (%@) and (%@) and %@ IS NOT NULL", Numberofplayer, strGenderCode, strDirtinessValue,strCheckLanguage];
                    appDelegate.arrDelegateFemaleDare=[self executeQuery:strFemaleDareQuery1];
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                else
                {
                    displayObj.strPlayerName1=strPlayerName;
                    [self.navigationController pushViewController:displayObj animated:YES];
                    [displayObj release];
                }
                
                
                
            }
            
        }
    }
    
}

// All Truth count Reset Method
-(void)resetTruthCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        //TruthNumber
        
        [currentPlayerDict setObject:@"0" forKey:@"TruthNumber"];
        
    }
}

// All Dare count Reset Method
-(void)resetDareCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        //DareNumber
        
        [currentPlayerDict setObject:@"0" forKey:@"DareNumber"];
        
    }
}
// Speed count Reset Method
-(void)resetSpeedCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        [dict setObject:@"0" forKey:@"SpeedNo"];
    }
    

}
// Increse All Truth count Method
-(void)increaseTruthCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        //DareNumber
        
        NSUInteger truthNo = [[currentPlayerDict objectForKey:@"TruthNumber"] intValue];
        truthNo ++;
        [currentPlayerDict setObject:[NSString stringWithFormat:@"%d",truthNo] forKey:@"TruthNumber"];
    }
    
}
// Increse All Dare count Method
-(void)increaseDareCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) {
        //DareNumber
        
        NSUInteger dareNo = [[currentPlayerDict objectForKey:@"DareNumber"] intValue];
        dareNo ++;
        [currentPlayerDict setObject:[NSString stringWithFormat:@"%d",dareNo] forKey:@"DareNumber"];
    }
    
}
// Increse Speed count Method
-(void)increaseSpeedCountOfPlayer
{
    NSMutableDictionary *currentPlayerDict = nil;
    
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        if ([[dict objectForKey:@"Player"] isEqualToString:strPlayerName]) 
        {
            currentPlayerDict = dict; 
            break;
        }
    }
    
    if (currentPlayerDict) 
    {
        //-------speed----------------
        NSUInteger SpeedNo = [[currentPlayerDict objectForKey:@"SpeedNo"] intValue];
        SpeedNo++;
        [currentPlayerDict setObject:[NSString stringWithFormat:@"%d",SpeedNo] forKey:@"SpeedNo"];
    }
    
}
// Fetch Truth or Dare from Database
-(NSMutableArray *)executeQuery:(NSString*)str{
    
 	sqlite3_stmt *statement= nil;
	sqlite3 *database;
	NSString *strPath = [self getDatabasePath];
	NSMutableArray *allDataArray = [[[NSMutableArray alloc] init]autorelease];
	if (sqlite3_open([strPath UTF8String],&database) == SQLITE_OK) {
		if (sqlite3_prepare_v2(database, [str UTF8String], -1, &statement, NULL) == SQLITE_OK) 
        {
			while (sqlite3_step(statement) == SQLITE_ROW) 
            {
                NSInteger i = 0;
				NSInteger iColumnCount = sqlite3_column_count(statement);
				NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
				while (i< iColumnCount) {
					NSString *str = [self encodedString:(const unsigned char*)sqlite3_column_text(statement, i)];
					
                    NSString *strFieldName = [self encodedString:(const unsigned char*)sqlite3_column_name(statement, i)];
					
					[dict setObject:str forKey:strFieldName];
					i++;
				}
				
				[allDataArray addObject:dict];
				[dict release];
			}
		}
		sqlite3_finalize(statement);
	} 
	sqlite3_close(database);
	return allDataArray;
}
-(NSString* )getDatabasePath{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
	return writableDBPath;
	
}
-(NSString*)encodedString:(const unsigned char *)ch
{
	NSString *retStr;
	if(ch == nil)
		retStr = @"";
	else
		retStr = [NSString stringWithCString:(char*)ch encoding:NSUTF8StringEncoding];
	return retStr;
}
// Dirtyness Check method
-(NSString *)getDirtinessString
{
    
    NSString *str;// = [[[NSString alloc] init] autorelease];
    str = @"";
    for(int i=0; i<[appDelegate.arrDirtinesNumber count]; i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"dirty='%@'", [appDelegate.arrDirtinesNumber objectAtIndex:i]];
        str = [str stringByAppendingString:str1];
        if(i != [appDelegate.arrDirtinesNumber count] - 1)
            str = [str stringByAppendingString:@" or "];
    }
    
    return str;
    
}
// gender Check method
-(NSString *)getGenderString
{
    NSString *str;// = [[[NSString alloc] init] autorelease];
    //str = @"";
    
    if([strPlayerGender isEqualToString:@"Male"])
    {
        str = @"gender ='1' or gender ='0'";
    }
    else
    {
        str = @"gender ='2' or gender ='0'";
    }
    return str;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.contentView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view{
    NSLog(@"ads failed to receive");
}
- (void)adViewDidLoadAd:(MPAdView *)view{
    CGSize size = [view adContentViewSize];
    CGRect newFrame = view.frame;
    newFrame.size = size;
    newFrame.origin.x = (self.view.bounds.size.width - size.width) / 2;
    view.frame = newFrame;
}

- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}
- (void)dealloc
{
   // 
     mopubclass.mpAdView.delegate=nil;
    //[mopubclass release];
    self.strGenderCode = nil;
    [dirtyView release];    
    
    [lblPlayerName release];
    [btnTruth release];
    [btnDare release];
    
    self.strPlayerName = nil;
    self.strPlayerGender = nil;
    self.mode = nil;
    self.contentView = nil;
   // _bannerView.delegate = nil;
    [super dealloc];
}

@end
