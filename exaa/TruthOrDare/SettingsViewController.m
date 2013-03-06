

#import "SettingsViewController.h"
#import "TruthAndDareList.h"
#import "UserDefaultSettings.h"
#import "PlayerselectionVC.h"
//
//#import "Constant.h"

@implementation SettingsViewController

@synthesize flagAutoTruth;
@synthesize strSound1;
@synthesize strTakesTrueInOrder;
@synthesize strMyDaresOnly;
@synthesize strAllowChangingDares;
@synthesize strAlertMessage;
@synthesize dictAlertMessage;
@synthesize strClean;
@synthesize strDirty;
@synthesize strSuperDirty;
@synthesize strTruthMode;
@synthesize strSpeed;
@synthesize strAutoTruth;
@synthesize dictSettings;
@synthesize strLanguage;

@synthesize popoverController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
}

#pragma mark - View lifecycle

-(void)dealloc
{
    strLanguage=nil;
    [strLanguage release];
    strSound1=nil;
    [strSound1 release];
    strTakesTrueInOrder=nil;
    [strTakesTrueInOrder release];
    strMyDaresOnly=nil;
    [strMyDaresOnly release];
    strAllowChangingDares=nil;
    [strAllowChangingDares release];
    strClean=nil;
    [strClean release];
    strDirty=nil;
    [strDirty release];
    strSuperDirty=nil;
    [strSuperDirty release];
    strTruthMode=nil;
    [strTruthMode release];
    strSpeed=nil;
    [strSpeed release];
    strAutoTruth=nil;
    [strAutoTruth release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
       
    thisDevice = [UIDevice currentDevice];
    
    flgSpeed = NO;
    flgAutoTruth = NO;
    
    flagLang = NO;
    strTemp =nil;
    
    self.dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    if([dictSettings count] == 0)
    {
        self.strSound1 =  @"ON";
        self.strTakesTrueInOrder = @"OFF";
        self.strMyDaresOnly = @"OFF";
        self.strAllowChangingDares = @"ON";
        self.strClean = @"ON";
        self.strDirty = @"ON";
        self.strSuperDirty = @"OFF";
        self.strTruthMode = @"Off";
        self.strSpeed = @"3";
        self.strAutoTruth = @"6";
        self.strLanguage=nil;
        
        if ([CurrentLang isEqualToString:@"en"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"es"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"de"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"fr"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        
        if ([strTruthMode isEqualToString:@"Off"])
            flagAutoTruth = YES;
        else
            flagAutoTruth = NO;
    }
    else
    {
        self.strSound1 = [dictSettings valueForKey:@"Sound"];
        self.strTakesTrueInOrder = [dictSettings valueForKey:@"Takes True In Order"];
        self.strMyDaresOnly = [dictSettings valueForKey:@"My Dares Only"];
        self.strAllowChangingDares = [dictSettings valueForKey:@"Allow Changing Dares"];
        self.strClean = [dictSettings valueForKey:@"Clean"];
        self.strDirty = [dictSettings valueForKey:@"Dirty"];
        self.strSuperDirty = [dictSettings valueForKey:@"Super Dirty"];
        self.strTruthMode = [dictSettings valueForKey:@"Truth Mode"];
        self.strSpeed = [dictSettings valueForKey:@"Speed"];
        self.strAutoTruth = [dictSettings valueForKey:@"Auto Truth"];

        if ([CurrentLang isEqualToString:@"en"]) 
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"es"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"de"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        else if([CurrentLang isEqualToString:@"fr"])
            self.strLanguage=NSLocalizedString(@"Language", @" ");
        
        if ([strTruthMode isEqualToString:@"Off"])
            flagAutoTruth = YES;
        else
            flagAutoTruth = NO;
    }
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:42.0]];
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider.png"]];
        [tblSettings setSeparatorColor:color];
    }
    else
    {
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider.png"]];
        [tblSettings setSeparatorColor:color];
    }
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication] delegate];
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *pref = [NSUserDefaults standardUserDefaults];
    strTemp = [pref stringForKey:@"temp"];
    
    if ([strTemp length]!=0) {
        [arrLang replaceObjectAtIndex:0 withObject:strTemp];
    }
    
    tblSettings.backgroundColor = [UIColor clearColor];
    
    if(flgSpeed)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        strSpeed = [prefs stringForKey:@"speed"]; 
        flgSpeed = NO;
    }
    if(flgAutoTruth)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        strAutoTruth = [prefs stringForKey:@"auto truth"]; 
        flgAutoTruth = NO;
    }
    if (flagLang) 
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        strLanguage = [prefs stringForKey:@"language"];
        flagLang=NO;
    }
    if ([strLanguage isEqualToString:@" English"])
    {
        arrLang = [[NSMutableArray alloc]initWithObjects:@"en",@"es",@"de",@"fr", nil];
        [[NSUserDefaults standardUserDefaults]setObject:arrLang forKey:@"AppleLanguages"];
    }
    else if ([strLanguage isEqualToString:@" Español"])
    {
        arrLang = [[NSMutableArray alloc]initWithObjects:@"es",@"en",@"de",@"fr", nil];
        [[NSUserDefaults standardUserDefaults]setObject:arrLang forKey:@"AppleLanguages"];
    }
    else if ([strLanguage isEqualToString:@" Deutsch"])
    {
        arrLang = [[NSMutableArray alloc]initWithObjects:@"de",@"es",@"en",@"fr", nil];
        [[NSUserDefaults standardUserDefaults]setObject:arrLang forKey:@"AppleLanguages"];
    }
    else if ([strLanguage isEqualToString:@" Français"])
    {
        arrLang = [[NSMutableArray alloc]initWithObjects:@"fr",@"es",@"de",@"en", nil];
        [[NSUserDefaults standardUserDefaults]setObject:arrLang forKey:@"AppleLanguages"];
    }
    [self update_UI];
    
    lblTitle.text=NSLocalizedString(@"Settings label", @"");
}

#pragma mark custom methods
//set Cell Frame as per String (iPad)
-(SettingsSegmentCustomCell *)setCellForiPad:(SettingsSegmentCustomCell *)cell :(CGSize)size
{
    if ([CurrentLang isEqualToString:@"es"])
    {
        if (size.width > 370)
        {
            int lblHeight = (int)((size.width/370));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8,10,370, size.height*lblHeight+44);
            cell.segmentedControl.frame = CGRectMake(440,(cell.lbl.frame.size.height-40)/2, 300, 50);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8,15,370, size.height);
            cell.segmentedControl.frame = CGRectMake(440, 22, 300, 50);
        }
        [cell.segmentedControl setWidth:140 forSegmentAtIndex:0];
    }
    else if ([CurrentLang isEqualToString:@"fr"])
    {
        if (size.width > 370)
        {
            int lblHeight = (int)((size.width/370));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8,10,370, size.height*lblHeight+44);
            cell.segmentedControl.frame = CGRectMake(470,(cell.lbl.frame.size.height-40)/2, 270, 50);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8,15,370, size.height);
            cell.segmentedControl.frame = CGRectMake(470, 22, 270, 50);
        }
        [cell.segmentedControl setWidth:135 forSegmentAtIndex:0];
    }
    else if ([CurrentLang isEqualToString:@"de"])
    {
        if (size.width > 370)
        {
            int lblHeight = (int)((size.width/370));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8,10,370, size.height*lblHeight+44);
            cell.segmentedControl.frame = CGRectMake(470,(cell.lbl.frame.size.height-40)/2, 270, 50);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8,15,370, size.height);
            cell.segmentedControl.frame = CGRectMake(470, 22, 270, 50);
        }
        [cell.segmentedControl setWidth:135 forSegmentAtIndex:0];
    }
    else
    {
        cell.segmentedControl.frame = CGRectMake(490, 22, 250, 50);
        cell.lbl.frame = CGRectMake(10, 18, 450, 60);
        [cell.segmentedControl setWidth:125 forSegmentAtIndex:0];
    }
    return cell;
}

//set Cell Frame as per String (iPhone)
-(SettingsSegmentCustomCell *)setCellForiPhone:(SettingsSegmentCustomCell *)cell :(CGSize)size
{
    if ([CurrentLang isEqualToString:@"es"])
    {
        if (size.width > 160)
        {
            int lblHeight = (int)((size.width/160));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8, 5,160, size.height*lblHeight+23);
            cell.segmentedControl.frame = CGRectMake(155,(cell.lbl.frame.size.height-20)/2, 160, 30);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8,5,160, size.height);
            cell.segmentedControl.frame = CGRectMake(155,6.5, 160, 30);
        }
        [cell.segmentedControl setWidth:70 forSegmentAtIndex:0];
    }
    else if ([CurrentLang isEqualToString:@"fr"])
    {
        if (size.width > 165)
        {
            int lblHeight = (int)((size.width/165));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8, 5,160, size.height*lblHeight+23);
            cell.segmentedControl.frame = CGRectMake(180,(cell.lbl.frame.size.height-20)/2, 130, 30);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8, 5,160, size.height);
            cell.segmentedControl.frame = CGRectMake(180,8, 130, 30);
        }
        [cell.segmentedControl setWidth:55 forSegmentAtIndex:0];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        if (size.width > 195)
        {
            int lblHeight = (int)((size.width/195));
            cell.lbl.lineBreakMode = UILineBreakModeWordWrap;
            cell.lbl.numberOfLines = 0;
            cell.lbl.frame = CGRectMake(8, 5,160, size.height*lblHeight+23);
            cell.segmentedControl.frame = CGRectMake(210,(cell.lbl.frame.size.height-20)/2, 100, 30);
        }
        else
        {
            cell.lbl.frame = CGRectMake(8, 5,160, size.height);
            cell.segmentedControl.frame = CGRectMake(210, 8, 100, 30);
        }
        [cell.segmentedControl setWidth:50 forSegmentAtIndex:0];
    }
    else
    {
        cell.lbl.frame = CGRectMake(8,5, 240, 37);
        cell.segmentedControl.frame = CGRectMake(210, 8, 100, 30);
        [cell.segmentedControl setWidth:50 forSegmentAtIndex:0];
    }
    return cell;
}

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnAddDare = nil;
    NSString *btnName = nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        btnName = [NSString stringWithFormat:@"adddaresbtn_iPad_%@",CurrentLang];
        imgBtnAddDare = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:btnName ofType:@"png"]];
        [btnAddDare setImage:imgBtnAddDare forState:UIControlStateNormal];
    }
    else
    {
        btnName = [NSString stringWithFormat:@"adddare_%@",CurrentLang];
        imgBtnAddDare = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:btnName ofType:@"png"]];
        [btnAddDare setImage:imgBtnAddDare forState:UIControlStateNormal];
    }
    NSLog(@"add dare name = %@",btnName);
    [tblSettings reloadData];
}

//go to Display Player Name screen 

-(void)showPopOver:(UITableViewCell*)cell
{
    if (self.popoverController == nil)
    {
        UITableViewController *tableVC = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
        tableVC.tableView.dataSource = self;
        tableVC.tableView.delegate = self;
        UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:tableVC];
        
        popover.delegate = self;
        [tableVC release];
        
        self.popoverController = popover;
        [popover release];
    }
}

-(IBAction)back
{
    appDelegate.changedirtiness=NO;
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
    
    if([strClean isEqualToString:@"OFF"]&&[strDirty isEqualToString:@"OFF"]&&[strSuperDirty isEqualToString:@"OFF"])
    {
        self.strAlertMessage = NSLocalizedString(@"You cannot disable all dares", @"");
        self.dictAlertMessage = [[[NSMutableDictionary alloc] init] autorelease];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
    }
    else
    {
        NSString *strAutoTruthFlag = @"YES";
        if (flagAutoTruth)
            strAutoTruthFlag = @"YES";
        else
            strAutoTruthFlag = @"NO";
        
        NSArray *objects = [NSArray arrayWithObjects:
                            self.strSound1, 
                            strTakesTrueInOrder, 
                            strMyDaresOnly,
                            strAllowChangingDares,
                            strClean,
                            strDirty,
                            strSuperDirty,
                            strTruthMode,
                            strSpeed,
                            strAutoTruth,
                            strAutoTruthFlag,
                            strLanguage,
                            nil];
        NSArray *keys = [NSArray arrayWithObjects:@"Sound", @"Takes True In Order", @"My Dares Only", @"Allow Changing Dares", @"Clean", @"Dirty", @"Super Dirty", @"Truth Mode", @"Speed", @"Auto Truth",@"AutoTruthFlag",@"Language Support",nil];
        
        self.dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [[UserDefaultSettings sharedSetting] storeDictionary:self.dictSettings withKey:@"Settings"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}
//go to Truth and dare Display screen method
-(IBAction)addDare
{
    TruthAndDareList *truthObj;
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        truthObj = [[TruthAndDareList alloc] initWithNibName:@"TruthAndDareList_iPad" bundle:nil];
    }
    else
    {
        truthObj = [[TruthAndDareList alloc] initWithNibName:@"TruthAndDareList" bundle:nil];
    }
    
    [self.navigationController pushViewController:truthObj animated:YES];
    [truthObj release];
}
//go to tableView delegate  methods
#pragma mark table delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 4;
    else if(section == 1)
        return 3;
    else if(section==2)
        return 3;
    else
        return 1;
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) 
    {
        NSString *SegmentCustomCell = @"SegmentCustomCell";
        
        SettingsSegmentCustomCell *segCell = [tableView dequeueReusableCellWithIdentifier:SegmentCustomCell];
        
        if (segCell==nil) 
        {
            segCell = [[[SettingsSegmentCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:SegmentCustomCell] autorelease];
            segCell.delegate = self;
        }
        
        [segCell.segmentedControl setTitle:NSLocalizedString(@"On", @"") forSegmentAtIndex:0];
        [segCell.segmentedControl setTitle:NSLocalizedString(@"Off", @"") forSegmentAtIndex:1];
        
        segCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 0) 
        {
            if(indexPath.row == 0)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Sound", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Sound", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell :size];
                }
                
                segCell.lbl.text = NSLocalizedString(@"Sound", @"");
                segCell.segmentedControl.tag = 999;
                if ([self.strSound1 isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
                
            }
            if(indexPath.row == 1)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Take turns in order", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Take turns in order", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell :size];
                }
                segCell.lbl.text = NSLocalizedString(@"Take turns in order", @"");
                segCell.segmentedControl.tag = 1;
                if ([strTakesTrueInOrder isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
            }
            if(indexPath.row == 2)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"My Dares Only", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell:size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"My Dares Only", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell:size];
                }
                
                segCell.lbl.text = NSLocalizedString(@"My Dares Only", @"");
                segCell.segmentedControl.tag = 2;
                if ([strMyDaresOnly isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
            }
            if(indexPath.row == 3)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Allow Changing Dares", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Allow Changing Dares", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell:size];
                }
                
                segCell.lbl.text = NSLocalizedString(@"Allow Changing Dares", @"");
                segCell.segmentedControl.tag = 3;
                if ([strAllowChangingDares isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
            }
        }
        
        if(indexPath.section == 1)
        {
            if(indexPath.row == 0)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Clean", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Clean", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell :size];
                }
                
                segCell.lbl.text = NSLocalizedString(@"Clean", @"");
                segCell.segmentedControl.tag = 4;
                if ([strClean isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
            }
            else if(indexPath.row == 1)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell:size];
                }
                
                segCell.segmentedControl.tag = 5;
                if ([strDirty isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
                segCell.lbl.text = NSLocalizedString(@"Dirty", @"");
            }
            else if(indexPath.row == 2)
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                {
                    CGSize size = [NSLocalizedString(@"Super Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]] ;
                    segCell = [self setCellForiPad:segCell :size];
                }
                else
                {
                    CGSize size = [NSLocalizedString(@"Super Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]] ;
                    segCell = [self setCellForiPhone:segCell:size];
                }
                segCell.lbl.text = NSLocalizedString(@"Super Dirty", @"");
                segCell.segmentedControl.tag = 6;
                if ([strSuperDirty isEqualToString:@"ON"])
                    segCell.segmentedControl.selectedSegmentIndex = 0;
                else
                    segCell.segmentedControl.selectedSegmentIndex = 1;
            }
        }
        
        segCell.segmentedControl.tag = indexPath.row;
        
        return segCell;
    }
    
    if(indexPath.section == 2)
    {
        NSString *ThirdCell = @"ThirdCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdCell];
        cell = nil;
        
        if (cell==nil) 
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ThirdCell] autorelease];
        }
        
        if(indexPath.row == 0)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                UILabel *lbl = [[[UILabel alloc] init]autorelease];
                if ([CurrentLang isEqualToString:@"es"])
                {
                    lbl.frame = CGRectMake(10, 18, 250, 60);
                }
                else
                    lbl.frame = CGRectMake(10, 18, 300, 60);
                lbl.text= NSLocalizedString(@"Mode",@"");
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                [lbl setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
                [cell addSubview:lbl];
            }
        }
        else if(indexPath.row == 1)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]]autorelease ];
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(670,10, 100, 37)];
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:35.0];
                lbl.text=strSpeed;
                [cell addSubview:lbl];
                [lbl release];
                
                UILabel *lblSpeed=[[UILabel alloc]initWithFrame:CGRectMake(10,7, 300, 60)];
                lblSpeed.backgroundColor=[UIColor clearColor];
                lblSpeed.textColor=[UIColor whiteColor];
                lblSpeed.font=[UIFont fontWithName:@"SegoePrint-Bold" size:35.0];
                lblSpeed.text=NSLocalizedString(@"Speed", @"");
                [cell addSubview:lblSpeed];
                [lblSpeed release];
                
                UILabel *lblDiscription=[[UILabel alloc]initWithFrame:CGRectMake(10,55, 690, 90)];
                lblDiscription.backgroundColor=[UIColor clearColor];
                lblDiscription.textColor=[UIColor whiteColor];
                lblDiscription.numberOfLines=2;
                lblDiscription.font=[UIFont fontWithName:@"SegoePrint-Bold" size:23.0];
                lblDiscription.text=NSLocalizedString(@"Increase dirtiness", @"");
                CGSize size = [NSLocalizedString(@"Increase dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:23.0]];
                if (size.width > 700)
                {
                    lblDiscription.lineBreakMode = UILineBreakModeWordWrap;
                    lblDiscription.numberOfLines = 0;
                    int lblHeight = (int)(size.width/700);
                    lblDiscription.frame = CGRectMake(10,55, 700, size.height*lblHeight+50);
                }
                [cell addSubview:lblDiscription];
                [lblDiscription release];
            }
            else
            {
                cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]]autorelease ];
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(270,0, 100, 37)];
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:16.0];
                lbl.text=strSpeed;
                [cell addSubview:lbl];
                [lbl release];
                UILabel *lblSpeed=[[UILabel alloc]initWithFrame:CGRectMake(10,0, 100, 37)];
                lblSpeed.backgroundColor=[UIColor clearColor];
                lblSpeed.textColor=[UIColor whiteColor];
                lblSpeed.font=[UIFont fontWithName:@"SegoePrint-Bold" size:16.0];
                lblSpeed.text=NSLocalizedString(@"Speed", @"");
                
                [cell addSubview:lblSpeed];
                [lblSpeed release];
                UILabel *lblDiscription=[[UILabel alloc]initWithFrame:CGRectMake(10,23, 270, 60)];
                lblDiscription.backgroundColor=[UIColor clearColor];
                lblDiscription.textColor=[UIColor whiteColor];
                lblDiscription.numberOfLines=2;
                lblDiscription.font=[UIFont fontWithName:@"SegoePrint-Bold" size:12.0];
                lblDiscription.text=NSLocalizedString(@"Increase dirtiness", @"");
                CGSize size = [NSLocalizedString(@"Increase dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:12.0]];
                if (size.width > 290)
                {
                    lblDiscription.lineBreakMode = UILineBreakModeWordWrap;
                    lblDiscription.numberOfLines = 0;
                    int lblHeight = (int)(size.width/290);
                    lblDiscription.frame = CGRectMake(10, 23, 290,size.height*lblHeight+40);
                }
                
                [cell addSubview:lblDiscription];
                [lblDiscription release];
            }
        }
        else if(indexPath.row == 2)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]] autorelease];
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(670,10, 100, 37)];
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:35.0];
                lbl.text=strAutoTruth;
                [cell addSubview:lbl];
                [lbl release];
                UILabel *lblSpeed=[[UILabel alloc]initWithFrame:CGRectMake(10,7, 350, 60)];
                lblSpeed.backgroundColor=[UIColor clearColor];
                lblSpeed.textColor=[UIColor whiteColor];
                lblSpeed.font=[UIFont fontWithName:@"SegoePrint-Bold" size:35.0];
                lblSpeed.text=NSLocalizedString(@"Auto Challenge", @"");
                [cell addSubview:lblSpeed];
                [lblSpeed release];
                UILabel *lblDiscription=[[UILabel alloc]initWithFrame:CGRectMake(10,55, 660, 90)];
                lblDiscription.backgroundColor=[UIColor clearColor];
                lblDiscription.textColor=[UIColor whiteColor];
                lblDiscription.numberOfLines=2;
                lblDiscription.font=[UIFont fontWithName:@"SegoePrint-Bold" size:23.0];
                lblDiscription.text= NSLocalizedString(@"Auto Challenge message", @"");
                CGSize size = [NSLocalizedString(@"Auto Challenge message", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:23.0]];
                if (size.width > 700)
                {
                    lblDiscription.lineBreakMode = UILineBreakModeWordWrap;
                    lblDiscription.numberOfLines = 0;
                    int lblHeight = (int)(size.width/700);
                    lblDiscription.frame = CGRectMake(10,55, 700, size.height*lblHeight+50);
                }
                
                [cell addSubview:lblDiscription];
                [lblDiscription release];
            }
            else
            {
                cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]] autorelease];
                UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(270,0, 100, 37)];
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:16.0];
                lbl.text=strAutoTruth;
                [cell addSubview:lbl];
                [lbl release];
                UILabel *lblSpeed=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 170, 37)];
                lblSpeed.backgroundColor=[UIColor clearColor];
                lblSpeed.textColor=[UIColor whiteColor];
                lblSpeed.font=[UIFont fontWithName:@"SegoePrint-Bold" size:16.0];
                lblSpeed.text=NSLocalizedString(@"Auto Challenge", @"");//@"Auto Challenge";
                [cell addSubview:lblSpeed];
                [lblSpeed release];
                UILabel *lblDiscription=[[UILabel alloc]initWithFrame:CGRectMake(10, 23, 280, 60)];
                lblDiscription.backgroundColor=[UIColor clearColor];
                lblDiscription.textColor=[UIColor whiteColor];
                lblDiscription.numberOfLines=2;
                lblDiscription.font=[UIFont fontWithName:@"SegoePrint-Bold" size:12.0];
                lblDiscription.text=NSLocalizedString(@"Auto Challenge message", @"");
                CGSize size = [NSLocalizedString(@"Auto Challenge message", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:12.0]];
                if (size.width > 290)
                {
                    lblDiscription.lineBreakMode = UILineBreakModeWordWrap;
                    lblDiscription.numberOfLines = 0;
                    int lblHeight = (int)(size.width/290);
                    lblDiscription.frame = CGRectMake(10, 23, 290,size.height*lblHeight+40);
                }
                
                [cell addSubview:lblDiscription];
                [lblDiscription release];
            }
        }
        
        if(indexPath.row == 0)
        {
            UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
                                                    [NSArray arrayWithObjects:NSLocalizedString(@"Off", @""),NSLocalizedString(@"All Truths", @""),NSLocalizedString(@"All Dares", @""),nil]];
            [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
            
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                if ([CurrentLang isEqualToString:@"es"])
                    segmentedControl.frame = CGRectMake(120, 22, 630, 50);
                else if([CurrentLang isEqualToString:@"fr"])
                    segmentedControl.frame = CGRectMake(150, 22, 600, 50);
                else if([CurrentLang isEqualToString:@"de"])
                    segmentedControl.frame = CGRectMake(200, 22, 600, 50);
                else
                    segmentedControl.frame = CGRectMake(((tblSettings.frame.size.width)-440-20), 22, 440, 50);
            }
            else
            {
                if ([CurrentLang isEqualToString:@"es"]) 
                {
                    segmentedControl.frame = CGRectMake(4, 8, 313, 30);
                }
                else
                    segmentedControl.frame = CGRectMake(7, 8, 307, 30);
            }
            
            segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
            
            if([strTruthMode isEqualToString:@"Off"])
                segmentedControl.selectedSegmentIndex = 0;
            else if([strTruthMode isEqualToString:@"All Truth"])
                segmentedControl.selectedSegmentIndex = 1;
            else
                segmentedControl.selectedSegmentIndex = 2;
            
            segmentedControl.tag = 7;
            NSString *str = [[UIDevice currentDevice] systemVersion];
            float version = str.floatValue;
            if(version == 5.0)
            {
                UIFont *font;
                if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    font = [UIFont boldSystemFontOfSize:24.0f];
                }
                else
                {
                    font = [UIFont boldSystemFontOfSize:12.0f];
                }
                
                NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
                [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            }
            else
            {
                UIFont *font;
                if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    font = [UIFont boldSystemFontOfSize:24.0f];
                }
                else
                {
                    for (id segment in [segmentedControl subviews]) 
                    {
                        for (id label in [segment subviews]) 
                        {
                            if ([label isKindOfClass:[UILabel class]])
                            {
                                UILabel *lbel = (UILabel *)label;
                                lbel.adjustsFontSizeToFitWidth = YES;
                                [label setTextAlignment:UITextAlignmentCenter];
                                [label setFont:[UIFont boldSystemFontOfSize:12.0f]];
                            }
                        }           
                    }
                }
            }
            
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                if ([CurrentLang isEqualToString:@"es"])
                {
                    [segmentedControl setWidth:160 forSegmentAtIndex:0];
                    [segmentedControl setWidth:210 forSegmentAtIndex:1];
                }
                else if ([CurrentLang isEqualToString:@"fr"])
                {
                    [segmentedControl setWidth:120 forSegmentAtIndex:0];
                    [segmentedControl setWidth:220 forSegmentAtIndex:1];
                    
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    [segmentedControl setWidth:120 forSegmentAtIndex:0];
                    [segmentedControl setWidth:220 forSegmentAtIndex:1];
                    [segmentedControl setWidth:200 forSegmentAtIndex:2];
                }
            }
            else
            {
                if ([CurrentLang isEqualToString:@"es"])                
                {
                    [segmentedControl setWidth:80 forSegmentAtIndex:0];
                    [segmentedControl setWidth:103 forSegmentAtIndex:1];
                }
                else if ([CurrentLang isEqualToString:@"de"])
                {
                    [segmentedControl setWidth:65 forSegmentAtIndex:0];
                    [segmentedControl setWidth:125 forSegmentAtIndex:1];
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    [segmentedControl setWidth:57 forSegmentAtIndex:0];
                    [segmentedControl setWidth:118 forSegmentAtIndex:1];
                }
                
            }
            [cell addSubview:segmentedControl];
            
            [segmentedControl release];
        }
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [cell.textLabel setFont:[UIFont fontWithName:@"Segoe Print" size:30.0]];
        }
        else
        {
            [cell.textLabel setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
        }
        
        cell.textLabel.textColor = [UIColor whiteColor];
        
        UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider.png"]];
        [tblSettings setSeparatorColor:color];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    if (indexPath.section==3) 
    {
        NSString *ThirdCell = @"ThirdCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ThirdCell];
        cell = nil;
        
        if (cell==nil)
        {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ThirdCell] autorelease];
        }
        
        if(indexPath.row == 0)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                cell.accessoryView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]]autorelease];
                
                UILabel *lbl = [[UILabel alloc] init];
                lbl.frame = CGRectMake(10, 10, 300, 60);
                lbl.text= strLanguage;
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                [lbl setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
                [cell addSubview:lbl];
                [lbl release];
            }
            else
            {
                cell.accessoryView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]]autorelease];
                
                UILabel *lbl = [[UILabel alloc] init];
                lbl.frame = CGRectMake(10, 5, 100, 37);
                lbl.text= strLanguage;
                lbl.backgroundColor=[UIColor clearColor];
                lbl.textColor=[UIColor whiteColor];
                [lbl setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:16.0]];
                [cell addSubview:lbl];
                [lbl release];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerselectionVC *objPlayerselectionVC;
    
    if (indexPath.section==2 && indexPath.row==1) 
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC_iPad" bundle:nil];
        }
        else
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC" bundle:nil];
        }
        
        NSInteger playercount=strSpeed.integerValue;
        objPlayerselectionVC.player=playercount;
        objPlayerselectionVC.strselection=@"speed";
        [self.navigationController pushViewController:objPlayerselectionVC animated:YES];
        [objPlayerselectionVC release];
        flgSpeed = YES;
    }
    else if(indexPath.section==2 && indexPath.row==2)
    {
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC_iPad" bundle:nil];
        }
        else
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC" bundle:nil];
        }
        
        NSInteger playercount=strAutoTruth.integerValue;
        objPlayerselectionVC.player=playercount;
        objPlayerselectionVC.strselection=@"auto truth";
        [self.navigationController pushViewController:objPlayerselectionVC animated:YES];
        [objPlayerselectionVC release]; 
        flgAutoTruth = YES;
    }
    else if(indexPath.section==3 && indexPath.row==0)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC_iPad" bundle:nil];
        }
        else
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC" bundle:nil];
        }
        
        objPlayerselectionVC.language=strLanguage;
        objPlayerselectionVC.strselection=@"language";
        [self.navigationController pushViewController:objPlayerselectionVC animated:YES];
        [objPlayerselectionVC release]; 
        flagLang=YES;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        return 55;
    }
    else{
        return 25;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[[UIView alloc] init] autorelease];
    UIImageView *img1;
    UILabel *lbl = [[UILabel alloc] init];
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        headerView.frame = CGRectMake(0, 0, 768, 80);
        img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titlebar_iPad.png"]];
        lbl.frame = CGRectMake(10, 3, 380, 45);
        [lbl setFont:[UIFont fontWithName:@"Segoe Print" size:30.0]];
    }
    else
    {
        headerView.frame = CGRectMake(0, 0, 320, 40);
        img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settingstripe.png"]];
        lbl.frame = CGRectMake(10, 3, 190, 20);
        [lbl setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
	}
    [headerView addSubview:img1];
    [img1 release];
	
	lbl.backgroundColor = [UIColor clearColor];
	if(section == 0)
        lbl.text = NSLocalizedString(@"General label", @"");
    else if(section == 1)
        lbl.text = NSLocalizedString(@"Dirty play", @"");
    else if(section == 2)
        lbl.text = NSLocalizedString(@"Shake it up", @"");
    else if(section ==3)
        lbl.text = NSLocalizedString(@"Language Support", @""); 
    lbl.textColor=[UIColor whiteColor];
	[headerView addSubview:lbl];
    [lbl release];
	return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if (indexPath.section==2 && indexPath.row==1) 
        {
            CGSize size = [NSLocalizedString(@"Increase dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:23.0]];
            int lblHeight = (int)(size.width/700);
            if ([CurrentLang isEqualToString:@"es"])
            {
                return 150.0; 
            }
            else
            {
                if (size.width > 700)
                    return size.height*lblHeight+110;
                else
                    return 150.0;   
            }
        }
        else if(indexPath.section==2 && indexPath.row==2)
        {
            CGSize size = [NSLocalizedString(@"Auto Challenge message", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:23.0]];
            int lblHeight = (int)(size.width/700);
            if ([CurrentLang isEqualToString:@"es"])
            {
                return 150.0; 
            }
            else
            {
                if (size.width > 700)
                    return size.height*lblHeight+110;
                else
                    return 150.0;   
            }
        }
        else if(indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                CGSize size = [NSLocalizedString(@"Sound", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]]; 
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
            else if(indexPath.row == 1)
            {
                CGSize size = [NSLocalizedString(@"Take turns in order", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
            else if(indexPath.row == 2)
            {
                CGSize size = [NSLocalizedString(@"My Dares Only", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
            else if(indexPath.row == 3)
            {
                CGSize size = [NSLocalizedString(@"Allow Changing Dares", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
        }
        else if(indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                CGSize size = [NSLocalizedString(@"Clean", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
            else if(indexPath.row == 1)
            {
                CGSize size = [NSLocalizedString(@"Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
    
            }
            else if(indexPath.row == 2)
            {
                CGSize size = [NSLocalizedString(@"Super Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"] || [CurrentLang isEqualToString:@"fr"] || [CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/180));
                    if (size.width > 180)
                        return size.height*lblHeight+95;
                }
            }
        }
        return 95.0; 
    }
    else
    {
        if (indexPath.section==2 && indexPath.row==1) 
        {
            CGSize size = [NSLocalizedString(@"Increase dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:12.0]];
            int lblHeight = (int)(size.width/290);
            if ([CurrentLang isEqualToString:@"es"])
            {
                return 80.0;
            }
            else
            {
                if (size.width > 290)
                    return size.height*lblHeight+60;
                else
                    return 80.0;  
            }
            
        }
        else if(indexPath.section==2 && indexPath.row==2)
        {
            CGSize size = [NSLocalizedString(@"Auto Challenge message", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:12.0]];
            int lblHeight = (int)(size.width/290);
            if ([CurrentLang isEqualToString:@"es"])
            {
                return 80.0;
            }
            else
            {
                if (size.width > 290)
                    return size.height*lblHeight+60;
                else
                    return 80.0;  
            }
        }
        else if (indexPath.section == 0)
        {
            if(indexPath.row == 0)
            {
                CGSize size = [NSLocalizedString(@"Sound", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]]; 
                
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
            else if(indexPath.row == 1)
            {
                CGSize size = [NSLocalizedString(@"Take turns in order", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
            else if(indexPath.row == 2)
            {
                CGSize size = [NSLocalizedString(@"My Dares Only", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
            else if(indexPath.row == 3)
            {
                CGSize size = [NSLocalizedString(@"Allow Changing Dares", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
        }
        else if(indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                CGSize size = [NSLocalizedString(@"Clean", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
            else if(indexPath.row == 1)
            {
                CGSize size = [NSLocalizedString(@"Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
            else if(indexPath.row == 2)
            {
                CGSize size = [NSLocalizedString(@"Super Dirty", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
                if([CurrentLang isEqualToString:@"es"])
                {
                    int lblHeight = (int)((size.width/160));
                    if (size.width > 160)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 165)
                        return size.height*lblHeight+35;
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    int lblHeight = (int)((size.width/165));
                    if (size.width > 195)
                        return size.height*lblHeight+35;
                }
            }
        }
        return 44.0;
    }
}
//All Truth,All Dare,Off segment changes Method
-(void)segmentAction:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    
    if (thisDevice.userInterfaceIdiom==UIUserInterfaceIdiomPhone)
    {
        for (id segment in [seg subviews]) 
        {
            for (id label in [segment subviews]) 
            {
                if ([label isKindOfClass:[UILabel class]])
                {
                    UILabel *lbel = (UILabel *)label;
                    lbel.adjustsFontSizeToFitWidth = YES;
                    [label setTextAlignment:UITextAlignmentCenter];
                    [label setFont:[UIFont boldSystemFontOfSize:12.0f]];
                }
            }           
        }
    }
    
    switch (seg.tag) 
	{
        case 7:switch(seg.selectedSegmentIndex)
        {
            case 0:strTruthMode = @"Off";
                flagAutoTruth = YES;
                break;
            case 1:strTruthMode = @"All Truth";
                flagAutoTruth = NO;
                break;
            case 2:strTruthMode = @"All Dare";
                flagAutoTruth = NO;
                break;
            default:break;
        }
            break;  
            
		default:break;
	}
}

#pragma SettingCustom Cell Delegate
//All segment changes Method
-(void)settingsTag:(SettingsSegmentCustomCell*)cell
{
    if (cell.segmentedControl.tag == 0) 
    {
        cell.segmentedControl.tag = 999;
    }
    
    UISegmentedControl *seg = (UISegmentedControl *)cell.segmentedControl;
    NSString *string  = cell.lbl.text;
       
    if ([string isEqualToString:NSLocalizedString(@"Sound", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:strSound1 = @"ON";
                break;
            case 1:strSound1 = @"OFF";
                break;
            default:break;
        }
    }
    
    else if ([string isEqualToString:NSLocalizedString(@"Take turns in order", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strTakesTrueInOrder = @"ON";
                break;
            case 1:self.strTakesTrueInOrder = @"OFF";
                break;
            default:break;
        }
    }
    else if ([string isEqualToString:NSLocalizedString(@"My Dares Only", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strMyDaresOnly = @"ON";
                break;
            case 1:self.strMyDaresOnly = @"OFF";
                break;
            default:break;
        }
    }
    else if ([string isEqualToString:NSLocalizedString(@"Allow Changing Dares", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strAllowChangingDares = @"ON";
                break;
            case 1:self.strAllowChangingDares = @"OFF";
                break;
            default:break;
        }
        
    }
    else if ([string isEqualToString:NSLocalizedString(@"Dirty", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strDirty = @"ON";
                break;
            case 1:self.strDirty = @"OFF";
                break;
            default:break;
        }
    }
    else if ([string isEqualToString:NSLocalizedString(@"Clean", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strClean = @"ON";
                break;
            case 1:self.strClean = @"OFF";
                break;
            default:break;
        }
    }
    else if ([string isEqualToString:NSLocalizedString(@"Super Dirty", @"")])
    {
        switch(seg.selectedSegmentIndex)
        {
            case 0:self.strSuperDirty = @"ON";
                break;
            case 1:self.strSuperDirty = @"OFF";
                break;
            default:break;
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end
