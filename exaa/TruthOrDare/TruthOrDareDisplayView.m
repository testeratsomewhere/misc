

#import "TruthOrDareDisplayView.h"
#import "PlayViewController.h"
#import "UserDefaultSettings.h"

#import "SHK.h"
#import "SHKSharer.h"
#import "SHKCustomShareMenu.h"
#import <Foundation/NSObjCRuntime.h>
#import "Mopubclass.h"
@implementation TruthOrDareDisplayView
@synthesize strPlayerName1;
@synthesize strMode,strstate;
@synthesize displaytext,strpreviewmode;
@synthesize contentView = _contentView;
@synthesize arrWithoutPlayer, genderWithoutPlayer;
@synthesize clocktimer;
@synthesize genderforpreview;



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma facebook integration 
//Facebook Method
- (IBAction) facebookbtnAction:(id) sender {
    if(!btnOk.hidden)
    {
        [FlurryAnalytics logEvent:@"FacebookBtnPressed"];
        NSString *strpost=[NSString stringWithFormat:@"%@-%@",strPlayerName1,lblDisplayText.text];
        SHKItem *item = [SHKItem text:strpost];
        [NSClassFromString(@"SHKFacebook") performSelector:@selector(shareItem:) withObject:item];
      
    }
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisDevice = [UIDevice currentDevice];
    [self update_UI];
    changeQue = 0;

  //  thisDevice = [UIDevice currentDevice];
    // MPAdView *ad=[[Mopubclass sharedInstance] initlization];
   
    timerflag=YES;
    lbltimer.hidden=YES;
    appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    btnOk.hidden = YES;
    [[UIApplication sharedApplication] setIdleTimerDisabled: YES];
    
    arrMale = [[NSMutableArray alloc] init];
    arrFemale = [[NSMutableArray alloc] init];
    
    
    arrName = [[UserDefaultSettings sharedSetting]retrieveArray:@"Player Name"];
    self.arrWithoutPlayer = [NSMutableArray arrayWithArray:arrName];
    NSArray *arrGender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
    self.genderWithoutPlayer = [NSMutableArray arrayWithArray:arrGender];
    if (![self.strstate isEqualToString:@"Preview"])
    {
    
        for(int i=0; i<[arrGender count]; i++)
        {
            if([[arrGender objectAtIndex:i] isEqualToString:@"Male"])
            {
                if([[arrName objectAtIndex:i] isEqualToString:appDelegate.strCurrentPlayerName])
                {
                    [arrWithoutPlayer removeObjectAtIndex:i];
                    [genderWithoutPlayer removeObjectAtIndex:i];
                }
                else
                {
                    [arrMale addObject:[arrName objectAtIndex:i]];
                }
                
            }
            else
            {
                if([[arrName objectAtIndex:i] isEqualToString:appDelegate.strCurrentPlayerName])
                {
                    [arrWithoutPlayer removeObjectAtIndex:i];
                    [genderWithoutPlayer removeObjectAtIndex:i];
                    
                }
                else
                {
                    [arrFemale addObject:[arrName objectAtIndex:i]];
                }
            }
        }
 }
        
        notFromTestAdv = YES;
    notFromCamera = YES;
    // _bannerView.userInteractionEnabled = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self update_UI];
    mopubclass=[Mopubclass sharedInstance];
    CGRect frame = mopubclass.mpAdView.frame;
    CGSize size = [mopubclass.mpAdView adContentViewSize];
    frame.origin.y = self.view.bounds.size.height - size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor clearColor];
    mopubclass.mpAdView.frame = frame;
    [self.view addSubview:mopubclass.mpAdView];
 

  //  mopubclass.mpAdView.backgroundColor=[UIColor clearColor];
	mopubclass.mpAdView.delegate = self;
    mopubclass.mpAdView.hidden=YES;
	[mopubclass.mpAdView loadAd];
    if (notFromTestAdv && notFromCamera) {
       
        if ([self.strstate isEqualToString:@"Preview"]) {
            NSString *strgender;
            if ([genderforpreview isEqualToString:@"1"]) {
                strgender=@"Male";
            }
            else if([genderforpreview isEqualToString:@"2"])
            {
                strgender=@"Female";
            }
            else
            {
                strgender=@"Both";
            }
            if ([arrMale count]>1) {
                [arrMale removeAllObjects];
            }
            if ([arrFemale count]>1) {
                [arrFemale removeAllObjects];
            }

            arrPlayerName = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            if ([strgender isEqualToString:@"Male"]||[strgender isEqualToString:@"Female"]) {
                NSInteger indexvalue=[arrgender indexOfObject:strgender];
                if (indexvalue>[arrgender count]) {
                    self.strPlayerName1=[arrPlayerName objectAtIndex:0];  
                   
                }
                else
                {
                    self.strPlayerName1=[arrPlayerName objectAtIndex:indexvalue];
                    
                }
                
            }
            else
            {
                self.strPlayerName1=[arrPlayerName objectAtIndex:0];
                
            }
            NSArray *arrGender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            
            for(int i=0; i<[arrGender count]; i++)
            {
                if([[arrGender objectAtIndex:i] isEqualToString:@"Male"])
                {
                    if([[arrName objectAtIndex:i] isEqualToString:self.strPlayerName1])
                    {
                        [arrWithoutPlayer removeObjectAtIndex:i];
                        [genderWithoutPlayer removeObjectAtIndex:i];
                    }
                    else
                    {
                        [arrMale addObject:[arrName objectAtIndex:i]];
                    }
                }
                else
                {
                    if([[arrName objectAtIndex:i] isEqualToString:self.strPlayerName1])
                    {
                        [arrWithoutPlayer removeObjectAtIndex:i];
                        [genderWithoutPlayer removeObjectAtIndex:i];
                        
                    }
                    else
                    {
                        [arrFemale addObject:[arrName objectAtIndex:i]];
                    }
                }
            }
            
        }

        if ([self.strstate isEqualToString:@"Preview"]) {
            
            btnFacebook.hidden=YES;
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                btnFacebook.frame = CGRectMake(120,935,63,63);
                btnCamera.frame = CGRectMake(230,935,63,63);
                btnTimer.frame = CGRectMake(465,935,63,63);
                
            }
            else{
                btnFacebook.frame = CGRectMake(50,417,39,39);
                btnCamera.frame = CGRectMake(95,417,39,39);
                btnTimer.frame = CGRectMake(190,417,39,39);
            }
            btnChangeDare.hidden = YES;
            NSString *strgender;
            if ([genderforpreview isEqualToString:@"1"]) {
                strgender=@"Male";
            }
            else if([genderforpreview isEqualToString:@"2"])
            {
                strgender=@"Female";
            }
            else
            {
                strgender=@"Both";
            }
            
            arrPlayerName = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            if ([strgender isEqualToString:@"Male"]||[strgender isEqualToString:@"Female"]) {
                NSInteger indexvalue=[arrgender indexOfObject:strgender];
                if (indexvalue>[arrgender count]) {
                  lblPlayerName.text=[arrPlayerName objectAtIndex:0];  
                    appDelegate.strCurrentPlayerGender=[arrgender objectAtIndex:0];
                }
                else
                {
                   lblPlayerName.text=[arrPlayerName objectAtIndex:indexvalue];
                    appDelegate.strCurrentPlayerGender=[arrgender objectAtIndex:indexvalue];
                }
                
            
            }
            else
            {
                lblPlayerName.text=[arrPlayerName objectAtIndex:0];
                appDelegate.strCurrentPlayerGender=[arrgender objectAtIndex:0];
            }
                        
            
            if([strpreviewmode isEqualToString:@"Truth"])
            {
                [lblDisplayText setTextColor:[UIColor colorWithRed:170.0/255.0 green:213.0/255.0 blue:114.0/255.0 alpha:1.0]];
                
            }
            else
            {
                [lblDisplayText setTextColor:[UIColor colorWithRed:253.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]];
                
            }
            
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint" size:55.0]];
                [lblDisplayText setFont:[UIFont fontWithName:@"SegoePrint" size:55.0]];
            }
            else
            {
                [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
                [lblDisplayText setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
            }
            [lblPlayerName setTextColor:[UIColor whiteColor]]; 
            
            
        }
        else
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint" size:55.0]];
                [lblDisplayText setFont:[UIFont fontWithName:@"SegoePrint" size:55.0]];

                
            }else{
                [lblPlayerName setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
                [lblDisplayText setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];

            }

            
            [lblPlayerName setTextColor:[UIColor whiteColor]]; 
            
            lblPlayerName.text = self.strPlayerName1;
            
            if([strMode isEqualToString:@"Truth"])
            {
                [lblDisplayText setTextColor:[UIColor colorWithRed:170.0/255.0 green:213.0/255.0 blue:114.0/255.0 alpha:1.0]];
                if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
                    randomNumber = [self generateMaleTruthId]; 
                else
                    randomNumber = [self generateFemaleTruthId];
            }
            else
            {
                [lblDisplayText setTextColor:[UIColor colorWithRed:253.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]];
                if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
                    randomNumber = [self generateMaleDareId];
                else
                    randomNumber = [self generateFemaleDareId];
            }
            
            dictChangeDare = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
            NSString *strChangeDare = [dictChangeDare objectForKey:@"Allow Changing Dares"];
            
            if([strChangeDare isEqualToString:@"ON"])
            {
                btnFacebook.hidden=YES;
                
                if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    btnFacebook.frame = CGRectMake(100,935,63,63);
                    btnCamera.frame = CGRectMake(135,935,63,63);
                    btnTimer.frame = CGRectMake(353,935,63,63);
                    btnChangeDare.frame = CGRectMake(570,935,63,63);
                }
                else{
                    btnFacebook.frame = CGRectMake(32,417,39,39);
                    btnCamera.frame = CGRectMake(40,417,39,39);
                    btnTimer.frame = CGRectMake(140,417,39,39);
                    btnChangeDare.frame = CGRectMake(240,417,39,39);
                }
                btnChangeDare.hidden = NO;
            }
            else
            {
                btnFacebook.hidden=YES;
                
                if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    btnFacebook.frame = CGRectMake(120,935,63,63);
                    btnCamera.frame = CGRectMake(230,935,63,63);
                    btnTimer.frame = CGRectMake(465,935,63,63);
                }
                else{
                    btnFacebook.frame = CGRectMake(50,417,39,39);
                    btnCamera.frame = CGRectMake(95,417,39,39);
                    btnTimer.frame = CGRectMake(190,417,39,39);
                }
                btnChangeDare.hidden = YES;
            }
            
        }
    }
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = mopubclass.mpAdView.frame;
    
    contentFrame.size.height -= mopubclass.mpAdView.frame.size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor blackColor];
    bannerFrame.origin.y = contentFrame.size.height;
    mopubclass.mpAdView.hidden=YES;
    //    } else {
    //        bannerFrame.origin.y = contentFrame.size.height;
    //    }
    
//    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
//        _contentView.frame = contentFrame;
//        
//        [_contentView layoutIfNeeded];
//        mopubclass.mpAdView.frame = bannerFrame;
//    }];
}

-(void)viewDidAppear:(BOOL)animated
{
     if (notFromTestAdv && notFromCamera) {
         // _bannerView.userInteractionEnabled = NO;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationDuration:0.20];
        [lblDisplayText setAlpha:0];
        [btnOk setAlpha:0];
        [UIView commitAnimations];
     }
    notFromTestAdv = YES;
    notFromCamera = YES;
}
// Animation Method
-(void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
   //  _bannerView.userInteractionEnabled = YES;
    btnOk.hidden = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.20];
    [lblDisplayText setAlpha:1];
    [btnOk setAlpha:1];
    [UIView commitAnimations];
    
    if ([strstate isEqualToString:@"Preview"]) {
        
        NSMutableDictionary *dict = [self checkPersonCodeForPreview:displaytext];
        
        if ([[dict objectForKey:@"generateNew"] boolValue]) 
        {
            NSMutableDictionary *dict1 =  [self checkPersonCodeForPreview:displaytext];
            lblDisplayText.text =[dict1 objectForKey:@"String"];
        }
        else
        {
            lblDisplayText.text =[dict objectForKey:@"String"];
        }
    }
    else
    {
        if([strMode isEqualToString:@"Truth"])
        {
            
            [self generateRandomQueryForTruth:YES];
        }
        else
        {
            [self generateRandomQueryForFalse:YES];
           
        }
    }
    
}
-(NSString *)checkLangFemaleTruth:(int)number
{
    
    if ([CurrentLang isEqualToString:@"en"])
    {
        strTemp =[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_EN"];
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_ES"];
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_FR"];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_DE"];
    }
    return strTemp;
}

-(NSString *)checkLangMaleTruth:(int)number
{
    if ([CurrentLang isEqualToString:@"en"])
    {
        strTemp =[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_EN"];
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strTemp=[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_ES"];
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strTemp=[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_FR"];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strTemp=[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] objectForKey:@"ln_DE"];
    }
    return strTemp;
}
// Generate Random for Truth Method
-(void)generateRandomQueryForTruth:(BOOL)generateNew
{
    if (generateNew) 
    {
        NSString *playStr=nil;
        if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
        {
//            randomNumber=[self generateMaleTruthId];
//            playStr = [self checkLangMaleTruth:randomNumber]; 
            
            while ([playStr length]==0) {
                //NSLog(@"null string");
                randomNumber=[self generateMaleTruthId];
//                NSLog(@"RandomNum= %d",randomNumber);
                playStr = [self checkLangMaleTruth:randomNumber]; 
            }
             
            [appDelegate.arrMaleTruthChallengeId addObject:[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] valueForKey:@"pkTruthChallengeID"]];
        }
        else
        {
            randomNumber=[self generateFemaleTruthId];
            playStr = [self checkLangFemaleTruth:randomNumber];
            
            while ([playStr length]==0) {
                //NSLog(@"null string");
//                randomNumber=[self generateFemaleTruthId];
//                playStr = [self checkLangFemaleTruth:randomNumber];
 
            }
            [appDelegate.arrFemaleTruthChallengeId addObject:[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] valueForKey:@"pkTruthChallengeID"]];
        }
      
        NSMutableDictionary *dict=[self checkIfCodePresent:playStr];
        if ([[dict objectForKey:@"generateNew"] boolValue]) 
        {
            [self generateRandomQueryForTruth:[[dict objectForKey:@"generateNew"] boolValue]];
        }
        else
        {
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                lblDisplayText.text =  [dict objectForKey:@"String"];
                NSInteger DirtinessValue=[[[appDelegate.arrDelegateMaleTruth objectAtIndex:randomNumber] valueForKey:@"dirty"] integerValue];
                lblPlayerName.text=[NSString stringWithFormat:@"%@",self.strPlayerName1];
                 NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                NSString *strSound=[dictFilter objectForKey:@"Sound"];
                if (changeQue == 0)
                {
                    if ([strSound isEqualToString:@"ON"]) 
                    {
                        NSString *filePath;
                        if((DirtinessValue>=1 && DirtinessValue<=3))
                        {
                            
                            filePath = [[NSBundle mainBundle] pathForResource:@"drumroll"
                                                                       ofType:@"mp3"];
                        }
                        else
                        {
                            filePath = [[NSBundle mainBundle] pathForResource:@"surprised"
                                                                       ofType:@"mp3"];
                        }
                        NSURL *url = [NSURL fileURLWithPath:filePath];
                        
                        NSError *error;
                        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                        
                        if (audioPlayer == nil)
                        {
                            NSLog(@"%@",[error description]);
                        }
                        else
                        {
                            [audioPlayer play];
                        }
                        
                    }
                }
            }
            else
            {
                lblDisplayText.text =  [dict objectForKey:@"String"];
                NSInteger DirtinessValue=[[[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomNumber] valueForKey:@"dirty"] integerValue];
                lblPlayerName.text=[NSString stringWithFormat:@"%@",self.strPlayerName1];
                NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                NSString *strSound=[dictFilter objectForKey:@"Sound"];
                if (changeQue == 0)
                {
                    if ([strSound isEqualToString:@"ON"]) 
                    {
                        NSString *filePath;
                        if((DirtinessValue>=1 && DirtinessValue<=3))
                        {
                            
                            filePath = [[NSBundle mainBundle] pathForResource:@"drumroll"
                                                                       ofType:@"mp3"];
                        }
                        else
                        {
                            filePath = [[NSBundle mainBundle] pathForResource:@"surprised"
                                                                       ofType:@"mp3"];
                        }
                        NSURL *url = [NSURL fileURLWithPath:filePath];
                        
                        NSError *error;
                        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                        
                        if (audioPlayer == nil)
                        {
                            NSLog(@"%@",[error description]);
                        }
                        else
                        {
                            [audioPlayer play];
                        }
                        
                    }

                }
            }
            
        }
      
    }
}
-(NSString *)checkLangFemaleDare:(int)number
{ 
    
    if ([CurrentLang isEqualToString:@"en"])
    {
        strTemp =[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] objectForKey:@"ln_EN"];
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] objectForKey:@"ln_ES"];
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] objectForKey:@"ln_FR"];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strTemp=[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] objectForKey:@"ln_DE"];
    }
    return strTemp;
}

-(NSString *)checkLangMaleDare:(int)number
{
    if ([CurrentLang isEqualToString:@"en"])
    {
        strTemp =[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] objectForKey:@"ln_EN"];
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strTemp=[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] objectForKey:@"ln_ES"];
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strTemp=[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] objectForKey:@"ln_FR"];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strTemp=[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] objectForKey:@"ln_DE"];
    }
    return strTemp;
}

// Generate Random for Dare Method
-(void)generateRandomQueryForFalse:(BOOL)generateNew
{
    if (generateNew) 
    {
        NSString *playStr=nil;
        if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
        {            
            while ([playStr length]==0) 
            {
                NSLog(@"null string");
                randomNumber=[self generateMaleDareId];
                playStr = [self checkLangMaleDare:randomNumber];
            }
            [appDelegate.arrMaleDareChallengeId addObject:[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] valueForKey:@"pkDaresChallengeID"]];
        }
        else
        {            
            while ([playStr length]==0) 
            {
                NSLog(@"null string");
                randomNumber=[self generateFemaleDareId];
                playStr =[self checkLangFemaleDare:randomNumber];
            }
            [appDelegate.arrFemaleDareChallengeId addObject:[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] valueForKey:@"pkDaresChallengeID"]];
        }
       
              NSMutableDictionary *dict=[self checkIfCodePresent:playStr];
        if ([[dict objectForKey:@"generateNew"] boolValue]) 
        {
            [self generateRandomQueryForFalse:[[dict objectForKey:@"generateNew"] boolValue]];
        }
        else
        {
            if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            {
                lblDisplayText.text =  [dict objectForKey:@"String"];
                NSInteger DirtinessValue=[[[appDelegate.arrDelegateMaleDare objectAtIndex:randomNumber] valueForKey:@"dirty"] integerValue];
                lblPlayerName.text=[NSString stringWithFormat:@"%@",self.strPlayerName1];
                NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                NSString *strSound=[dictFilter objectForKey:@"Sound"];
                if (changeQue == 0)
                {
                    if ([strSound isEqualToString:@"ON"]) 
                    {
                        NSString *filePath;
                        if((DirtinessValue>=1 && DirtinessValue<=3))
                        {
                            
                            filePath = [[NSBundle mainBundle] pathForResource:@"babylaugh"
                                                                       ofType:@"mp3"];
                        }
                        else
                        {
                            filePath = [[NSBundle mainBundle] pathForResource:@"kiss"
                                                                       ofType:@"mp3"];
                        }
                        NSURL *url = [NSURL fileURLWithPath:filePath];
                        
                        NSError *error;
                        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                        
                        if (audioPlayer == nil)
                        {
                            NSLog(@"%@",[error description]);
                        }
                        else
                        {
                            [audioPlayer play];
                        }
                        
                    }
                }
            }
            else
            {
                lblDisplayText.text =  [dict objectForKey:@"String"];
                NSInteger DirtinessValue=[[[appDelegate.arrDelegateFemaleDare objectAtIndex:randomNumber] valueForKey:@"dirty"] integerValue];
                lblPlayerName.text=[NSString stringWithFormat:@"%@",self.strPlayerName1];
                NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                NSString *strSound=[dictFilter objectForKey:@"Sound"];
                if (changeQue == 0)
                {
                    if ([strSound isEqualToString:@"ON"]) 
                    {
                        NSString *filePath;
                        if((DirtinessValue>=1 && DirtinessValue<=3))
                        {
                            filePath = [[NSBundle mainBundle] pathForResource:@"babylaugh"
                                                                       ofType:@"mp3"];
                        }
                        else
                        {
                            filePath = [[NSBundle mainBundle] pathForResource:@"kiss"
                                                                       ofType:@"mp3"];
                        }
                        NSURL *url = [NSURL fileURLWithPath:filePath];
                        
                        NSError *error;
                        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
                        
                        if (audioPlayer == nil)
                        {
                            NSLog(@"%@",[error description]);
                        }
                        else
                        {
                            [audioPlayer play];
                        }
                        
                    }
                }
            }
         
        }
    }

}
-(NSString*)check:(NSString *)string:(NSInteger)Value:(NSMutableArray *)Array
{

    if ([string isEqualToString:@"*XX"]) {
        if ([Array count]>1) {
              NSInteger Value1=[[dictionary objectForKey:@"*XX2"] integerValue];
              [Array removeObjectAtIndex:Value1];
                 Value = arc4random() % [Array count]; 
                string=[Array objectAtIndex:Value];
                
            }
            else
            {
                string=[Array objectAtIndex:Value];
                
            }
          }
   else if ([string isEqualToString:@"*XY"]) {
        if ([Array count]>1) {
                NSInteger Value1=[[dictionary objectForKey:@"*XY2"] integerValue];
                [Array removeObjectAtIndex:Value1];
                Value = arc4random() % [Array count]; 
                string=[Array objectAtIndex:Value];
                
            }
            else
            {
                string=[Array objectAtIndex:Value];
                
            }
        }
   else if ([string isEqualToString:@"*X"]) {
       if ([Array count]>1) {
               NSInteger Value1=[[dictionary objectForKey:@"*X2"] integerValue];
               [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
               
           }
           else
           {
               string=[Array objectAtIndex:Value];
               
           }
       }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"He", @"")]])//@"*HeX"])
   {
       if ([Array count]>1) {
               NSInteger Value1=[[dictionary objectForKey:@"*HeX2"] integerValue];
               [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
               
           }
           else
           {
               string=[Array objectAtIndex:Value];
               
           }
       }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"he", @"")]])//@"*heX"]) 
   {
       if ([Array count]>1) {
               NSInteger Value1=[[dictionary objectForKey:@"*heX2"] integerValue];
               [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
              
           }
           else
           {
               string=[Array objectAtIndex:Value];
              
           }
       }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"His", @"")]])//@"*HisX"]) 
   {
       if ([Array count]>1) {
              NSInteger Value1=[[dictionary objectForKey:@"*HisX2"] integerValue];
              [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
              
           }
           else
           {
               string=[Array objectAtIndex:Value];
               
           }
       }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"his", @"")]])//@"*hisX"]) 
   {
       if ([Array count]>1) {
               NSInteger Value1=[[dictionary objectForKey:@"*hisX2"] integerValue];
               [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
               
           }
           else
           {
               string=[Array objectAtIndex:Value];
              
           }
   }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"his", @"")]])//@"*hisX"]) 
   {
       if ([Array count]>1) {
               NSInteger Value1=[[dictionary objectForKey:@"*hisX2"] integerValue];
               [Array removeObjectAtIndex:Value1];
               Value = arc4random() % [Array count]; 
               string=[Array objectAtIndex:Value];
           
           }
           else
           {
              string=[Array objectAtIndex:Value];
              
           }
       }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"him", @"")]])//@"*himX"]) 
   {
       if ([Array count]>1) {
           NSInteger Value1=[[dictionary objectForKey:@"*himX2"] integerValue];
           [Array removeObjectAtIndex:Value1];
           Value = arc4random() % [Array count]; 
           string=[Array objectAtIndex:Value];
           
       }
       else
       {
           string=[Array objectAtIndex:Value];
           
       }
   }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@X",NSLocalizedString(@"Him", @"")]])//@"*HimX"]) 
   {
       if ([Array count]>1) {
           NSInteger Value1=[[dictionary objectForKey:@"*HimX2"] integerValue];
           [Array removeObjectAtIndex:Value1];
           Value = arc4random() % [Array count]; 
           string=[Array objectAtIndex:Value];
           
       }
       else
       {
           string=[Array objectAtIndex:Value];
           
       }
   }
   else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"He", @"")]])//@"*HeXX"]) 
   {
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*HeXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"he", @"")]])//@"*heXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*heXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"His", @"")]])//@"*HisXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*HisXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"his", @"")]])//@"*hisXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*hisXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"his", @"")]])//@"*hisXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*hisXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"him", @"")]])//@"*himXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*himXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}
else if ([string isEqualToString:[NSString stringWithFormat:@"*%@XX",NSLocalizedString(@"Him", @"")]])//@"*HimXX"]) 
{
    if ([Array count]>1) {
        NSInteger Value1=[[dictionary objectForKey:@"*HimXX2"] integerValue];
        [Array removeObjectAtIndex:Value1];
        Value = arc4random() % [Array count]; 
        string=[Array objectAtIndex:Value];
        
    }
    else
    {
        string=[Array objectAtIndex:Value];
        
    }
}


    return string;
}
#pragma Check Person Code Logic
// if  person code is present for Truth or Dare Methods
- (NSMutableDictionary *)checkIfCodePresent:(NSString*)string
{
    dictionary=[[NSMutableDictionary alloc]init];
    BOOL generateAgain = NO;
    
    if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
    {
        arrayOfOppositeGender = arrMale;
        arrayOfSameGender = arrFemale;
    }
    else   
    {
        arrayOfOppositeGender = arrFemale;
        arrayOfSameGender = arrMale;
    }
    
    //check for any gender with repeatition
    
    // of any gender without repition
    //----------------------------------------------------------------------------------------------------//
    
    NSString *otherPlayerName = nil;
    NSString *otherPlayerGender = nil;
    NSString *str = nil;
    NSString *str2 = nil;
    NSString *strGen = nil;
    //{//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSString *oppGender = @"*XX2"; 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        NSMutableArray *filterdArr = [self filter:arrayOfSameGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([filterdArr count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            string  = [string stringByReplacingOccurrencesOfString:@"*XX2" withString:otherPlayerName]; 
        }
        else
        {
            NSUInteger otherPayer = arc4random() % [filterdArr count];
            [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer] forKey:oppGender];
            string  = [string stringByReplacingOccurrencesOfString:@"*XX2" withString:[filterdArr objectAtIndex:otherPayer]]; 
            otherPlayerName=[filterdArr objectAtIndex:otherPayer];
            NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
            [appDelegate.usedGender addObject:usedDict];
            [usedDict release];
        }
    }
    str=NSLocalizedString(@"He", @"");
    oppGender=[NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);
//    oppGender = @"*HeXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        NSMutableArray *filterdArr = [self filter:arrayOfSameGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([filterdArr count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
           NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];// @"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
    }  
    
    str=NSLocalizedString(@"he", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
    //NSLog(@"----->%@",oppGender);
   // oppGender = @"*heXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        NSMutableArray *filterdArr = [self filter:arrayOfSameGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([filterdArr count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
    }  
    
    str=NSLocalizedString(@"his", @"");
    oppGender=[NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);
//    oppGender = @"*hisXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        NSMutableArray *filterdArr = [self filter:arrayOfSameGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([filterdArr count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
        }
    }  
    str=NSLocalizedString(@"him", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*himXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        NSMutableArray *filterdArr = [self filter:arrayOfSameGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([filterdArr count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
    } 
    
    //}///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    {
        //opposite gender without repitition
        oppGender = @"*XY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY2" withString:otherPlayerName];
            }
            else
            {
                NSUInteger otherPayer = arc4random() % [filterdArr count];
                [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer] forKey:oppGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY2" withString:[filterdArr objectAtIndex:otherPayer]]; 
                otherPlayerName=[filterdArr objectAtIndex:otherPayer];
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
               [usedDict release];
            }
        }
        str=NSLocalizedString(@"He", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HeXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }  
        str=NSLocalizedString(@"he", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*heXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
             }

            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }  
        str=NSLocalizedString(@"His", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HisXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"his", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*hisXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString: NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"Him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HimXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
 
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*himXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }

            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    {
        //check for same gender with repition
        
        oppGender = @"*XX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                NSString  *otherPlayerName = [arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XX" withString:otherPlayerName];
            }
            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfSameGender count];
                NSString  *strotherPayer=[self check:@"*XX":otherPayer:arrayOfSameGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*XX" withString:strotherPayer];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                otherPayer=[arrPlayerName1 indexOfObject:strotherPayer];
                               
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];
            }
        }
        str=NSLocalizedString(@"He", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
//        NSLog(@"%@",oppGender);
 
//        oppGender = @"*HeXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                
                str2 = NSLocalizedString(@"he", @"");
                strGen=[NSString stringWithFormat:@"*%@XX",str2];
                
                if (![otherPlayerGender isEqualToString:@"Female"])
                                    
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }
        str=NSLocalizedString(@"he", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*heXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }

            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }  
        str=NSLocalizedString(@"His", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
 //       NSLog(@"%@",oppGender);

//        oppGender = @"*HisXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                
                str2 = NSLocalizedString(@"his", @"");
                strGen=[NSString stringWithFormat:@"*%@XX",str2];
                
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }

            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        
        str=NSLocalizedString(@"his", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*hisXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
             }

            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"Him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HimXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
             }

            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XX",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*himXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
 
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    {
        // check for opposite gender with repition
        
        oppGender = @"*XY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                NSString  *otherPlayerName = [arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName];
            }
 
            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfOppositeGender count];
                otherPlayerName=[self check:@"*XY":otherPayer:arrayOfOppositeGender];
                 
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName]; 
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];
            }
        }
        
        oppGender = @"*XY's"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                
                str2=NSLocalizedString(@"his", @"");
                strGen=[NSString stringWithFormat:@"*%@XX",str2];
                
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her", @"") ];//@"her"];
             }

            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfOppositeGender count];
                otherPlayerName = [arrayOfOppositeGender objectAtIndex:otherPayer];
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName]; 
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];
            }
        }
        str=NSLocalizedString(@"He", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HeXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                
                str2=NSLocalizedString(@"Him", @"");
                strGen=[NSString stringWithFormat:@"*%@XY",str2];
                
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }  
        str=NSLocalizedString(@"he", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*heXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                   string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
        }  
        str=NSLocalizedString(@"His", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
 //       NSLog(@"%@",oppGender);

//        oppGender = @"*HisXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"his", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*hisXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"Him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HimXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
        str=NSLocalizedString(@"him", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*himXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
             {
                 otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                 NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                 NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                 NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                 otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
             }

            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
        }  
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    {
        NSString *oppGender = @"*X2"; 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        BOOL firstQuery1 = [predicate evaluateWithObject:string];
        NSString *otherPlayerName = nil;
        NSString *otherPlayerGender = nil;
        
        
        if (firstQuery1) 
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            
            if ([filterdArr count]>0) {
                
                NSUInteger otherPayer = arc4random() % [filterdArr count];
                
                otherPlayerName = [filterdArr objectAtIndex:otherPayer];
                otherPlayerGender = [genderWithoutPlayer objectAtIndex:otherPayer];
                [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer] forKey:oppGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*X2" withString:otherPlayerName];
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];
            }
            else
                generateAgain = YES;
            
        }
        str=NSLocalizedString(@"He", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HeX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL secondQuery2 = [predicate evaluateWithObject:string];
        
        if (secondQuery2)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
             }
            else
            {

                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"she"];

            }
        }
        str=NSLocalizedString(@"he", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*heX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL secondQuery1 = [predicate evaluateWithObject:string];
        
        if (secondQuery1)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
            else
            {

                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];

            }
        }
        str=NSLocalizedString(@"His", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HisX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL thirdQuery2 = [predicate evaluateWithObject:string];
        
        if (thirdQuery2)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                str2=NSLocalizedString(@"He", @"");
                strGen=[NSString stringWithFormat:@"*%@X2",str2];
                
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"he", @"") ];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"she", @"") ];//@"she"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];

            }
        }
        
        str=NSLocalizedString(@"his", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*hisX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL thirdQuery1 = [predicate evaluateWithObject:string];
        
        if (thirdQuery1)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            if ([filterdArr count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
            }

            else
            {

                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];

            }
        }
        str=NSLocalizedString(@"Him", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*HimX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL fourthQuery2 = [predicate evaluateWithObject:string];
        
        if (fourthQuery2)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            
            if ([filterdArr count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
            }
            else
            {

                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];

            }
        }
        
        str=NSLocalizedString(@"him", @"");
        oppGender = [NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);

//        oppGender = @"*himX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL fourthQuery1 = [predicate evaluateWithObject:string];
        
        if (fourthQuery1)
        {
            NSMutableArray *filterdArr = [self filter:arrWithoutPlayer usedArray:appDelegate.usedGender andGenderArray:nil];
            
            if ([filterdArr count]==0)
                generateAgain = YES;
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];

            }
        }
    }    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // array  of same gender without repition
    
    oppGender = @"*X"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    BOOL firstQuery = [predicate evaluateWithObject:string];
    
    
    if (firstQuery)
    {
        if ([arrWithoutPlayer count]>0) {
            
            NSUInteger otherPayer = arc4random() % [arrWithoutPlayer count];
            otherPlayerName=[self check:@"*X":otherPayer:arrWithoutPlayer];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            
            string  = [string stringByReplacingOccurrencesOfString:@"*X" withString:otherPlayerName];
            NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
            [appDelegate.usedGender addObject:usedDict];
            [usedDict release];
        }
        else
            generateAgain = YES;
        
    }
    str=NSLocalizedString(@"He", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*HeX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL secondQuery4 = [predicate evaluateWithObject:string];
    
    if (secondQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2=NSLocalizedString(@"Him", @"");
            strGen = [NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];

        }
    }
    str=NSLocalizedString(@"he", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*heX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL secondQuery = [predicate evaluateWithObject:string];
    
    if (secondQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2=NSLocalizedString(@"Him", @"");
            strGen=[NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {

                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];

        }
    }
    str=NSLocalizedString(@"His", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);
  
//    oppGender = @"*HisX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL thirdQuery4 = [predicate evaluateWithObject:string];
    
    if (thirdQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2 = NSLocalizedString(@"Him", @"");
            strGen = [NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];

        }
    }
    str=NSLocalizedString(@"his", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);    
//    oppGender = @"*hisX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL thirdQuery = [predicate evaluateWithObject:string];
    
    if (thirdQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2=NSLocalizedString(@"Him", @"");
            strGen =[NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
        }
    }
    str=NSLocalizedString(@"Him", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*HimX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL fourthQuery4 = [predicate evaluateWithObject:string];
    
    if (fourthQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2 = NSLocalizedString(@"Him", @"");
            strGen=[NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
    }
    
    str=NSLocalizedString(@"him", @"");
    oppGender = [NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*himX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL fourthQuery = [predicate evaluateWithObject:string];
    
    if (fourthQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            str2 = NSLocalizedString(@"Him", @"");
            strGen=[NSString stringWithFormat:@"*%@X2",str2];
            
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:strGen withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
    }
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:string forKey:@"String"];
    
    if (generateAgain)
        [dict setObject:@"YES" forKey:@"generateNew"];
    else
        [dict setObject:@"NO" forKey:@"generateNew"];
    
    return [dict autorelease];
}

-(NSMutableDictionary *)checkPersonCodeForPreview:(NSString*)string
{
    dictionary=[[NSMutableDictionary alloc]init];
    BOOL generateAgain = NO;
    NSString *str = nil;
    
    if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
    {
        arrayOfOppositeGender = arrMale;
        arrayOfSameGender = arrFemale;
    }
    else   
    {
        arrayOfOppositeGender = arrFemale;
        arrayOfSameGender = arrMale;
    }
    
    //check for any gender with repeatition
    
    // of any gender without repition
    //----------------------------------------------------------------------------------------------------//
    
    NSString *otherPlayerName = nil;
    NSString *otherPlayerGender = nil;
    
    //{//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    NSString *oppGender = @"*XX2"; 
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        if ([arrayOfSameGender count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            string  = [string stringByReplacingOccurrencesOfString:@"*XX2" withString:otherPlayerName]; 

        }
        else
        {
            NSUInteger otherPayer = arc4random() % [arrayOfSameGender count];
            [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer] forKey:oppGender];
            string  = [string stringByReplacingOccurrencesOfString:@"*XX2" withString:[arrayOfSameGender objectAtIndex:otherPayer]]; 
            otherPlayerName=[arrayOfSameGender objectAtIndex:otherPayer];
            NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
            [appDelegate.usedGender addObject:usedDict];
            [usedDict release];
        }
    }
    str=NSLocalizedString(@"He", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*HeXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        if ([arrayOfSameGender count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"she"];
        }
    }  
    str=NSLocalizedString(@"he", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);
    //oppGender = @"*heXX2";
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
        if ([arrayOfSameGender count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"") ];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"") ];//@"she"];
        }
    }  
    
    str=NSLocalizedString(@"his", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);

//    oppGender = @"*hisXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {

        if ([arrayOfSameGender count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"") ];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"") ];//@"her"];
        }
    }  
    
    str=NSLocalizedString(@"him", @"");
    oppGender = [NSString stringWithFormat:@"*%@XX2",str];
//    NSLog(@"%@",oppGender);
//    oppGender = @"*himXX2"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    if ([predicate evaluateWithObject:string])
    {
       // NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
        if ([arrayOfSameGender count]==0)
        {
            otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
        else
        {
            if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"") ];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"") ];//@"her"];
        }
    } 
    
    //}///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    {
        //opposite gender without repitition
        oppGender = @"*XY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY2" withString:otherPlayerName];
            }
            else
            {
                NSUInteger otherPayer1 = arc4random() % [arrayOfOppositeGender count];
                [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer1] forKey:oppGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY2" withString:[arrayOfOppositeGender objectAtIndex:otherPayer1]]; 
                otherPlayerName=[arrayOfOppositeGender objectAtIndex:otherPayer1];
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];

            }
        }
        str=NSLocalizedString(@"He", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
   //     NSLog(@"%@",oppGender);

        //oppGender = @"*HeXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];

            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")]; //@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }  
        str=NSLocalizedString(@"he", @"");
        oppGender = [NSString stringWithFormat:@"*%@XY2",str];
  //      NSLog(@"%@",oppGender);
       // oppGender = @"*heXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }  
        
        str=NSLocalizedString(@"His", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY2",str];
//        NSLog(@"%@",oppGender);
        //oppGender = @"*HisXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")]; //@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        
        str=NSLocalizedString(@"his", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY2",str];
      //  NSLog(@"%@",oppGender);

        //oppGender = @"*hisXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {

            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];// @"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        
        str=NSLocalizedString(@"Him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY2",str];
    //    NSLog(@"%@",oppGender);
        
//        oppGender = @"*HimXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:@"*HimXY2" withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:@"*HimXY2" withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
        
        str=NSLocalizedString(@"him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY2",str];
    //    NSLog(@"%@",oppGender);
//        oppGender = @"*himXY2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
    }
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    {
        //check for same gender with repition
        
        oppGender = @"*XX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                NSString  *otherPlayerName = [arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XX" withString:otherPlayerName];  
            }
            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfSameGender count];
                NSString  *strotherPayer=[self check:@"*XX":otherPayer:arrayOfSameGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*XX" withString:strotherPayer];
                otherPayer=[arrayOfSameGender indexOfObject:strotherPayer];
                otherPlayerName = [arrayOfSameGender objectAtIndex:otherPayer];
                
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];

            }
        }
        
        str=NSLocalizedString(@"He", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
     //   NSLog(@"%@",oppGender);
        
        //oppGender = @"*HeXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }
        
        str=NSLocalizedString(@"he", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
   //     NSLog(@"%@",oppGender);
//        oppGender = @"*heXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }  
        str=NSLocalizedString(@"His", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
      //  NSLog(@"%@",oppGender);
//        oppGender = @"*HisXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        
        str=NSLocalizedString(@"his", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
    //    NSLog(@"%@",oppGender);
        //oppGender = @"*hisXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        str=NSLocalizedString(@"Him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
  //      NSLog(@"%@",oppGender);

        //oppGender = @"*HimXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
        str=NSLocalizedString(@"him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XX",str];
 //       NSLog(@"%@",oppGender);
//        oppGender = @"*himXX"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfSameGender count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
            else
            {
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
        
    }
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    {
        // check for opposite gender with repition
        
        oppGender = @"*XY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrayOfOppositeGender count]==0)
            {
                NSString  *otherPlayerName = [arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName];
            }
            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfOppositeGender count];
                otherPlayerName=[self check:@"*XY":otherPayer:arrayOfOppositeGender];
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName]; 
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];


            }
        }
        
        oppGender = @"*XY's"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName]; 

            }
            else
            {
                NSUInteger otherPayer = arc4random() % [arrayOfOppositeGender count];
                otherPlayerName = [arrayOfOppositeGender objectAtIndex:otherPayer];
                if (![appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    otherPlayerGender = @"Female";
                else
                    otherPlayerGender = @"Male";
                
                string  = [string stringByReplacingOccurrencesOfString:@"*XY" withString:otherPlayerName]; 
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];

            }
        }
        str=NSLocalizedString(@"He", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
  //      NSLog(@"%@",oppGender);
        
//        oppGender = @"*HeXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }  
        str=NSLocalizedString(@"he", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
 //       NSLog(@"%@",oppGender);
//        oppGender = @"*heXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }  
        str=NSLocalizedString(@"His", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
 //       NSLog(@"%@",oppGender);
       // oppGender = @"*HisXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        str=NSLocalizedString(@"his", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
  //      NSLog(@"%@",oppGender);
//        oppGender = @"*hisXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }  
        str=NSLocalizedString(@"Him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*HimXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
        str=NSLocalizedString(@"him", @"");
        oppGender=[NSString stringWithFormat:@"*%@XY",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*himXY"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        if ([predicate evaluateWithObject:string])
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if ([otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
            else
            {
                if ([appDelegate.strCurrentPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }  
    
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    {
        NSString *oppGender = @"*X2"; 
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        
        BOOL firstQuery1 = [predicate evaluateWithObject:string];
        NSString *otherPlayerName = nil;
        NSString *otherPlayerGender = nil;
        
        
        if (firstQuery1) 
        {
            
            if ([arrWithoutPlayer count]>0) {
                
                NSUInteger otherPayer = arc4random() % [arrWithoutPlayer count];
                
                otherPlayerName = [arrWithoutPlayer objectAtIndex:otherPayer];
                otherPlayerGender = [genderWithoutPlayer objectAtIndex:otherPayer];
                [dictionary setObject:[NSString stringWithFormat:@"%d",otherPayer] forKey:oppGender];
                string  = [string stringByReplacingOccurrencesOfString:@"*X2" withString:otherPlayerName];
                
                NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
                [appDelegate.usedGender addObject:usedDict];
                [usedDict release];
            }
            else
                generateAgain = YES;
            
        }
        str=NSLocalizedString(@"He", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
 //       NSLog(@"%@",oppGender);
//        oppGender = @"*HeX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL secondQuery2 = [predicate evaluateWithObject:string];
        
        if (secondQuery2)
        {
            if ([arrWithoutPlayer count]==0)
            {
                otherPlayerName=[arrWithoutPlayer objectAtIndex:0];
                NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
                NSUInteger otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
                NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
                otherPlayerGender = [arrgender objectAtIndex:otherPayer];
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }
        
        str=NSLocalizedString(@"he", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
 //       NSLog(@"%@",oppGender);
//        oppGender = @"*heX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL secondQuery1 = [predicate evaluateWithObject:string];
        
        if (secondQuery1)
        {
            if ([arrWithoutPlayer count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
        }
        str=NSLocalizedString(@"His", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
 //       NSLog(@"%@",oppGender);
//        oppGender = @"*HisX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL thirdQuery2 = [predicate evaluateWithObject:string];
        
        if (thirdQuery2)
        {
            if ([arrWithoutPlayer count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];

            }
        }
        
        str=NSLocalizedString(@"his", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*hisX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL thirdQuery1 = [predicate evaluateWithObject:string];
        
        if (thirdQuery1)
        {
            if ([arrWithoutPlayer count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
            }
        }
        str=NSLocalizedString(@"Him", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*HimX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL fourthQuery2 = [predicate evaluateWithObject:string];
        
        if (fourthQuery2)
        {
            //NSMutableArray *filterdArr = [self filter:arrayOfOppositeGender usedArray:appDelegate.usedGender andGenderArray:nil];
            
            if ([arrWithoutPlayer count]==0)
            {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
            }
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];

            }
        }
        
        str=NSLocalizedString(@"him", @"");
        oppGender=[NSString stringWithFormat:@"*%@X2",str];
//        NSLog(@"%@",oppGender);
//        oppGender = @"*himX2"; 
        predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
        BOOL fourthQuery1 = [predicate evaluateWithObject:string];
        
        if (fourthQuery1)
        {
            
            if ([arrWithoutPlayer count]==0)
                generateAgain = YES;
            else
            {
                    if (![otherPlayerGender isEqualToString:@"Female"])
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                    else
                        string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
            }
        }
    }    
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // array  of same gender without repition
    
    oppGender = @"*X"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    
    BOOL firstQuery = [predicate evaluateWithObject:string];
    
    
    if (firstQuery)
    {
        if ([arrWithoutPlayer count]>0) {
            
            NSUInteger otherPayer = arc4random() % [arrWithoutPlayer count];
            otherPlayerName=[self check:@"*X":otherPayer:arrWithoutPlayer];
            NSArray *arrPlayerName1 = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            otherPayer=[arrPlayerName1 indexOfObject:otherPlayerName];
            NSArray *arrgender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
            otherPlayerGender = [arrgender objectAtIndex:otherPayer];
            
            string  = [string stringByReplacingOccurrencesOfString:@"*X" withString:otherPlayerName];
            NSLog(@"%@",string);
            NSMutableDictionary *usedDict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:otherPlayerName,@"Player",otherPlayerGender,@"Gender", nil];
            [appDelegate.usedGender addObject:usedDict];
            [usedDict release];

        }
        else
            generateAgain = YES;
        
    }
    str=NSLocalizedString(@"He", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);
//    oppGender = @"*HeX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL secondQuery4 = [predicate evaluateWithObject:string];
    
    if (secondQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        NSLog(@"%@",string);
    }
    
    str=NSLocalizedString(@"he", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);
//    oppGender = @"*heX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL secondQuery = [predicate evaluateWithObject:string];
    
    if (secondQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"he", @"")];//@"he"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"she", @"")];//@"she"];
        }
        NSLog(@"%@",string);
    }
    str=NSLocalizedString(@"His", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);  
//    oppGender = @"*HisX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL thirdQuery4 = [predicate evaluateWithObject:string];
    
    if (thirdQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
        }
        NSLog(@"%@",string);
    }
    
    str=NSLocalizedString(@"his", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
 //   NSLog(@"%@",oppGender);  
//    oppGender = @"*hisX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL thirdQuery = [predicate evaluateWithObject:string];
    
    if (thirdQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
        }
        else
        {
                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"his", @"")];//@"his"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her", @"")];//@"her"];
        }
        NSLog(@"%@",string);
    }
    str=NSLocalizedString(@"Him", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
    NSLog(@"%@",oppGender);  
//    oppGender = @"*HimX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL fourthQuery4 = [predicate evaluateWithObject:string];
    
    if (fourthQuery4)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
        }
        else
        {

                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"hhim", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];

        }
        NSLog(@"%@",string);
    }
    
    str=NSLocalizedString(@"him", @"");
    oppGender=[NSString stringWithFormat:@"*%@X",str];
//    NSLog(@"%@",oppGender);  
//    oppGender = @"*himX"; 
    predicate = [NSPredicate predicateWithFormat:@"(%@ contains[c] %@)", string,oppGender];
    BOOL fourthQuery = [predicate evaluateWithObject:string];
    
    if (fourthQuery)
    {
        if ([arrWithoutPlayer count]==0)
        {
            if (![otherPlayerGender isEqualToString:@"Female"])
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
            else
                string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
        }
        else
        {

                if (![otherPlayerGender isEqualToString:@"Female"])
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"him", @"")];//@"him"];
                else
                    string  = [string stringByReplacingOccurrencesOfString:oppGender withString:NSLocalizedString(@"her1", @"")];//@"her"];
        }
        NSLog(@"%@",string);
    }
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:string forKey:@"String"];
    
    if (generateAgain)
        [dict setObject:@"YES" forKey:@"generateNew"];
    else
        [dict setObject:@"NO" forKey:@"generateNew"];
    
    return [dict autorelease];
}

-(NSMutableArray *)filter:(NSMutableArray *)array usedArray:(NSMutableArray *)usedArr andGenderArray:(NSMutableArray *)genderArray
{
    NSMutableArray *filterdArray = [[[NSMutableArray alloc] initWithArray:array] autorelease];
    //BOOL repeats = NO;
    for (int i=0; i<[array count]; i++) 
    {
       // repeats = NO;
        
        NSUInteger j = 0;
        
        while (j < [usedArr count]) 
        {
            NSString *playerName = [[usedArr objectAtIndex:j] objectForKey:@"Player"];
            if ([[array objectAtIndex:i] isEqualToString:playerName]) // dont have to add into 
            {
                [filterdArray removeObject:[usedArr objectAtIndex:j]];
                //repeats = YES;
                break;
            }
            j++;
        }
        
        
    }
    
    return filterdArray;
}
// Back to Previous Screen
#pragma mark custom methods

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnOk = nil;
    NSString *btnName = nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        btnName = [NSString stringWithFormat:@"ok_iPad_%@",CurrentLang];
        imgBtnOk=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:btnName ofType:@"png"]];
        [btnOk setImage:imgBtnOk forState:UIControlStateNormal];
    }
    else
    {
        btnName = [NSString stringWithFormat:@"okbtn_%@",CurrentLang];
        imgBtnOk=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:btnName ofType:@"png"]];
        [btnOk setImage:imgBtnOk forState:UIControlStateNormal];
    }
    btnName=nil;
    [btnName release];
}

-(IBAction)back:(id)sender
{
   
    [appDelegate.arrayDirtyness removeAllObjects];
    
    if (!lbltimer.hidden) {
        if (clocktimer) 
            [clocktimer invalidate];
    }
    if([strstate isEqualToString:@"Preview"])
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
    NSArray *array = [self.navigationController viewControllers];
    
    for(int i=0; i<[array count]; i++)
    {
            if([[array objectAtIndex:i] isKindOfClass:[PlayViewController class]])
            {
                [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
                break;
            }
            
    }
}
    
}
// Ok button method
-(IBAction)confirm:(id)sender
{
    changeQue = 0;
    [appDelegate.arrayDirtyness removeAllObjects];
    
    if([strstate isEqualToString:@"Preview"])
    {
        if (clocktimer) {
            [clocktimer invalidate];
        }
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (lbltimer.hidden==NO) {
            if (clocktimer) {
                [clocktimer invalidate];
            }
             
        }
    NSArray *array = [self.navigationController viewControllers];
    
    for(int i=0; i<[array count]; i++)
    {
        if([[array objectAtIndex:i] isKindOfClass:[PlayViewController class]])
        {
            [self.navigationController popToViewController:[array objectAtIndex:i] animated:YES];
            break;
        }
        
    }
    }
}
// Camera button method
-(IBAction)camerabtnAction:(id)sender
{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [FlurryAnalytics logEvent:@"CameraBtnPressed"];
        notFromCamera = NO;
        imgPicker = [[UIImagePickerController alloc] init];
        imgPicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
        imgPicker.delegate = self;
        imgPicker.allowsEditing = YES;
        [self presentModalViewController:imgPicker animated:YES];					
    }

}
// Clock button method
-(IBAction)clockbtnAction:(id)sender
{
    
    if (timerflag)
    {
        [FlurryAnalytics logEvent:@"TimerTurnedOn"];
    lbltimer.hidden=NO; 
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [lbltimer setFont:[UIFont fontWithName:@"SegoePrint" size:50.0]];

        }
        else{
            [lbltimer setFont:[UIFont fontWithName:@"SegoePrint" size:25.0]];
        }
        [lblPlayerName setTextColor:[UIColor whiteColor]]; 
    lbltimer.text=@"00:00";
    seconds=0;
    self.clocktimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired) userInfo:nil repeats:YES];
        timerflag=NO;
    }
    else
    {
        [FlurryAnalytics logEvent:@"TimerTurnedOff"];
        timerflag=NO;
        if (clocktimer) 
            [clocktimer invalidate];
        
        lbltimer.hidden=YES; 
        timerflag=YES;

    }
}
-(void)timerFired
{
    
    seconds +=1; 
 
  int minutes = seconds / 60;
  int second = seconds %  60;
    lbltimer.text = [NSString stringWithFormat:@"%.2i:%.2i", minutes, second];

}
// changes Truth or Dare button method
-(IBAction)changeTruthOrDare:(id)sender
{
    changeQue = 1;
    if (arrayOfOppositeGender>0)
    {
        [arrayOfOppositeGender removeAllObjects];
    }
    if (arrayOfSameGender>0) 
    {
        [arrayOfSameGender removeAllObjects];
    }
    arrName = [[UserDefaultSettings sharedSetting]retrieveArray:@"Player Name"];
    self.arrWithoutPlayer = [NSMutableArray arrayWithArray:arrName];
    NSArray *arrGender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
    self.genderWithoutPlayer = [NSMutableArray arrayWithArray:arrGender];
    if (![self.strstate isEqualToString:@"Preview"])
    {
        
        for(int i=0; i<[arrGender count]; i++)
        {
            if([[arrGender objectAtIndex:i] isEqualToString:@"Male"])
            {
                if([[arrName objectAtIndex:i] isEqualToString:appDelegate.strCurrentPlayerName])
                {
                    [arrWithoutPlayer removeObjectAtIndex:i];
                    [genderWithoutPlayer removeObjectAtIndex:i];
                }
                else
                {
                    [arrMale addObject:[arrName objectAtIndex:i]];
                }
                
            }
            else
            {
                if([[arrName objectAtIndex:i] isEqualToString:appDelegate.strCurrentPlayerName])
                {
                    [arrWithoutPlayer removeObjectAtIndex:i];
                    [genderWithoutPlayer removeObjectAtIndex:i];
                    
                }
                else
                {
                    [arrFemale addObject:[arrName objectAtIndex:i]];
                }
            }
        }
    }

    [FlurryAnalytics logEvent:@"ChangeChallengePressed"];
    if (!timerflag) {
        timerflag=YES;
        if (clocktimer) 
            [clocktimer invalidate];
        lbltimer.hidden=YES; 
    }
    

    if([strMode isEqualToString:@"Truth"])
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:170.0/255.0 green:213.0/255.0 blue:114.0/255.0 alpha:1.0]];
        if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            randomNumber = [self generateMaleTruthId];
        else
            randomNumber = [self generateFemaleTruthId];
    }
    else
    {
        [lblDisplayText setTextColor:[UIColor colorWithRed:253.0/255.0 green:144.0/255.0 blue:144.0/255.0 alpha:1.0]];
        if([appDelegate.strCurrentPlayerGender isEqualToString:@"Male"])
            randomNumber = [self generateMaleDareId];
        else
            randomNumber = [self generateFemaleDareId];
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationDuration:0.20];
    [lblDisplayText setAlpha:0];
    [btnOk setAlpha:0];
    [UIView commitAnimations];
    
}

//UIImagePickerController Delegate Methods for camera
#pragma mark -
#pragma mark UIImagePickerController delegate
#pragma mark 
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
	
}
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageWriteToSavedPhotosAlbum(image, nil,nil, nil);
    [picker dismissModalViewControllerAnimated:YES];
    [picker release];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
// iAds delegate methods
//#pragma bannerview delegate methode
- (void)layoutAnimated:(BOOL)animated
{
    
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = mopubclass.mpAdView.frame;
    
    contentFrame.size.height -= mopubclass.mpAdView.frame.size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor blackColor];
    bannerFrame.origin.y = contentFrame.size.height;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        _contentView.frame = contentFrame;
        
        [_contentView layoutIfNeeded];
        mopubclass.mpAdView.frame = bannerFrame;
    }];
}
//
//
//
//- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
//{
//    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
//        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierPortrait;
//    } else {
//        _bannerView.currentContentSizeIdentifier = ADBannerContentSizeIdentifierLandscape;
//    }
//    [self layoutAnimated:duration > 0.0];
//}
//
//- (void)bannerViewDidLoadAd:(ADBannerView *)banner
//{
//    [self layoutAnimated:YES];
//}
//
//
//- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
//{
//    [self layoutAnimated:YES];
//}
//
//- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
//{
//    notFromTestAdv = NO;
//    return YES;
//}
- (void)willPresentModalViewForAd:(MPAdView *)view{
    notFromTestAdv = NO;
}
//- (void)bannerViewActionDidFinish:(ADBannerView *)banner
//{
//    
//}
// Generate Random Male Truth ID
-(int)generateMaleTruthId
{
  
    int randomValue;
    int num=0;
    BOOL flag = NO;
    
    
    randomValue = arc4random() % [appDelegate.arrDelegateMaleTruth count];
    
    if([appDelegate.arrMaleTruthChallengeId count] > 0)
    {
         NSString *strId = [NSString stringWithFormat:@"%@", [[appDelegate.arrDelegateMaleTruth objectAtIndex:randomValue] valueForKey:@"pkTruthChallengeID"]]; 
        
        if([appDelegate.arrDelegateMaleTruth count] == [appDelegate.arrMaleTruthChallengeId count])
        {
            [appDelegate.arrMaleTruthChallengeId removeAllObjects];
            num = randomValue;
        }
        else
        {
            for(int i=0; i<[appDelegate.arrMaleTruthChallengeId count]; i++)
            {
                if([[appDelegate.arrMaleTruthChallengeId objectAtIndex:i] isEqualToString:strId])
                {
                    flag = YES;
                    break;
                }
                else
                {
                    num = randomValue;
                }
            }
        }
        
    }
    else
    {
        
        num = randomValue;
    }
    
    if(flag)
    {
        num = [self generateMaleTruthId];
       
    }
    
    return num;
}
// Generate Random Male Dare ID
-(int)generateMaleDareId
{
    int randomValue;
    int num=0;
    BOOL flag = NO;
    
    
    randomValue = arc4random() % [appDelegate.arrDelegateMaleDare count];
    
    NSString *strId = nil;
    
    
    if([appDelegate.arrMaleDareChallengeId count] > 0)
    {
         strId = [NSString stringWithFormat:@"%@", [[appDelegate.arrDelegateMaleDare objectAtIndex:randomValue] valueForKey:@"pkDaresChallengeID"]]; 
        if([appDelegate.arrDelegateMaleDare count] == [appDelegate.arrMaleDareChallengeId count])
        {
            [appDelegate.arrMaleDareChallengeId removeAllObjects];
            num = randomValue;
        }
        else
        {
            for(int i=0; i<[appDelegate.arrMaleDareChallengeId count]; i++)
            {
                if([[appDelegate.arrMaleDareChallengeId objectAtIndex:i] isEqualToString:strId])
                {
                    flag = YES;
                    break;
                }
                else
                {
                    num = randomValue;
                }
            }
        }
        
    }
    else
    {
        
        num = randomValue;
    }
    
    if(flag)
    {
        num = [self generateMaleDareId];
        
    }
    
    return num;

}
// Generate Random Female Truth ID
-(int)generateFemaleTruthId
{
    int randomValue;
    int num=0;
    BOOL flag = NO;
    
    
    randomValue = arc4random() % [appDelegate.arrDelegateFemaleTruth count];
    
    NSString *strId = [NSString stringWithFormat:@"%@", [[appDelegate.arrDelegateFemaleTruth objectAtIndex:randomValue] valueForKey:@"pkTruthChallengeID"]]; 
    
    
    if([appDelegate.arrFemaleTruthChallengeId count] > 0)
    {
        if([appDelegate.arrDelegateFemaleTruth count] == [appDelegate.arrFemaleTruthChallengeId count])
        {
            [appDelegate.arrFemaleTruthChallengeId removeAllObjects];
            num = randomValue;
        }
        else
        {
            for(int i=0; i<[appDelegate.arrFemaleTruthChallengeId count]; i++)
            {
                if([[appDelegate.arrFemaleTruthChallengeId objectAtIndex:i] isEqualToString:strId])
                {
                    flag = YES;
                    break;
                }
                else
                {
                    num = randomValue;
                }
            }
        }
        
    }
    else
    {
        
        num = randomValue;
    }
    
    if(flag)
    {
        num = [self generateFemaleTruthId];
        
    }
    
    return num;

}
// Generate Random Female Dare ID
-(int)generateFemaleDareId
{
    int randomValue;
    int num;
    BOOL flag = NO;
    
    
    randomValue = arc4random() % [appDelegate.arrDelegateFemaleDare count];
    
    NSString *strId = [NSString stringWithFormat:@"%@", [[appDelegate.arrDelegateFemaleDare objectAtIndex:randomValue] valueForKey:@"pkDaresChallengeID"]]; 
    
    
    if([appDelegate.arrFemaleDareChallengeId count] > 0)
    {
        if([appDelegate.arrDelegateFemaleDare count] == [appDelegate.arrFemaleDareChallengeId count])
        {
            [appDelegate.arrFemaleDareChallengeId removeAllObjects];
            num = randomValue;
        }
        else
        {
            for(int i=0; i<[appDelegate.arrFemaleDareChallengeId count]; i++)
            {
                if([[appDelegate.arrFemaleDareChallengeId objectAtIndex:i] isEqualToString:strId])
                {
                    flag = YES;
                    break;
                }
                else
                {
                    num = randomValue;
                }
            }
        }
        
    }
    else
    {
        
        num = randomValue;
    }
    
    if(flag)
    {
        num = [self generateFemaleDareId];
        
    }
    
    return num;
    
}
- (void)adViewDidFailToLoadAd:(MPAdView *)view{
    NSLog(@"ads failed to receive");
}
- (void)adViewDidLoadAd:(MPAdView *)view
{
    CGSize size = [view adContentViewSize];
    CGRect newFrame = view.frame;
    newFrame.size = size;
    newFrame.origin.x = (self.view.bounds.size.width - size.width) / 2;
    view.frame = newFrame;
    [self layoutAnimated:YES];
    mopubclass.mpAdView.hidden=NO;
    NSLog(@"ads suceessful to receive");
}
- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}

- (void)dealloc
{
    mopubclass.mpAdView.delegate=nil;
 
    if (audioPlayer) {
        [audioPlayer release];
    }
    if(clocktimer)
    {
        [clocktimer invalidate];
         self.clocktimer = nil;
    }
    arrWithoutPlayer=nil;
    genderWithoutPlayer=nil;
    [super dealloc];
}

@end
