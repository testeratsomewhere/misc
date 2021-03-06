

#import "EditTruthOrDareViewController.h"
#import "Popup.h"
#import "TruthOrDareDisplayView.h"
#import "PlayerselectionVC.h"
#import "Popup.h"
#import "UserDefaultSettings.h"
#import "SHK.h"
#import "SHKSharer.h"
#import "SHKCustomShareMenu.h"
#import <Foundation/NSObjCRuntime.h>

static sqlite3_stmt *updateStmt = nil;
static sqlite3_stmt *addStmt = nil;

@implementation EditTruthOrDareViewController
@synthesize strTitle;
@synthesize strValue;
@synthesize strPrimaryKey, strGender, strDirtiness, strPlayers;
@synthesize strOrigin;
@synthesize strActive;
@synthesize strLastId;

@synthesize btnBack;
@synthesize btnSave;
@synthesize lblTitle;
@synthesize txtEdit;
@synthesize tblEdit;
@synthesize pktruthordare;
@synthesize  custom;

@synthesize  imgText, imgView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    thisDevice = [UIDevice currentDevice];
    txtEdit.backgroundColor = [UIColor clearColor];
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
    {
        txtEdit.font = [UIFont fontWithName:@"Segoe Print" size:35.0];
    }
    else
    {
        txtEdit.font = [UIFont fontWithName:@"Segoe Print" size:15.0];
    }
    txtEdit.textColor = [UIColor whiteColor];
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication]delegate];
    flgPersonCode = NO;
     flagplayer=NO;
     if([self.strOrigin isEqualToString:@"Add"])
     {
         self.strDirtiness = @"3";
         self.strGender = @"0";
         self.strPlayers = @"2";
         self.strActive = @"1";
     }
    
    if(thisDevice.userInterfaceIdiom== UIUserInterfaceIdiomPad)
    {
        imgText = [[UIImage imageNamed:@"textbox-b_iPad.png"]stretchableImageWithLeftCapWidth:0 topCapHeight:78];
        [imgView setImage:imgText];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self update_UI];
    [lblTitle setText:strTitle];
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
    {
            [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:42.0]];
    }   
    else
    {
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];        
    }

    [lblTitle setTextColor:[UIColor whiteColor]];
   
    [tblEdit setBackgroundColor:[UIColor clearColor]];
    if([self.strOrigin isEqualToString:@"Edit"])
    {
        if(!flgPersonCode)
        {
            [txtEdit setText:self.strValue]; 
            
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                [btnSave setImage:[UIImage imageNamed:@"savebtn_iPad.png"] forState:UIControlStateNormal];
            }   
            else
            {
                [btnSave setImage:[UIImage imageNamed:@"savebtn.png"] forState:UIControlStateNormal]; 
            }
        }
        else
            flgPersonCode = NO;
    }
    else
    {
        if(!flgPersonCode)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                [btnSave setImage:[UIImage imageNamed:@"plusbtn_iPad.png"] forState:UIControlStateNormal];
            }   
            else
            {
                [btnSave setImage:[UIImage imageNamed:@"addbtn.png"] forState:UIControlStateNormal];
            }
        }
        else
            flgPersonCode = NO;
        
    }
    [tblEdit reloadData];
}

#pragma mark textview methods
// textView Delegate methods
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    textEditRange = range;
    if ([text isEqualToString:@"\n"])
    {
        [txtEdit resignFirstResponder];
    }
    return YES;
}

#pragma mark custom methods

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnYes = nil;
    UIImage *imgBtnNo = nil;
    
    NSString *strNo = nil;
    NSString *strYes = nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        strNo = [NSString stringWithFormat:@"btn_no_iPad_%@",CurrentLang];
        imgBtnNo = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strNo ofType:@"png"]];
        [btnDeleteNo setImage:imgBtnNo forState:UIControlStateNormal];
        
        strYes = [NSString stringWithFormat:@"btn_yes_iPad_%@",CurrentLang];
        imgBtnYes = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strYes ofType:@"png"]];
        [btnDeleteYes setImage:imgBtnYes forState:UIControlStateNormal];
    }
    else
    {
        strNo = [NSString stringWithFormat:@"btn_no_%@",CurrentLang];
        imgBtnNo = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strNo ofType:@"png"]];
        [btnDeleteNo setImage:imgBtnNo forState:UIControlStateNormal];
        
        strYes = [NSString stringWithFormat:@"btn_yes_%@",CurrentLang];
        imgBtnYes = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strYes ofType:@"png"]];
        [btnDeleteYes setImage:imgBtnYes forState:UIControlStateNormal];
    }
}

//Go to Truth and dare List screen

-(IBAction)back
{
    flagplayer=NO;
    NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
    self.strPlayers = @"2";
    [prefs1 setObject:self.strPlayers forKey:@"No player"];
    [self.navigationController popViewControllerAnimated:YES];
}
//Save changes Method
-(IBAction)save:(id)sender
{
    [txtEdit resignFirstResponder];
    self.strValue = txtEdit.text;
    
    if([self.strValue isEqualToString:@""])
    {
        strLocal = [[NSString alloc]initWithString:NSLocalizedString(@"Enter", @"")];
        strAlertMessage = [NSString stringWithFormat:@"%@ %@", strLocal, self.strTitle];//[NSString stringWithFormat:@"Enter %@", self.strTitle];
        flgpreview=YES;
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        self.strPlayers= [prefs1 stringForKey:@"No player"];
        if (self.strPlayers==0) 
        {
            self.strPlayers=@"2";
        }
        [self updateDatabase];
    }
}
#pragma mark popup delegate method
- (void)popupViewControllerDidClose:(NSString*)actionType withResponse:(BOOL)response
{
    if (!flgpreview)
    {
        flagplayer=NO;
        [self.navigationController popViewControllerAnimated:YES];
        flgpreview=NO;
    }
    else
    {
        flgpreview=NO;
    }
}
//update and Add Data  to Database Method

-(void)getDatabasePathForAddingAndUpdating
{
	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [path objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
	
    if (sqlite3_open([writableDBPath UTF8String], &database) == SQLITE_OK)
    {
        NSLog(@"Database Opened Successfully..");
        appDelegate.database = database;
    } 
    else 
    {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(database);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(database));
    }
}
-(void)updateDatabase
{
    [self getDatabasePathForAddingAndUpdating];
   // database = appDelegate.database;
    
    if([strOrigin isEqualToString:@"Edit"])
    {
        [FlurryAnalytics logEvent:@"ChallengeUpdated"];
        if(updateStmt == nil) 
        {
            if([self.strTitle isEqualToString: NSLocalizedString(@"Truth", @"")]) //@"Truth"])
            {
                const char *sqlTruth=nil;
                if ([CurrentLang isEqualToString:@"en"])
                {
                    sqlTruth = "update tblTruth Set ln_EN = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkTruthChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"es"])
                {
                    sqlTruth = "update tblTruth Set ln_ES = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkTruthChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    sqlTruth = "update tblTruth Set ln_DE = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkTruthChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    sqlTruth = "update tblTruth Set ln_FR = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkTruthChallengeID = ?";
                }
                
                if(sqlite3_prepare_v2(database, sqlTruth, -1, &updateStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
            }
            else
            {
                const char *sqlDare=nil;
                if ([CurrentLang isEqualToString:@"en"])
                {
                    sqlDare = "update tblDare Set ln_EN = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkDaresChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"es"])
                {
                    sqlDare = "update tblDare Set ln_ES = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkDaresChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    sqlDare = "update tblDare Set ln_FR = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkDaresChallengeID = ?";
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    sqlDare = "update tblDare Set ln_DE = ?, dirty = ?, minplayers = ?, gender = ?,active = ?,add_person_code = ? Where pkDaresChallengeID = ?";
                }
                
                if(sqlite3_prepare_v2(database, sqlDare, -1, &updateStmt, NULL) != SQLITE_OK)
                    NSAssert1(0, @"Error while creating update statement. '%s'", sqlite3_errmsg(database));
            }
        }
        NSInteger Numberofplayers=self.strPlayers.integerValue;
        sqlite3_bind_text(updateStmt, 1, [self.strValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 2, [self.strDirtiness UTF8String], -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_int(updateStmt, 3, Numberofplayers);
        sqlite3_bind_text(updateStmt, 4, [self.strGender UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 5, [self.strActive UTF8String], -1, SQLITE_TRANSIENT);
        NSString *strAddpers=@"0";
        sqlite3_bind_text(updateStmt, 6, [strAddpers UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(updateStmt, 7, [self.strPrimaryKey UTF8String], -1, SQLITE_TRANSIENT);
        
        if(SQLITE_DONE != sqlite3_step(updateStmt))
            NSAssert1(0, @"Error while updating. '%s'", sqlite3_errmsg(database));
        else
        {
            appDelegate.flgUpdate = TRUE;
            strLocal =[[NSString alloc]initWithString:NSLocalizedString(@"Updated", @"")];
            if ([CurrentLang isEqualToString:@"en"]) {
                strAlertMessage = [NSString stringWithFormat:@"%@ %@", strLocal, self.strTitle];
            }
            else
            {
                strAlertMessage = [NSString stringWithFormat:@"%@ %@", self.strTitle, strLocal];
            }
            
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];
        }
        sqlite3_reset(updateStmt);
        updateStmt = nil;    
    }
    else 
    {
        [FlurryAnalytics logEvent:@"ChallengeAdded"];
        NSString *strQuery=[NSString stringWithFormat:@"Select * from tblDare where source='1'"];
        NSMutableArray *dataArray=[self executeQuery:strQuery];
        NSString *strNumCustomDares=[NSString stringWithFormat:@"NumCustomDares-%d",[dataArray count]];
        [FlurryAnalytics logEvent:strNumCustomDares];
        NSString *strQuery1=[NSString stringWithFormat:@"Select * from tblTruth where source='1'"];
        NSMutableArray *dataArray1=[self executeQuery:strQuery1];
        NSString *strNumCustomTruths=[NSString stringWithFormat:@"NumCustomTruths-%d",[dataArray1 count]];
        [FlurryAnalytics logEvent:strNumCustomTruths];

        if(addStmt == nil) 
        {
            if([self.strTitle isEqualToString:NSLocalizedString(@"Truth", @"")])
            {
                const char *sqlTruth=nil;
            
                if ([CurrentLang isEqualToString:@"en"])
                {
                    sqlTruth = "insert into tblTruth (ln_EN, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"es"])
                {
                    sqlTruth = "insert into tblTruth (ln_ES, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    sqlTruth = "insert into tblTruth (ln_FR, dirty, minplayers, gender, source, active, add_person_code) Values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    sqlTruth = "insert into tblTruth (ln_DE, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
                }

                if(sqlite3_prepare_v2(database, sqlTruth, -1, &addStmt, NULL) != SQLITE_OK) 
                {
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
                }
            }
            else
            {
                const char *sqlDare=nil;
        
                if ([CurrentLang isEqualToString:@"en"])
                {
                    sqlDare = "insert into tblDare (ln_EN, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"es"])
                {
                    sqlDare = "insert into tblDare (ln_ES, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"fr"])
                {
                    sqlDare = "insert into tblDare (ln_FR, dirty, minplayers, gender,source,active,add_person_code) values(?,?,?,?,?,?,?)";
                }
                else if([CurrentLang isEqualToString:@"de"])
                {
                    sqlDare = "insert into tblDare (ln_DE, dirty, minplayers, gender,source,active,add_person_code) values(?,?,?,?,?,?,?)";
                }

                if(sqlite3_prepare_v2(database, sqlDare, -1, &addStmt, NULL) != SQLITE_OK) 
                {
                    NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
                }
            }
        }
        
        sqlite3_bind_text(addStmt, 1, [self.strValue UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 2, [self.strDirtiness UTF8String], -1, SQLITE_TRANSIENT);
        NSInteger Numberofplayers=self.strPlayers.integerValue;
        sqlite3_bind_int(addStmt, 3, Numberofplayers);
        sqlite3_bind_text(addStmt, 4, [self.strGender UTF8String], -1, SQLITE_TRANSIENT);
        NSString *strsource=@"1";
        sqlite3_bind_text(addStmt, 5, [strsource UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(addStmt, 6, [self.strActive UTF8String], -1, SQLITE_TRANSIENT);      
        NSString *strAddpers=@"0";
        sqlite3_bind_text(addStmt, 7, [strAddpers UTF8String], -1, SQLITE_TRANSIENT);
        if(SQLITE_DONE != sqlite3_step(addStmt)) 
        {
            NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
        }
        else 
        {
            appDelegate.flgUpdate = TRUE;
            strLocal=NSLocalizedString(@"Added", @"");
            strAlertMessage = [NSString stringWithFormat:@"%@ %@",self.strTitle, strLocal]; //[NSString stringWithFormat:@"%@ Added", self.strTitle];
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];
        }
        sqlite3_reset(addStmt);
        sqlite3_finalize(addStmt);
        addStmt = nil;
    }
}
#pragma mark table delegate methods
//update and tableView  delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if (indexPath.row == 0)
        {
            CGSize size = [NSLocalizedString(@"Preview", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"en"])
            {
                int lblHeight = (int)(size.width/700);
                if (size.width > 700)
                    return size.height*lblHeight+3;
            }
        }
        else if (indexPath.row == 1)
        {
            CGSize size = [NSLocalizedString(@"Add Person Code", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"en"])
            {
                int lblHeight = (int)(size.width/700);
                if (size.width > 700)
                    return size.height*lblHeight+3;
            }
        }
        else if (indexPath.row == 2)
        {
            CGSize size = [NSLocalizedString(@"Active label", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"en"])
            {
                int lblHeight = (int)(size.width/400);
                if (size.width > 400)
                    return size.height*lblHeight;
            }
        }
        else if(indexPath.row == 3)
        {
            CGSize size = [NSLocalizedString(@"This is for", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"en"])
            {
                int lblHeight = (int)(size.width/240);
                if (size.width > 240)
                    return size.height*lblHeight;
            }
        }
        else if(indexPath.row == 4)
        {
            CGSize size = [NSLocalizedString(@"Players Needed", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"es"])
            {
                int lblHeight = (int)(size.width/467);
                if (size.width > 467)
                    return size.height*lblHeight+62;
            }
            else if([CurrentLang isEqualToString:@"fr"])
            {
                int lblHeight = (int)(size.width/467);
                return size.height*lblHeight+60;
            }
        }
        else if(indexPath.row == 5)
        {
            CGSize size = [NSLocalizedString(@"Dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if ([CurrentLang isEqualToString:@"es"])
            {
                int lblHeight = (int)(size.width/400);
                if (size.width > 400)
                    return size.height*lblHeight+50;
            }
        }
        return 77.0;
    }
    else
    {
        if (indexPath.row==4) 
        {
            return 70.0;
        }
        else
            return 50.0;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        if(custom==1)
        {
            return 7;
        }
        else
        {
            return 6;   
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UILabel *cellLbl= [[[UILabel alloc]initWithFrame:CGRectZero]autorelease];
    NSString *strLbl=nil;
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
       
    UITableViewCell *cell;
    cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    
    if(indexPath.row == 0)
    {
       
        UIImageView *seprator=nil;
        strLbl =NSLocalizedString(@"Preview", @"");
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 768, 6)];
            cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]]autorelease];
            CGSize size =[NSLocalizedString(@"Preview", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7,700, size.height)]autorelease];
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text=strLbl;
    
            if (size.width > 700) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/700);
                cellLbl.frame = CGRectMake(10,7, 700, size.height*lblHeight);
            }
            [cell addSubview:cellLbl];
        }
        else
        {
            seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,0 , 320, 3)];
            cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]]autorelease];
            cell.textLabel.text=strLbl;
        }
        [seprator setImage:[UIImage imageNamed:@"divider.png"]];
        [cell addSubview:seprator];
        [seprator release];

    }
    else if(indexPath.row == 1)
    {
        strLbl=NSLocalizedString(@"Add Person Code", @"");
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]] autorelease];
            CGSize size =[NSLocalizedString(@"Add Person Code", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 700, size.height)]autorelease];
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text=strLbl;
            
            if (size.width > 700) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/700);
                cellLbl.frame = CGRectMake(10,7, 700, size.height*lblHeight);
            }
            [cell addSubview:cellLbl];
        }
        else
        {
            cell.accessoryView = [[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]] autorelease];
            cell.textLabel.text=strLbl;
        }
    }
    else if(indexPath.row == 2)
    {
        UISegmentedControl *segmentedControlActive = [[UISegmentedControl alloc] initWithItems:
                                                      [NSArray arrayWithObjects:NSLocalizedString(@"Yes", @""),NSLocalizedString(@"No", @""),nil ] ];

        [segmentedControlActive addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        strLbl=NSLocalizedString(@"Active label", @"");
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            CGSize size =[NSLocalizedString(@"Active label", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7,400, size.height)]autorelease];
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text= strLbl;
            if (size.width > 400) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/400);
                cellLbl.frame = CGRectMake(10, 7, 400, size.height*lblHeight);
            }
            [cell addSubview:cellLbl];

            segmentedControlActive.frame = CGRectMake(465, 13, 280, 50);
        }
        else
        {
            segmentedControlActive.frame = CGRectMake(155, 8, 153, 30);
            cell.textLabel.text=strLbl;
        }
        segmentedControlActive.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControlActive.tag = indexPath.row;
        NSString *str = [[UIDevice currentDevice] systemVersion];
        
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if ([self.strActive isEqualToString:@"1"]) 
            {
                segmentedControlActive.selectedSegmentIndex = 0;
            }
            else
            {
                segmentedControlActive.selectedSegmentIndex = 1;
            }
        }
        else
        {
            if ([self.strActive isEqualToString:@"1"])
            {
                segmentedControlActive.selectedSegmentIndex = 0;
            }
            else
            {
                segmentedControlActive.selectedSegmentIndex = 1;
            }
        }
       
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
                font = [UIFont boldSystemFontOfSize:11.5f];
            }
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
            [segmentedControlActive setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        else
        {
          //  UIFont *font;
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
               // font = [UIFont boldSystemFontOfSize:24.0f];
            }
            else
            {
                for (id segment in [segmentedControlActive subviews]) 
                {
                    for (id label in [segment subviews]) 
                    {
                        if ([label isKindOfClass:[UILabel class]])
                        {
                            UILabel *lbel = (UILabel *)label;
                            lbel.adjustsFontSizeToFitWidth = YES;
                            [label setTextAlignment:UITextAlignmentCenter];
                            [label setFont:[UIFont boldSystemFontOfSize:11.5f]];
                        }
                    }           
                }
            }
        }

        [cell addSubview:segmentedControlActive];
        [segmentedControlActive release];    
        
    }
    else if(indexPath.row == 3)
    {
        strLbl=NSLocalizedString(@"This is for", @"");
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            CGSize size =[NSLocalizedString(@"This is for", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
           
            if ([CurrentLang isEqualToString:@"es"]) 
            {
                 cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 215, size.height)]autorelease];
            }
            else if([CurrentLang isEqualToString:@"fr"])
            {
                cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 200, size.height)]autorelease];
            }
            else
                 cellLbl =[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 250, size.height)]autorelease];
            
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text=strLbl;
            
            if (size.width > 230) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/230);
                cellLbl.frame = CGRectMake(10, 7, 230, size.height*lblHeight);
            }
            [cell addSubview:cellLbl];

        }
        else
        {
            cell.textLabel.text = NSLocalizedString(@"For", @"");
        }

        UISegmentedControl *segmentedControlGender = [[UISegmentedControl alloc] initWithItems:
                                                      [NSArray arrayWithObjects:NSLocalizedString(@"Males", @""),NSLocalizedString(@"Females", @""),NSLocalizedString(@"Both", @""),nil]];

        [segmentedControlGender addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            segmentedControlGender.frame = CGRectMake(250, 13, 500, 50);
            if ([CurrentLang isEqualToString:@"en"])
            {
                segmentedControlGender.frame = CGRectMake(250, 13, 500, 50); //300 at 270
                [segmentedControlGender setWidth:150 forSegmentAtIndex:0];
                [segmentedControlGender setWidth:180 forSegmentAtIndex:1];
            }
            else if([CurrentLang isEqualToString:@"fr"])
            {
                segmentedControlGender.frame = CGRectMake(225, 13, 520, 50);//300 at 270
                [segmentedControlGender setWidth:100 forSegmentAtIndex:0];
            }
            else if([CurrentLang isEqualToString:@"es"])
            {
                segmentedControlGender.frame = CGRectMake(225, 13, 520, 50);//300 at 270
                [segmentedControlGender setWidth:130 forSegmentAtIndex:0];
                [segmentedControlGender setWidth:120 forSegmentAtIndex:1];
            }
        }
        else
        {
            segmentedControlGender.frame = CGRectMake(55, 8, 260, 30);
            if ([CurrentLang isEqualToString:@"en"]) 
            {
                [segmentedControlGender setWidth:80 forSegmentAtIndex:0];
                [segmentedControlGender setWidth:100 forSegmentAtIndex:1];
            }
            else if ([CurrentLang isEqualToString:@"es"]) 
            {
                segmentedControlGender.frame = CGRectMake(50, 8, 265, 30);
                [segmentedControlGender setWidth:90 forSegmentAtIndex:0];
                [segmentedControlGender setWidth:85 forSegmentAtIndex:1];
            }
            else if ([CurrentLang isEqualToString:@"fr"]) 
            {
                [segmentedControlGender setWidth:80 forSegmentAtIndex:0];
                [segmentedControlGender setWidth:80 forSegmentAtIndex:1];
            }

        }
        
        segmentedControlGender.segmentedControlStyle = UISegmentedControlStylePlain;
        segmentedControlGender.tag = indexPath.row;
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if([self.strGender isEqualToString:@"1"])
                segmentedControlGender.selectedSegmentIndex = 0;
            else if([self.strGender isEqualToString:@"2"])
                segmentedControlGender.selectedSegmentIndex = 1;
            else
                segmentedControlGender.selectedSegmentIndex = 2;
        }
        else
        {
            if([self.strGender isEqualToString:@"1"])
                segmentedControlGender.selectedSegmentIndex = 0;
            else if([self.strGender isEqualToString:@"2"])
                segmentedControlGender.selectedSegmentIndex = 1;
            else
                segmentedControlGender.selectedSegmentIndex = 2;
        }
        
        NSString *str = [[UIDevice currentDevice] systemVersion];
        float version = str.floatValue;
         UIFont *font;
        if(version == 5.0)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                if ([CurrentLang isEqualToString:@"es"])
                {
                    font = [UIFont boldSystemFontOfSize:22.5f];
                }
                else
                    font = [UIFont boldSystemFontOfSize:24.0f];
            }
            else
            {
                font = [UIFont boldSystemFontOfSize:11.5f];
            }     
            NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
            [segmentedControlGender setTitleTextAttributes:attributes forState:UIControlStateNormal];
        }
        else
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                font = [UIFont boldSystemFontOfSize:24.0f];
            }
            else
            {
                for (id segment in [segmentedControlGender subviews]) 
                {
                    for (id label in [segment subviews]) 
                    {
                        if ([label isKindOfClass:[UILabel class]])
                        {
                            UILabel *lbel = (UILabel *)label;
                            lbel.adjustsFontSizeToFitWidth = YES;
                            [label setTextAlignment:UITextAlignmentCenter];
                            [label setFont:[UIFont boldSystemFontOfSize:11.5f]];
                        }
                    }           
                }
            }
        }
        [cell addSubview:segmentedControlGender];
        [segmentedControlGender release];  
    }
    else if(indexPath.row == 4)
    {
        strLbl = NSLocalizedString(@"Players Needed", @"");
        UIImageView *imageview;
    
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            imageview =[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow_iPad.png"]];
            
            CGSize size = [NSLocalizedString(@"Players Needed", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
           // UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(10,7, 467, size.height)];
            cellLbl = [[[UILabel alloc]initWithFrame:CGRectMake(10,7, 467, size.height)]autorelease];
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text=strLbl;
            if ( size.width > 467) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/467);
                cellLbl.frame = CGRectMake(10, 7, 467, size.height*lblHeight+50);
            }
            [cell addSubview:cellLbl];
            //[lbl1 release];
        }
        else
        {
            imageview=[[UIImageView alloc ] initWithImage:[UIImage imageNamed:@"arrow.png"]];
            CGSize size =[strLbl sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]];
            size.height += 20;
            [cellLbl setFrame:CGRectMake(0, 0, 180, size.height)];
            cellLbl.numberOfLines = 3;
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:16.0];
            if (size.width>180) {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                //cellLbl.numberOfLines = 3;
                int labHeight= (int)(size.width/180);
                cellLbl.frame = CGRectMake(10, 0, 180, size.height*labHeight+20);
            }
            cellLbl.text=strLbl;
        }
        cellLbl.backgroundColor=[UIColor clearColor];
        cellLbl.textColor=[UIColor whiteColor];
        [cell addSubview:cellLbl];
        cell.accessoryView = imageview;
        [imageview release];
        NSString *playercount;
        if (flagplayer==NO) 
        {
            if([self.strTitle isEqualToString:NSLocalizedString(@"Truth", @"")])//@"Truth"])
            {
                NSString *strQuery=[NSString stringWithFormat:@"select * from tblTruth where pkTruthChallengeID='%@'",self.strPrimaryKey];
                NSMutableArray *dataArray=[self executeQuery:strQuery];
                if (![dataArray count]==0) {
                    NSDictionary *dict=[dataArray objectAtIndex:0];
                    NSInteger Player;
                    Player=[[dict objectForKey:@"minplayers"] integerValue];
                    playercount=[NSString stringWithFormat:@"%d",Player];
                }
                else
                {
                    playercount=@"2";
                }
            }
            else
            {
                NSString *strQuery=[NSString stringWithFormat:@"select * from tblDare where pkDaresChallengeID='%@'",self.strPrimaryKey];
                NSMutableArray *dataArray=[self executeQuery:strQuery];
                if (![dataArray count]==0) {
                    NSDictionary *dict=[dataArray objectAtIndex:0];
                    NSInteger Player;
                    Player=[[dict objectForKey:@"minplayers"] integerValue];
                    playercount=[NSString stringWithFormat:@"%d",Player];
                }
                else
                {  
                    playercount=@"2";
                }
            }
        }
        else
        {
            NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
            playercount= [prefs1 stringForKey:@"No player"];
            NSInteger Player=playercount.intValue;
            playercount=[NSString stringWithFormat:@"%d",Player];
        }
        UILabel *lbl;
        lbl = [[[UILabel alloc]init]autorelease];
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            
            CGSize size = [NSLocalizedString(@"players", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]]; 
            int lblHeight = (int)(size.width/285);
            if (size.width > 285)
            {
                lbl.lineBreakMode = UILineBreakModeWordWrap;
                lbl.numberOfLines = 0;
                lbl.frame = CGRectMake(450,0, 285, size.height*lblHeight+50);
            }
            else
            {
                lbl=[[[UILabel alloc]initWithFrame:CGRectMake(450,(cellLbl.frame.size.height-50)/2,285, size.height)]autorelease];
            }
            lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:30.0];
            [lbl setTextAlignment:UITextAlignmentRight];
        }
        else
        {
            CGSize size = [NSLocalizedString(@"players", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:16.0]]; 
            int lblHeight = (int)(size.width/110);
            lbl.numberOfLines = 3;
            if (size.width > 120)
            {
                lbl.lineBreakMode = UILineBreakModeWordWrap;
                lbl.frame = CGRectMake(195,7, 100, size.height*lblHeight+25);
            }
            else
            {
                lbl.Frame=CGRectMake(180,lbl.frame.origin.y+7,120, size.height+20);
            }
            lbl.font=[UIFont fontWithName:@"SegoePrint" size:16.0];
            [lbl setTextAlignment:UITextAlignmentCenter];
        }
        lbl.backgroundColor=[UIColor clearColor];
        lbl.textColor =[UIColor whiteColor];
        
        strLocal=[[NSString alloc]initWithString:NSLocalizedString(@"players", @"")];
        NSString *strplayercount=[NSString stringWithFormat:@"%@%@ ",playercount,strLocal];
        
        lbl.text=strplayercount;
        [cell addSubview:lbl];
        //[lbl release];    
    }
    else if(indexPath.row == 5)
    {
        int value = self.strDirtiness.integerValue;
        UIButton *btnStar1 = [UIButton buttonWithType:UIButtonTypeCustom];
        strLbl =NSLocalizedString(@"Dirtiness", @"");
        
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                CGSize size = [NSLocalizedString(@"Dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
                cellLbl=[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 400, size.height)]autorelease];
                cellLbl.backgroundColor=[UIColor clearColor];
                cellLbl.textColor=[UIColor whiteColor];
                cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
                cellLbl.text=strLbl;
            
                if ( size.width > 400) 
                {
                    cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                    cellLbl.numberOfLines = 0;
                    int lblHeight = (int)(size.width/400);
                    cellLbl.frame = CGRectMake(10,15, 400, size.height*lblHeight+50);
                }
                else
                {
                        cellLbl.frame = CGRectMake(10,7, 400,cellLbl.frame.size.height);
                }
                [cell addSubview:cellLbl];
                btnStar1.frame = CGRectMake(450, 7, 45, cellLbl.frame.size.height);
                
                if(value >= 1)
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            { 
                cell.textLabel.text=strLbl;
                btnStar1.frame = CGRectMake(125, 12, 25, 25);
                if(value >= 1)
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                CGSize size = [NSLocalizedString(@"Dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
                cellLbl=[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 400, size.height)]autorelease];
                cellLbl.backgroundColor=[UIColor clearColor];
                cellLbl.textColor=[UIColor whiteColor];
                cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
                cellLbl.text=strLbl;
                
                if ( size.width > 400) 
                {
                    cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                    cellLbl.numberOfLines = 0;
                    int lblHeight = (int)(size.width/400);
                    cellLbl.frame = CGRectMake(10,15, 400, size.height*lblHeight+50);
                }
                else
                {
                    cellLbl.frame = CGRectMake(10,7, 400,cellLbl.frame.size.height);
                }
                [cell addSubview:cellLbl];
                btnStar1.frame = CGRectMake(450, 7, 45, cellLbl.frame.size.height);

                if(value >= 1)
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                cell.textLabel.text = NSLocalizedString(@"Dirtiness", @"");
                btnStar1.frame = CGRectMake(125, 12, 25, 25);
                if(value >= 1)
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                } 
            }
        }
        btnStar1.tag = 1;
        [btnStar1 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar1 setUserInteractionEnabled:YES];
        btn1 = btnStar1;
        [cell addSubview:btnStar1];
        
        UIButton *btnStar2 = [UIButton buttonWithType:UIButtonTypeCustom];
         
        if([self.strOrigin isEqualToString:@"Edit"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                btnStar2.frame = CGRectMake(500, 7, 45, cellLbl.frame.size.height);
                if(value >= 2)
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }
                
            }
            else
            {
                btnStar2.frame = CGRectMake(155, 12, 25, 25);
                if(value >= 2)
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
                
            }
        }
        else
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                    btnStar2.frame = CGRectMake(500, 7, 45, cellLbl.frame.size.height);

                if(value >= 2)
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }

            }
            else
            {
                btnStar2.frame = CGRectMake(155, 12, 25, 25);
                if(value >= 2)
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
            }
        }
        btnStar2.tag = 2;
        [btnStar2 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar2 setUserInteractionEnabled:YES];
        btn2 = btnStar2;
        [cell addSubview:btnStar2];
        
        UIButton *btnStar3 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
                btnStar3.frame = CGRectMake(550, 7, 45, cellLbl.frame.size.height);
            
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 3)
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 3)
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            btnStar3.frame = CGRectMake(185, 12, 25, 25);
            
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 3)
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 3)
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
            }
        }
        btnStar3.tag = 3;
        [btnStar3 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnStar3 setUserInteractionEnabled:YES];
        btn3 = btnStar3;
        [cell addSubview:btnStar3];
        
        UIButton *btnheart1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            btnheart1.frame = CGRectMake(600, 10, 45, cellLbl.frame.size.height);

            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 4)
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 4)
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            btnheart1.frame = CGRectMake(215, 14, 26, 23); 

            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 4)
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 4)
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                }
            }

        }
        
        btnheart1.tag = 4;
        [btnheart1 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnheart1 setUserInteractionEnabled:YES];
        btn4 = btnheart1;
        [cell addSubview:btnheart1];
        
        UIButton *btnheart2 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            btnheart2.frame = CGRectMake(650, 10, 45, cellLbl.frame.size.height);
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 5)
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 5)
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            btnheart2.frame = CGRectMake(245, 14, 26, 23);
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value >= 5)
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value >= 5)
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnheart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                }
            }
        }
        
        btnheart2.tag = 5;
        [btnheart2 addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnheart2 setUserInteractionEnabled:YES];
        btn5 = btnheart2;
        [cell addSubview:btnheart2];
        
        UIButton *btnLips = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            btnLips.frame = CGRectMake(700, 10, 45, cellLbl.frame.size.height);
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value == 6)
                {
                    [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value == 6)
                {
                    [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                }
            }
        }
        else
        {
            btnLips.frame = CGRectMake(275, 14, 31, 22);
            if([self.strOrigin isEqualToString:@"Edit"])
            {
                if(value == 6)
                {
                    [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                }
            }
            else
            {
                if(value == 6)
                {
                    [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                }
                else
                {
                    [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                }
            }
            
        }
        
        btnLips.tag = 6;
        [btnLips addTarget:self action:@selector(dirtiness:) forControlEvents:UIControlEventTouchUpInside];
        [btnLips setUserInteractionEnabled:YES];
        btn6 = btnLips;
        [cell addSubview:btnLips];
        
    }

    else if (indexPath.row == 6)
    {
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            CGSize size = [NSLocalizedString(@"Delete", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            cellLbl=[[[UILabel alloc]initWithFrame:CGRectMake(10,7, 400, size.height)]autorelease];
            cellLbl.backgroundColor=[UIColor clearColor];
            cellLbl.textColor=[UIColor whiteColor];
            cellLbl.font=[UIFont fontWithName:@"SegoePrint" size:35.0];
            cellLbl.text=NSLocalizedString(@"Delete", @"");
            
            if ( size.width > 400) 
            {
                cellLbl.lineBreakMode = UILineBreakModeWordWrap;
                cellLbl.numberOfLines = 0;
                int lblHeight = (int)(size.width/400);
                cellLbl.frame = CGRectMake(10,15, 400, size.height*lblHeight+50);
            }
            else
            {
                cellLbl.frame = CGRectMake(10,7, 400,cellLbl.frame.size.height);
            }
            [cell addSubview:cellLbl];
        }
        else
            cell.textLabel.text = NSLocalizedString(@"Delete", @"");
    }
    
    UIImageView *seprator=nil;
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        //cell.textLabel.font=[UIFont fontWithName:@"Segoe Print" size:35.0];
        if (indexPath.row == 0)
        {
            CGSize size = [NSLocalizedString(@"Preview", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if (size.width > 700)
                seprator =[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+20, 768, 6)];
            else
                seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,75 , 768, 6)];//75
        }
        else if(indexPath.row == 1)
        {
            CGSize size = [NSLocalizedString(@"Add Person Code",@"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if (size.width > 700)
                seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+20, 768, 6)];
            else
                seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,75 , 768, 6)];//75
        }
        else if(indexPath.row == 2)
        {
            CGSize size = [NSLocalizedString(@"Active label", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if (size.width > 400) 
                seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+20, 768, 6)];
            else
                seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,75 , 768, 6)];//75
        }
        else if(indexPath.row == 3)
        {
            CGSize size =[NSLocalizedString(@"This is for", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if (size.width > 230)
                seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0, cellLbl.frame.size.height+12, 768, 6)];
            else
                seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0, 75, 768, 6)];
        }
        else if (indexPath.row == 4)
        {
            CGSize size =[NSLocalizedString(@"Players Needed", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
            if (size.width > 467)
            {
                if ([CurrentLang isEqualToString:@"es"])
                    seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+10, 768, 6)];//75
                else if([CurrentLang isEqualToString:@"fr"])
                    seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0, cellLbl.frame.size.height+7, 768, 6)];
                else
                    seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+20, 768, 6)];//75

            }
            else
            {
                if ([CurrentLang isEqualToString:@"es"]) 
                    seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+30 , 768, 6)];//75
                else
                    seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,75 , 768, 6)];//75
            }
        }
        else if(indexPath.row == 5)
        {
            CGSize size =[NSLocalizedString(@"Dirtiness", @"") sizeWithFont:[UIFont fontWithName:@"Dirtiness" size:35.0]];
            if (size.width > 400)
            {
                
                    seprator =[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height+20,768, 6)];
            }
            else
            {
               
                    if ([CurrentLang isEqualToString:@"es"]) 
                        seprator = [[UIImageView alloc]initWithFrame:CGRectMake(0, cellLbl.frame.size.height+15, 768, 6)];
                    else
                        seprator =[[UIImageView alloc]initWithFrame:CGRectMake(0,75, 768, 6)];
            }
        }
        else if(indexPath.row == 6)
        {
            seprator =[[UIImageView alloc]initWithFrame:CGRectMake(0,75, 768, 6)];
        }
    }
    else
    {
        if (indexPath.row == 4)
        {
            CGSize size =[NSLocalizedString(@"Players Needed", @"") sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
            if (size.width > 180)
                
                seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,cellLbl.frame.size.height, 320, 3)];//75
            else
                seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0,75 , 768, 6)];//75
        }
        else
        {
            cell.textLabel.font=[UIFont fontWithName:@"Segoe Print" size:15.0];
            seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 47, 320, 3)];
        }

    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0) {
        if (![txtEdit.text isEqualToString:@""]) 
        {
           NSArray *arrPlayerName = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
            
            if ([arrPlayerName count]>=2) {
                TruthOrDareDisplayView *objPlayViewController;
                
                if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                {
                    objPlayViewController = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView_iPad" bundle:nil];
                }
                else
                {
                    objPlayViewController = [[TruthOrDareDisplayView alloc] initWithNibName:@"TruthOrDareDisplayView" bundle:nil];
                }
                objPlayViewController.strstate=@"Preview";
                self.strValue=txtEdit.text;
                objPlayViewController.displaytext=txtEdit.text;
                objPlayViewController.strpreviewmode=lblTitle.text;
                objPlayViewController.genderforpreview=strGender;
                [self.navigationController pushViewController:objPlayViewController animated:YES];
                [objPlayViewController release]; 
            }
            else
            {
                flgpreview=YES;
                strAlertMessage = NSLocalizedString(@"strAlertMessage-1", @""); //[NSString stringWithFormat:@"Please enter at least 2 names on the main page to preview."];
                dictAlertMessage = [[NSMutableDictionary alloc] init];
                [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
                [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
                [dictAlertMessage release];    
            }
            
        }
        else
        {
            flgpreview=YES;
            strLocal = [[NSString alloc]initWithString:NSLocalizedString(@"Please Enter", @"")];
            strAlertMessage = [NSString stringWithFormat:@"%@ %@",strLocal, strTitle];
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            [dictAlertMessage release];  
        }
    }
    else if(indexPath.row == 1)
    {
            textEditRange=txtEdit.selectedRange;
        
            PersonCodeViewController *personCodeView;
        
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                personCodeView = [[PersonCodeViewController alloc] initWithNibName:@"PersonCodeViewController_iPad" bundle:nil];
            }
            else
            {
                personCodeView = [[PersonCodeViewController alloc] initWithNibName:@"PersonCodeViewController" bundle:nil];
            }
            personCodeView.delegate = self;
        if(![txtEdit.text isEqualToString:@""])
        {
            personCodeView.strRecievedMessage = txtEdit.text;
        }
        else
        {
            personCodeView.strRecievedMessage = @"";
        }
            [self.navigationController pushViewController:personCodeView animated:YES];
            [personCodeView release];
            flgPersonCode = YES;
        
    }
    else if(indexPath.row==4)
    {
        PlayerselectionVC *objPlayerselectionVC;
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
           objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC_iPad" bundle:nil]; 
        }
        else
        {
            objPlayerselectionVC = [[PlayerselectionVC alloc] initWithNibName:@"PlayerselectionVC" bundle:nil];
        }
        NSInteger playercount1;
        self.strValue=txtEdit.text;
        if([self.strTitle isEqualToString:@"Truth"])
        {
            NSString *strQuery=[NSString stringWithFormat:@"select * from tblTruth where pkTruthChallengeID='%@'",self.strPrimaryKey];
            NSMutableArray *dataArray=[self executeQuery:strQuery];
            if (flagplayer==NO) {
            if (![dataArray count]==0) {
                NSDictionary *dict=[dataArray objectAtIndex:0];
                playercount1=[[dict objectForKey:@"minplayers"] integerValue];
            }
            else
            {
                playercount1=2;
            }
            }
            else
            {
                NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
                playercount1= [[prefs1 stringForKey:@"No player"] integerValue];
            }
           flagplayer=YES;
        }
        else
        {
            NSString *strQuery=[NSString stringWithFormat:@"select * from tblDare where pkDaresChallengeID='%@'",self.strPrimaryKey];
            NSMutableArray *dataArray=[self executeQuery:strQuery];
            if (flagplayer==NO) {
            if (![dataArray count]==0) {
                NSDictionary *dict=[dataArray objectAtIndex:0];
                playercount1=[[dict objectForKey:@"minplayers"] integerValue];
                
            }
            else
            {
                 playercount1=2;
            }
            }
            else
            {
                NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
                playercount1= [[prefs1 stringForKey:@"No player"] integerValue];
            }
            flagplayer=YES;
        }
        objPlayerselectionVC.player=playercount1;
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSString *strstring=[NSString stringWithFormat:@"%d",playercount1];
        [prefs setObject:strstring forKey:@"No player"];
        objPlayerselectionVC.strselection=@"player";
        [self.navigationController pushViewController:objPlayerselectionVC animated:YES];
        [objPlayerselectionVC release]; 
    }

    else if(indexPath.row==6)
    {
        strLocal = NSLocalizedString(@"Are you sure you want to delete this", @"");
            strLocal=[strLocal stringByReplacingOccurrencesOfString:@"*" withString:strTitle];
            textview.text=strLocal;

        
        tblEdit.userInteractionEnabled=NO;
        txtEdit.userInteractionEnabled=NO;
        btnBack.userInteractionEnabled=NO;
        btnSave.userInteractionEnabled=NO;
        
        alerttitle.text=NSLocalizedString(@"Delete", @"");
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [textview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
            [alerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:35.0]];
            alertview.frame=CGRectMake(25, 400, 715, 360);

        }
        else{
            [textview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
            [alerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
            alertview.frame=CGRectMake(25, 200,280, 153);

        }
        [textview setTextColor:[UIColor whiteColor]];
        
          [alerttitle setTextColor:[UIColor whiteColor]];
                [self.view addSubview:alertview];
       [self.view bringSubviewToFront:alertview];
       
    }
}
-(IBAction)YesbtnAction:(id)sender
{
    if([self.strTitle isEqualToString:NSLocalizedString(@"Truth", @"")]) //@"Truth"])
    {
        NSString *strQuery=[NSString stringWithFormat:@"DELETE FROM tblTruth WHERE pkTruthChallengeID='%d'",pktruthordare];
        [self executeQuery:strQuery];
    }
    else
    {
        NSString *strQuery=[NSString stringWithFormat:@"DELETE FROM tblDare WHERE pkDaresChallengeID='%d'",pktruthordare];
        [self executeQuery:strQuery];
    }
    [alertview removeFromSuperview]; 
    tblEdit.userInteractionEnabled=YES;
    txtEdit.userInteractionEnabled=YES;
    btnBack.userInteractionEnabled=YES;
    btnSave.userInteractionEnabled=YES;
    self.view.userInteractionEnabled=YES;
    [self.navigationController popViewControllerAnimated:YES];  

}
-(IBAction)NobtnAction:(id)sender
{
    tblEdit.userInteractionEnabled=YES;
    txtEdit.userInteractionEnabled=YES;
    btnBack.userInteractionEnabled=YES;
    btnSave.userInteractionEnabled=YES;
    [alertview removeFromSuperview]; 
    self.view.userInteractionEnabled=YES;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"button index %d",buttonIndex);
    if(buttonIndex==0)
    {
    if([self.strTitle isEqualToString:@"Truth"])
        {
            NSString *strQuery=[NSString stringWithFormat:@"DELETE FROM tblTruth WHERE pkTruthChallengeID='%d'",[strLastId integerValue]];
            [self executeQuery:strQuery];
        }
    else
        {
            NSString *strQuery=[NSString stringWithFormat:@"DELETE FROM tblDare WHERE pkDaresChallengeID='%d'",[strLastId integerValue]];
            [self executeQuery:strQuery];
        }
    [self.navigationController popViewControllerAnimated:YES];
    }
}
    
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,0)] autorelease];
    UIImageView *seprator;
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
       // seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 6)] ;
         seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 6)] ;
    }
    else
    {
        seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 3)] ;
    }
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [headerView addSubview:seprator];
    [seprator release];
    
    return headerView;
    
}

-(float)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 3.0;
}*/

//Segment changes Method
-(void)segmentAction:(id)sender
{
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    
    switch (seg.tag) 
    {
        case 2:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strActive = @"1";
                break;
            case 1:self.strActive = @"0";
                break;
            default:break;
        }
            break;
        case 3:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strGender = @"1";
                break;
            case 1:self.strGender = @"2";
                break;
            case 2:self.strGender = @"0";
                break;
            default:break;
        }
            break;
        case 5:switch(seg.selectedSegmentIndex)
        {
            case 0:self.strDirtiness = @"3";
                break;
            case 1:self.strDirtiness = @"5";
                break;
            case 2:self.strDirtiness = @"6";
                break;
            default:break;
        }
            break;
            
        default:break;
    }
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
            font = [UIFont boldSystemFontOfSize:11.5f];
        }
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [seg setTitleTextAttributes:attributes forState:UIControlStateNormal];
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
            for (id segment in [seg subviews]) 
            {
                for (id label in [segment subviews]) 
                {
                    if ([label isKindOfClass:[UILabel class]])
                    {
                        UILabel *lbel = (UILabel *)label;
                        lbel.adjustsFontSizeToFitWidth = YES;
                        [label setTextAlignment:UITextAlignmentCenter];
                        [label setFont:[UIFont boldSystemFontOfSize:11.5f]];
                    }
                }           
            }
        }
    }
}
//Dirtiness changes  Method
-(void)dirtiness:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    
    if(btn.tag == 1)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btn2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"1";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"1";
            }
        }
        else
        {
            if([btn2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"1";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"1";
            }
        }
    }
    if(btn.tag == 2)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btn2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"2";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"2";
            }
        }
        else
        {
            if([btn2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"2";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"2";
            }
        }
    }
    if(btn.tag == 3)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btn3.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"3";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"3";
            }

        }
        else
        {
            if([btn3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"3";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"3";
            }

        }
        
    }
    if(btn.tag == 4)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btn4.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"4";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"4";
            }
            
        }
        else
        {
            if([btn4.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"4";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"4";
            }

        }        
    }
    if(btn.tag == 5)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btn5.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"5";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"5";
            }
        }
        else
        {
            if([btn5.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"5";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"5";
            }
            
            
        }
    }
    if(btn.tag == 6)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btn6.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"6";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"6";
            }
        }
        else
        {
            if([btn6.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"6";
            }
            else
            {
                [btn1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btn4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btn6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                self.strDirtiness = @"6";
            }
        }
    }
}
-(NSMutableArray *)executeQuery:(NSString*)str{
    
	sqlite3_stmt *statement= nil;
	sqlite3 *database1;
	NSString *strPath = [self getDatabasePath];
	NSMutableArray *allDataArray = [[[NSMutableArray alloc] init]autorelease];
	if (sqlite3_open([strPath UTF8String],&database1) == SQLITE_OK) {
		if (sqlite3_prepare_v2(database1, [str UTF8String], -1, &statement, NULL) == SQLITE_OK) 
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
	sqlite3_close(database1);
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
//addPersonCode delegate  Methods
#pragma mark person code delegate method
-(void)addPersonCodeAtTheProperRange:(NSString *)prsnCode andPop:(PersonCodeViewController *)controller;
{
        if (textEditRange.location==NSNotFound) 
        {
            textEditRange.location=0;
        }
        else
        {
            if (textEditRange.location!=0)
            {
                const char findchar=[txtEdit.text characterAtIndex:textEditRange.location-1];
                NSString *str=@" ";
                char name=(char)str.UTF8String;
                if (name!=findchar) 
                {
                    prsnCode=[NSString stringWithFormat:@" %@",prsnCode];
                }
            }
       }
    NSMutableString *textVwString = [[NSMutableString alloc] initWithString:txtEdit.text];
    [textVwString insertString:prsnCode atIndex:textEditRange.location];
    txtEdit.text = textVwString;
    [controller.navigationController popViewControllerAnimated:YES];
    [textVwString release];
}

- (void)PersonCodeViewControllerDidFinish:(PersonCodeViewController *)controller 
{
    txtEdit.text = [NSString stringWithFormat:@"%@", controller.strPassedCode];
    [controller.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc
{
    self.btnBack = nil;
    self.btnSave = nil;
    self.lblTitle = nil;
    self.txtEdit = nil;
    self.tblEdit = nil;
    self.strTitle=nil;
    self.strValue=nil;
    self.strPrimaryKey=nil;
    self.strDirtiness=nil;
    self.strGender=nil;
    self.strPlayers=nil;
    self.strActive=nil;
    self.strOrigin=nil;
    self.strLastId=nil;
}
@end
