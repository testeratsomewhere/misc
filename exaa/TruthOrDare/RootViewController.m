

#import "RootViewController.h"
#import "TruthAndDareList.h"
#import "SettingsViewController.h"
#import "UserDefaultSettings.h"
#import "PlayViewController.h"
#import "Popup.h"

@implementation RootViewController

@synthesize arrPlayers;
@synthesize arrPlayersGender;
@synthesize tblPlayer;
@synthesize txtPlayerName;
@synthesize btnAddPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

#pragma mark - View lifecycle
-(IBAction)HeyBtnAction:(id)sender
{
    [HeyzapSDK startHeyzapWithAppId: @"501017656"];
    [[HeyzapSDK sharedSDK] checkinWithMessage:@"I just checked into Truth or Dare Party! And you're invited!"];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    tblPlayer.backgroundColor = [UIColor clearColor];
    arrPlayers = [[NSMutableArray alloc] init];
    arrPlayersGender = [[NSMutableArray alloc] init];
    thisDevice  = [UIDevice currentDevice];
    
    arrCustomDares = [[NSMutableArray alloc] init];
    arrCustomTruths = [[NSMutableArray alloc] init];
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [txtPlayerName setFont:[UIFont fontWithName:@"Segoe Print" size:42.0]];
    }
    else
    {
        [txtPlayerName setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
    }

    arrPlayerName = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Name"];
    if([arrPlayerName count] != 0)
    {
        for(int i=0; i<[arrPlayerName count]; i++)
        {
            [arrPlayers addObject:[arrPlayerName objectAtIndex:i]];
        }
    }
    arrPlayerGender = [[UserDefaultSettings sharedSetting] retrieveArray:@"Player Gender"];
    if([arrPlayerGender count] != 0)
    {
        for(int i=0; i<[arrPlayerGender count]; i++)
        {
            [arrPlayersGender addObject:[arrPlayerGender objectAtIndex:i]];
        }
    }
    
    appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone)
    {
        lbltitle.font=[UIFont fontWithName:@"Segoe Print" size:22];
    }
    else
    {
        lbltitle.font=[UIFont fontWithName:@"Segoe Print" size:42];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@", CurrentLang);
    NSLog(@"%@",NSLocalizedString(@"Truth or Dare", @"") );
    lbltitle.text=NSLocalizedString(@"Truth or Dare", @"");
    txtPlayerName.placeholder = NSLocalizedString(@"Enter name key", @"");
    
    [self update_UI];
    
    NSLog(@"%@",CurrentLang);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"TruthDair" ofType:@"db"];
    if([path isEqual:[NSNull null]] || path == nil)
    {
        //New Install
        NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"CopyDatabase"];
        if([dictSettings count] == 0 || dictSettings  == nil)
        {
            [self createEditableCopyOfDatabaseIfNeeded];
            [self initializeDatabase];
            NSArray *objects = [NSArray arrayWithObjects:@"YES", nil];
            NSArray *keys = [NSArray arrayWithObjects:@"CopiedDatabase",nil];
            
            NSDictionary *dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"CopyDatabase"];
        }
    }
    else
    {
        //Updating Database
        NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"CopyDatabase"];
        if([dictSettings count] == 0 || dictSettings  == nil)
        {  
            [self createEditableCopyOfDatabaseIfNeeded];
            [self initializeDatabase];
            [self initializeOldDatabase];
            
            [dbActivityIndicator startAnimating];
            
            [self fetchCustomTruths];
            [self fetchCustomDares];
            
            NSArray *objects = [NSArray arrayWithObjects:@"YES", nil];
            NSArray *keys = [NSArray arrayWithObjects:@"CopiedDatabase",nil];
            
            NSDictionary *dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
            [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"CopyDatabase"];
        }
        else
        {
            NSLog(@"Database already copied");
        }
    }
}
- (void)createEditableCopyOfDatabaseIfNeeded
{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success) 
        return;
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}
- (void)initializeDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
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

-(void)initializeOldDatabase
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"TruthDair.db"];
    // Open the database. The database was prepared outside the application.
    if (sqlite3_open([path UTF8String], &databaseOLD) == SQLITE_OK) 
    {
        NSLog(@"Database Opened Successfully..");
        appDelegate.databaseOLD = databaseOLD;
    } 
    else 
    {
        // Even though the open failed, call close to properly clean up resources.
        sqlite3_close(databaseOLD);
        NSAssert1(0, @"Failed to open database with message '%s'.", sqlite3_errmsg(databaseOLD));
    }
}

///====================================
///====================================

-(NSString* )getOLDDatabasePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthDair.db"];
	return writableDBPath;
}
-(NSString* )getNEWDatabasePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
	return writableDBPath;
}
-(void)fetchCustomDares
{
    NSString *strQueryDare=[NSString stringWithFormat:@"select * from tblDare where source=\"1\" " ];
    
    NSMutableArray *arr = [self executeQuery:strQueryDare];
    NSLog(@"%@", arr);
    if([arr count] >0)
    {
        for(int i=0; i<[arr count]; i++)
        {
            [arrCustomDares addObject:[arr objectAtIndex:i]];
        }
        
        [self insertCustomDaresIntoNewDB];
        [dbActivityIndicator stopAnimating];
    }
    else
    {
        [dbActivityIndicator stopAnimating];
    }
}

-(void)fetchCustomTruths
{
    NSString *strQueryTruth=[NSString stringWithFormat:@"select * from tblTruth where source=\"1\" " ];
    
    NSMutableArray *arr = [self executeQuery:strQueryTruth];
    NSLog(@"%@", arr);
    if([arr count] > 0)
    {
        for(int i=0; i<[arr count]; i++)
        {
            [arrCustomTruths addObject:[arr objectAtIndex:i]];
        }
        [self insertCustomTruthsIntoNewDB];
    }
}

-(void)insertCustomTruthsIntoNewDB
{
    static sqlite3_stmt *addStmt = nil;
    
    for(int i=0; i<[arrCustomTruths count]; i++)
    {
        if(addStmt == nil) 
        {
            const char *sqlTruth=nil;
            
            sqlTruth = "insert into tblTruth (ln_EN, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
            
            if(sqlite3_prepare_v2(database, sqlTruth, -1, &addStmt, NULL) != SQLITE_OK) 
            {
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(addStmt, 1, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"ln_EN"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 2, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"dirty"] UTF8String], -1, SQLITE_TRANSIENT);
            NSInteger Numberofplayers=[[[arrCustomTruths objectAtIndex:i] valueForKey:@"minplayers"] intValue];
            sqlite3_bind_int(addStmt, 3, Numberofplayers);
            sqlite3_bind_text(addStmt, 4, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"Gender"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 5, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"source"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 6, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"active"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 7, [[[arrCustomTruths objectAtIndex:i] valueForKey:@"add_person_code"] UTF8String], -1, SQLITE_TRANSIENT);
            
            if(SQLITE_DONE != sqlite3_step(addStmt)) 
            {
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            }
            sqlite3_reset(addStmt);
            sqlite3_finalize(addStmt);
            addStmt = nil;
        }
    }
}
-(void)insertCustomDaresIntoNewDB
{
    static sqlite3_stmt *addStmt = nil;
    
    for(int i=0; i<[arrCustomDares count]; i++)
    {
        if(addStmt == nil) 
        {
            const char *sqlTruth=nil;
            
            sqlTruth = "insert into tblDare (ln_EN, dirty, minplayers, gender, source, active, add_person_code) values(?,?,?,?,?,?,?)";
            
            
            if(sqlite3_prepare_v2(database, sqlTruth, -1, &addStmt, NULL) != SQLITE_OK) 
            {
                NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
            }
            
            sqlite3_bind_text(addStmt, 1, [[[arrCustomDares objectAtIndex:i] valueForKey:@"ln_EN"] UTF8String], -1, SQLITE_TRANSIENT);
            
            sqlite3_bind_text(addStmt, 2, [[[arrCustomDares objectAtIndex:i] valueForKey:@"dirty"] UTF8String], -1, SQLITE_TRANSIENT);
            NSInteger Numberofplayers=[[[arrCustomDares objectAtIndex:i] valueForKey:@"minplayers"] intValue];
            sqlite3_bind_int(addStmt, 3, Numberofplayers);
            sqlite3_bind_text(addStmt, 4, [[[arrCustomDares objectAtIndex:i] valueForKey:@"gender"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 5, [[[arrCustomDares objectAtIndex:i] valueForKey:@"source"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 6, [[[arrCustomDares objectAtIndex:i] valueForKey:@"active"] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(addStmt, 7, [[[arrCustomDares objectAtIndex:i] valueForKey:@"add_person_code"] UTF8String], -1, SQLITE_TRANSIENT);
            
            if(SQLITE_DONE != sqlite3_step(addStmt)) 
            {
                NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
            }
            sqlite3_reset(addStmt);
            sqlite3_finalize(addStmt);
            addStmt = nil;
            
        }
    }
    //[dbActivityIndicator stopAnimating];
    
    //[poolDare2 drain];
}

-(NSMutableArray *)executeQuery:(NSString*)str
{
	sqlite3_stmt *statement= nil;
	sqlite3 *database1;
	NSString *strPath = [self getOLDDatabasePath];
	NSMutableArray *allDataArray = [[NSMutableArray alloc] init];
	if (sqlite3_open([strPath UTF8String],&database1) == SQLITE_OK)
    {
		if (sqlite3_prepare_v2(database1, [str UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
			while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSInteger i = 0;
				NSInteger iColumnCount = sqlite3_column_count(statement);
				NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
				while (i< iColumnCount) 
                {
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
	return [allDataArray autorelease];
}

//For Replace Truth List 

-(NSString*)encodedString:(const unsigned char *)ch
{
	NSString *retStr;
	if(ch == nil)
		retStr = @"";
	else
		retStr = [NSString stringWithCString:(char*)ch encoding:NSUTF8StringEncoding];
	return retStr;
}


//Insert Dare List in Old Database Table
-(void)setDareRecord:(NSMutableDictionary *)dataArr:(NSMutableArray *)columnName
{    
	
    sqlite3_stmt *dareStmnt;
	NSString *strPath = [self getNEWDatabasePath];
    
    //Insert new records
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[dataArr count]; i++)
    {
        NSString *str = [columnName objectAtIndex:i];
        [arr addObject:[dataArr objectForKey:str]];
    }
    if (sqlite3_open([strPath UTF8String],&database) == SQLITE_OK)
    {
        NSString *str = @"insert into tblDare (ln_EN, ln_DE, ln_FR, ln_IT, ln_ZH, ln_ES, ln_ESRES, ln_KO, dirty, minplayers, gender, source, active, Add_person_code) Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        if (sqlite3_prepare_v2(database, [str UTF8String], -1, &dareStmnt, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(dareStmnt, 1, [[arr objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 2, [[arr objectAtIndex:1] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 3, [[arr objectAtIndex:2] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 4, [[arr objectAtIndex:3] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 5, [[arr objectAtIndex:4] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 6, [[arr objectAtIndex:5] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 7, [[arr objectAtIndex:6] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 8, [[arr objectAtIndex:7] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(dareStmnt, 9, [[arr objectAtIndex:8] intValue] );
            sqlite3_bind_text(dareStmnt, 10, [[arr objectAtIndex:9] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 11, [[arr objectAtIndex:10] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 12, [[arr objectAtIndex:11] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 13, [[arr objectAtIndex:12] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(dareStmnt, 14, [[arr objectAtIndex:13] UTF8String], -1, SQLITE_TRANSIENT);
        }
        else
            NSLog(@"error in rename");
        if(SQLITE_DONE != sqlite3_step(dareStmnt))
        {
            NSLog(@"error in rename");
        }
        sqlite3_reset(dareStmnt);
        
        sqlite3_finalize(dareStmnt);
        dareStmnt = nil;
    }
	sqlite3_close(database);
}

//Insert Truth List in Old Database Table
-(void)setTruthRecord:(NSMutableDictionary *)dataArr:(NSMutableArray *)columnName
{
    sqlite3_stmt *statement= nil; 
    
	sqlite3 *database1;
	NSString *strPath = [self getNEWDatabasePath];
    
    //Insert new records
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    for (int i=0; i<[dataArr count]; i++)
    {
        NSString *str = [columnName objectAtIndex:i];
        [arr addObject:[dataArr objectForKey:str]];
    }
    if (sqlite3_open([strPath UTF8String],&database1) == SQLITE_OK)
    {
        NSString *str = @"insert into tblTruth (ln_EN, ln_DE, ln_FR, ln_IT, ln_ZH, ln_ES, ln_ESRES, ln_KO, dirty, minplayers, gender, source, active, add_person_code)Values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        if (sqlite3_prepare_v2(database1, [str UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
            sqlite3_bind_text(statement, 1, [[arr objectAtIndex:0] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [[arr objectAtIndex:1] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [[arr objectAtIndex:2] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [[arr objectAtIndex:3] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [[arr objectAtIndex:4] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 6, [[arr objectAtIndex:5] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 7, [[arr objectAtIndex:6] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 8, [[arr objectAtIndex:7] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_int(statement, 9, [[arr objectAtIndex:8] intValue] );
            sqlite3_bind_text(statement, 10, [[arr objectAtIndex:9] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 11, [[arr objectAtIndex:10] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 12, [[arr objectAtIndex:11] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 13, [[arr objectAtIndex:12] UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 14, [[arr objectAtIndex:13] UTF8String], -1, SQLITE_TRANSIENT);
        }
        else
            NSLog(@"error in rename");
        if(SQLITE_DONE != sqlite3_step(statement))
        {
            NSLog(@"error in rename");
        }
        sqlite3_reset(statement);
        
        sqlite3_finalize(statement);
        statement = nil;
    }
	sqlite3_close(database1);
}

//=====================================
//=====================================

#pragma mark - custom methods

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnPlay = nil;
    UIImage *imgBtnYes = nil;
    UIImage *imgBtnNo = nil;
    
    NSString *strPlayBtn=nil;
    NSString *strYesBtn=nil;
    NSString *strNoBtn=nil;
    
    
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        NSString *str = [[UIDevice currentDevice] systemVersion];
        float version = str.floatValue;
        if(version >= 5.0)
        {
            btnHeyZap.userInteractionEnabled = YES;
            [btnHeyZap setImage:[UIImage imageNamed:@"Zicon200_iPad.png"] forState:UIControlStateNormal];        
        }
        else
        {
            btnHeyZap.userInteractionEnabled = NO;
            if (![CurrentLang isEqualToString:@"en"])
                [btnHeyZap setImage:[UIImage imageNamed:@"logo_iPad.png"] forState:UIControlStateNormal]; 
            else
                [btnHeyZap setImage:[UIImage imageNamed:@"logo_iPadTOD.png"] forState:UIControlStateNormal];
        }
        
        strPlayBtn = [NSString stringWithFormat:@"play_btn_iPad_%@",CurrentLang];
        strYesBtn = [NSString stringWithFormat:@"btn_yes_iPad_%@",CurrentLang];
        strNoBtn = [NSString stringWithFormat:@"btn_no_iPad_%@",CurrentLang];
        
        imgBtnPlay =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strPlayBtn ofType:@"png"]];
        imgBtnYes=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strYesBtn ofType:@"png"]];
        imgBtnNo=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strNoBtn ofType:@"png"]];
        
        [playbtn setImage:imgBtnPlay forState:UIControlStateNormal];
        [btnAddYes setImage:imgBtnYes forState:UIControlStateNormal];
        [btnChangeYes setImage:imgBtnYes forState:UIControlStateNormal];
        [btnAddNo setImage:imgBtnNo forState:UIControlStateNormal];
        [btnChangeNo setImage:imgBtnNo forState:UIControlStateNormal];
    }
    else
    {
        NSLog(@"%@",CurrentLang);
        [btnHeyZap setImage:nil forState:UIControlStateNormal];
        NSString *str = [[UIDevice currentDevice] systemVersion];
        float version = str.floatValue;
        if(version >= 5.0)
        {
            btnHeyZap.userInteractionEnabled = YES;
            [btnHeyZap setImage:[UIImage imageNamed:@"Zicon200.png"] forState:UIControlStateNormal];        
        }
        else
        {
            btnHeyZap.userInteractionEnabled = NO;
            if (![CurrentLang isEqualToString:@"en"])
                [btnHeyZap setImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal]; 
            else
                [btnHeyZap setImage:[UIImage imageNamed:@"logoTOD.png"] forState:UIControlStateNormal];
        }
        
        strPlayBtn = [NSString stringWithFormat:@"play_%@",CurrentLang];
        strYesBtn = [NSString stringWithFormat:@"btn_yes_%@",CurrentLang];
        strNoBtn = [NSString stringWithFormat:@"btn_no_%@",CurrentLang];
        
        imgBtnPlay =[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strPlayBtn ofType:@"png"]];
        imgBtnYes=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strYesBtn ofType:@"png"]];
        imgBtnNo=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:strNoBtn ofType:@"png"]];
        
        [playbtn setImage:imgBtnPlay forState:UIControlStateNormal];
        [btnAddYes setImage:imgBtnYes forState:UIControlStateNormal];
        [btnChangeYes setImage:imgBtnYes forState:UIControlStateNormal];
        [btnAddNo setImage:imgBtnNo forState:UIControlStateNormal];
        [btnChangeNo setImage:imgBtnNo forState:UIControlStateNormal];
    }
    
    strPlayBtn=nil;
    [strPlayBtn release];
    strYesBtn=nil;
    [strYesBtn release];
    strNoBtn=nil;
    [strNoBtn release];
}

//Add New Player method
-(IBAction)addPlayer
{
    NSString *trimmedString = [txtPlayerName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if ([trimmedString isEqualToString:@""])
    {
        [txtPlayerName resignFirstResponder];
        strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Enter player name", @"")];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        if([self checkNameExistence])
        {
            [txtPlayerName resignFirstResponder];
            
            strLocal = [[NSString alloc]initWithString:NSLocalizedString(@"Already entered", @"")];
            
            strLocal=[strLocal stringByReplacingOccurrencesOfString:@"*" withString:name];
            strAlertMessage=strLocal;
            
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            txtPlayerName.text = @"";
            [dictAlertMessage release];
        }
        else
        {    
            NSString *strPlayerName = txtPlayerName.text;
            int strLen = strPlayerName.length;
            if(strLen == 26)
            {
                
            }
            else
            {
                //                BOOL onlyNumbers = NO;
                //                NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
                //            
                //                NSPredicate *rp =  [NSPredicate predicateWithFormat:@"SELF MATCHES '[0-9*]+'"];
                //                if ([rp evaluateWithObject:trimmedString])
                //                    onlyNumbers = YES;
                //                else
                //                    onlyNumbers = NO;
                //            
                //                if ([trimmedString rangeOfCharacterFromSet:set].location != NSNotFound || onlyNumbers) 
                //                {
                //                    [txtPlayerName resignFirstResponder];
                //                    strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Special char key", @"")];
                //                    dictAlertMessage = [[NSMutableDictionary alloc] init];
                //                    [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
                //                    [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
                //                    [dictAlertMessage release];
                //                }
                //                else 
                //                {
                [txtPlayerName resignFirstResponder];
                [arrPlayers addObject:trimmedString];
                [arrPlayersGender addObject:@"Male"];
                txtPlayerName.text = @"";
                [tblPlayer reloadData];
                [FlurryAnalytics logEvent:@"PlayerAdded"];
                NSArray *arrName = [NSArray arrayWithArray:arrPlayers];
                [[UserDefaultSettings sharedSetting] storeArray:arrName withKey:@"Player Name"];
                NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
                [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
                //}               
            }
        }
    }
}

//Check Name Existence method
-(BOOL)checkNameExistence
{
    NSString *trimmedString = [txtPlayerName.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    BOOL flag=NO;
    if([arrPlayers count] != 0)
    {
        for(int i=0; i<[arrPlayers count]; i++)
        {
            if(![trimmedString caseInsensitiveCompare:[arrPlayers objectAtIndex:i]])
            {
                flag = TRUE;
                name = [arrPlayers objectAtIndex:i];
                break;
            }
            else
            {
                flag = FALSE;  
            }
        }
    }
    else
    {
        flag = FALSE;
    }
    return flag;
}
//Go to Seetings screen method
-(IBAction)goToSettings
{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        SettingsViewController *settingsObj = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
        [self.navigationController pushViewController:settingsObj animated:YES];
        [settingsObj release];
    }
    else
    {
        SettingsViewController *settingsObj = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
        [self.navigationController pushViewController:settingsObj animated:YES];
        [settingsObj release];
    }
    
    
}
-(IBAction)NobtnAction:(id)sender
{
    btnAddPlayer.userInteractionEnabled=YES;
    txtPlayerName.userInteractionEnabled=YES;
    tblPlayer.userInteractionEnabled=YES;
    settingbtn.userInteractionEnabled=YES;
    playbtn.userInteractionEnabled=YES;
    [alertview removeFromSuperview]; 
    self.view.userInteractionEnabled=YES;
    txtPlayerName.text=@""; 
    NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    if([dictSettings count] == 0)
    {
        NSString *strSound=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strTakesTrueInOrder=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strMyDaresOnly=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strAllowChangingDares=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strClean=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strDirty=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strSuperDirty =[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strTruthMode =[[[NSString alloc]initWithFormat:@"Off"]autorelease];
        NSString *strSpeed =[[[NSString alloc]initWithFormat:@"3"]autorelease];
        NSString *strAutoTruth =[[[NSString alloc]initWithFormat:@"6"]autorelease];
        NSString *strAutoTruthFlag=[[[NSString alloc]initWithFormat:@"YES"]autorelease];
        NSArray *objects = [NSArray arrayWithObjects:
                            strSound, 
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
                            nil];
        NSArray *keys = [NSArray arrayWithObjects:@"Sound", @"Takes True In Order", @"My Dares Only", @"Allow Changing Dares", @"Clean", @"Dirty", @"Super Dirty", @"Truth Mode", @"Speed", @"Auto Truth",@"AutoTruthFlag",nil];
        
        if (dictSettings != nil)
        {
            dictSettings = nil;
        }
        dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"Settings"];  
    }
    
    if([arrPlayers count] < 2)
    {
        strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Minimum two players", @"")];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        couplealerttitle.text=NSLocalizedString(@"Change Setting", @"");
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        appDelegate.usedGender = arr;
        [arr release];
        //-----------
        if (appDelegate.Changesettingint==1) 
        {
            NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
            if (dictSettings>0) 
            {
                NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
                if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"])&&([[dictSettings valueForKey:@"Speed"]integerValue]<3)) 
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-1", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                    }
                    else{
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                    }
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple];
                }
                else if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"]))
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-2", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                        
                    }
                    else{
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                    }
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple];
                }
                else if(([arrPlayers count]>2)&&([[dictSettings valueForKey:@"Speed"]integerValue]<3))
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-3", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                        
                    }
                    else{
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                    }
                    
                    
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple]; 
                }
                else
                {
                    [self changesettings];
                }
                
            }
        }
        else
        {
            PlayViewController *playObj;
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController_iPad" bundle:nil];
            }
            else
            {
                playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
            }
            playObj.arrPlayerName = arrPlayers;
            playObj.arrPlayerGender = arrPlayersGender;
            appDelegate.stackArr = [NSMutableArray arrayWithArray:arrPlayers];
            appDelegate.stackGenderArr = [NSMutableArray arrayWithArray:arrPlayersGender];
            NSMutableArray *tempArr = [[NSMutableArray alloc] init];
            appDelegate.playerDetailsArray = tempArr;
            [tempArr release];
            
            for (int i=0; i<[arrPlayers count]; i++) 
            {
                NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                [dict setObject:[arrPlayers objectAtIndex:i] forKey:@"Player"];
                [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"DareNumber"];
                [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"TruthNumber"];
                //------Speed--------------//
                [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"SpeedNo"];
                [appDelegate.playerDetailsArray addObject:dict];
                [dict release];
            }
            
            [self.navigationController pushViewController:playObj animated:YES];
            [playObj release];                
        }
        //-------------
    }
    if(appDelegate.arrDirtinesNumber>0)
    {
        [appDelegate.arrDirtinesNumber removeAllObjects];
    }
    appDelegate.arrDirtinesNumber=[[NSMutableArray alloc]init];
    NSString *strClean = [dictSettings objectForKey:@"Clean"];
    NSString *strDirty = [dictSettings objectForKey:@"Dirty"];
    NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
    appDelegate.dirtinessLevel = 0;
    
    if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        appDelegate.dirtinessLevel = 3;
    else if(([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]) || ([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]) || ([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]))
        appDelegate.dirtinessLevel = 2;
    else 
        appDelegate.dirtinessLevel = 1;
    if(appDelegate.dirtinessLevel == 1)
    {
        if([strClean isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=3;
            appDelegate.dirtystartValueformine=1;
        }
        else if([strDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.Dirtyvalue=5;
            appDelegate.dirtystartValue=4;
            appDelegate.dirtystartValueformine=4;
        }
        else if([strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=6;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=6;
        }
        
        
        
    }
    else if(appDelegate.dirtinessLevel == 2)
    {
        if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=5;
            appDelegate.dirtystartValueformine=1;
        }
        else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=1;
            
            
        }
        else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=4;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=4;
            
        }
        
    }
    else if(appDelegate.dirtinessLevel == 3)
    {
        [appDelegate.arrDirtinesNumber addObject:@"1"];
        [appDelegate.arrDirtinesNumber addObject:@"2"];
        [appDelegate.arrDirtinesNumber addObject:@"3"];
        [appDelegate.arrDirtinesNumber addObject:@"4"];
        [appDelegate.arrDirtinesNumber addObject:@"5"];
        [appDelegate.arrDirtinesNumber addObject:@"6"];
        appDelegate.dirtystartValue=1;
        appDelegate.Dirtyvalue=6;
        appDelegate.dirtystartValueformine=1;
    }
}
-(IBAction)YesbtnAction:(id)sender
{
    {
        couplealerttitle.text=NSLocalizedString(@"Change Setting", @"");
        if([self checkNameExistence])
        {
            [txtPlayerName resignFirstResponder];
            strLocal=[[NSString alloc]initWithString:NSLocalizedString(@"Already entered", @"")];
            
            strLocal=[strLocal stringByReplacingOccurrencesOfString:@"*" withString:name];
            strAlertMessage=strLocal;
            
            dictAlertMessage = [[NSMutableDictionary alloc] init];
            [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
            [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
            txtPlayerName.text = @"";
            [dictAlertMessage release];
        }
        else
        {    
            NSString *strPlayerName = txtPlayerName.text;
            int strLen = strPlayerName.length;
            if(strLen > 25)
            {
                strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Maximum 25 char key", @"")];
                dictAlertMessage = [[NSMutableDictionary alloc] init];
                [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
                [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
                [dictAlertMessage release];
            }
            else
            {
                NSString *string = txtPlayerName.text;
                NSString *trimmedString = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                [txtPlayerName resignFirstResponder];
                [arrPlayers addObject:trimmedString];
                [arrPlayersGender addObject:@"Male"];
                txtPlayerName.text = @"";
                [tblPlayer reloadData];
                NSArray *arrName = [NSArray arrayWithArray:arrPlayers];
                [[UserDefaultSettings sharedSetting] storeArray:arrName withKey:@"Player Name"];
                NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
                [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
                NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                if([dictSettings count] == 0)
                {
                    NSString *strSound=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
                    NSString *strTakesTrueInOrder=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
                    NSString *strMyDaresOnly=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
                    NSString *strAllowChangingDares=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
                    NSString *strClean=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
                    NSString *strDirty=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
                    NSString *strSuperDirty =[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
                    NSString *strTruthMode =[[[NSString alloc]initWithFormat:@"Off"]autorelease];
                    NSString *strSpeed =[[[NSString alloc]initWithFormat:@"3"]autorelease];
                    NSString *strAutoTruth =[[[NSString alloc]initWithFormat:@"6"]autorelease];
                    NSString *strAutoTruthFlag=[[[NSString alloc]initWithFormat:@"YES"]autorelease];
                    NSArray *objects = [NSArray arrayWithObjects:
                                        strSound, 
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
                                        nil];
                    NSArray *keys = [NSArray arrayWithObjects:@"Sound", @"Takes True In Order", @"My Dares Only", @"Allow Changing Dares", @"Clean", @"Dirty", @"Super Dirty", @"Truth Mode", @"Speed", @"Auto Truth",@"AutoTruthFlag",nil];
                    
                    if (dictSettings != nil)
                    {
                        dictSettings = nil;
                    }
                    dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
                    [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"Settings"];  
                }
                if([arrPlayers count] < 2)
                {
                    strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Minimum two players", @"")];
                    dictAlertMessage = [[NSMutableDictionary alloc] init];
                    [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
                    [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
                    [dictAlertMessage release];
                }
                else
                {
                    NSMutableArray *arr = [[NSMutableArray alloc] init];
                    appDelegate.usedGender = arr;
                    [arr release];
                    
                    if (appDelegate.Changesettingint==1) 
                    {
                        NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
                        if ([dictSettings count]>0) 
                        {
                            NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
                            if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"])&&([[dictSettings valueForKey:@"Speed"]integerValue]<3)) 
                            {
                                alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-1", @"")];
                                btnAddPlayer.userInteractionEnabled=NO;
                                txtPlayerName.userInteractionEnabled=NO;
                                tblPlayer.userInteractionEnabled=NO;
                                settingbtn.userInteractionEnabled=NO;
                                playbtn.userInteractionEnabled=NO;
                                
                                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                                    alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                                }
                                else{
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                                    alertforcouple.frame=CGRectMake(25, 100,280, 268);
                                }
                                [textview setTextColor:[UIColor whiteColor]];
                                [couplealerttitle setTextColor:[UIColor blackColor]];
                                [self.view addSubview:alertforcouple];
                                [self.view bringSubviewToFront:alertforcouple];
                            }
                            else if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"]))
                            {
                                alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-2", @"")];
                                btnAddPlayer.userInteractionEnabled=NO;
                                txtPlayerName.userInteractionEnabled=NO;
                                tblPlayer.userInteractionEnabled=NO;
                                settingbtn.userInteractionEnabled=NO;
                                playbtn.userInteractionEnabled=NO;
                                
                                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                                    alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                                }
                                else{
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                                    alertforcouple.frame=CGRectMake(25, 100,280, 268);
                                }
                                
                                [textview setTextColor:[UIColor whiteColor]];
                                [couplealerttitle setTextColor:[UIColor blackColor]];
                                [self.view addSubview:alertforcouple];
                                [self.view bringSubviewToFront:alertforcouple];
                            }
                            else if(([arrPlayers count]>2)&&([[dictSettings valueForKey:@"Speed"]integerValue]<3))
                            {
                                alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-3", @"")];
                                btnAddPlayer.userInteractionEnabled=NO;
                                txtPlayerName.userInteractionEnabled=NO;
                                tblPlayer.userInteractionEnabled=NO;
                                settingbtn.userInteractionEnabled=NO;
                                playbtn.userInteractionEnabled=NO;
                                
                                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                                    alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                                }
                                else{
                                    [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                                    [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                                    alertforcouple.frame=CGRectMake(25, 100,280, 268);
                                }
                                [textview setTextColor:[UIColor whiteColor]];
                                [couplealerttitle setTextColor:[UIColor blackColor]];
                                [self.view addSubview:alertforcouple];
                                [self.view bringSubviewToFront:alertforcouple]; 
                            }
                            else
                            {
                                [self changesettings];
                            }
                        }
                        else
                        {
                            [self changesettings];
                        }
                        
                    }
                    else
                    {
                        PlayViewController *playObj;
                        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
                        {
                            // iPad
                            playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController_iPad" bundle:nil];
                        }
                        else
                        {
                            // iPhone
                            playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
                            
                        }
                        playObj.arrPlayerName = arrPlayers;
                        playObj.arrPlayerGender = arrPlayersGender;
                        appDelegate.stackArr = [NSMutableArray arrayWithArray:arrPlayers];
                        appDelegate.stackGenderArr = [NSMutableArray arrayWithArray:arrPlayersGender];
                        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
                        appDelegate.playerDetailsArray = tempArr;
                        [tempArr release];
                        
                        for (int i=0; i<[arrPlayers count]; i++) 
                        {
                            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
                            [dict setObject:[arrPlayers objectAtIndex:i] forKey:@"Player"];
                            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"DareNumber"];
                            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"TruthNumber"];
                            //------Speed--------------//
                            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"SpeedNo"];
                            [appDelegate.playerDetailsArray addObject:dict];
                            [dict release];
                        }
                        
                        [self.navigationController pushViewController:playObj animated:YES];
                        [playObj release];
                        
                    }
                    
                    //------------
                    
                    
                }
                if(appDelegate.arrDirtinesNumber>0)
                {
                    [appDelegate.arrDirtinesNumber removeAllObjects];
                }
                appDelegate.arrDirtinesNumber=[[NSMutableArray alloc]init];
                NSString *strClean = [dictSettings objectForKey:@"Clean"];
                NSString *strDirty = [dictSettings objectForKey:@"Dirty"];
                NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
                appDelegate.dirtinessLevel = 0;
                
                if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
                    appDelegate.dirtinessLevel = 3;
                else if(([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]) || ([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]) || ([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]))
                    appDelegate.dirtinessLevel = 2;
                else 
                    appDelegate.dirtinessLevel = 1;
                if(appDelegate.dirtinessLevel == 1)
                {
                    if([strClean isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"1"];
                        [appDelegate.arrDirtinesNumber addObject:@"2"];
                        [appDelegate.arrDirtinesNumber addObject:@"3"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        appDelegate.dirtystartValue=1;
                        appDelegate.Dirtyvalue=3;
                        appDelegate.dirtystartValueformine=1;
                    }
                    else if([strDirty isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"4"];
                        [appDelegate.arrDirtinesNumber addObject:@"5"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        appDelegate.Dirtyvalue=5;
                        appDelegate.dirtystartValue=4;
                        appDelegate.dirtystartValueformine=4;
                    }
                    else if([strSuperDirty isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"6"];
                        appDelegate.dirtystartValue=6;
                        appDelegate.Dirtyvalue=6;
                        appDelegate.dirtystartValueformine=6;
                    }
                    
                    
                    
                }
                else if(appDelegate.dirtinessLevel == 2)
                {
                    if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"1"];
                        [appDelegate.arrDirtinesNumber addObject:@"2"];
                        [appDelegate.arrDirtinesNumber addObject:@"3"];
                        [appDelegate.arrDirtinesNumber addObject:@"4"];
                        [appDelegate.arrDirtinesNumber addObject:@"5"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        appDelegate.dirtystartValue=1;
                        appDelegate.Dirtyvalue=5;
                        appDelegate.dirtystartValueformine=1;
                    }
                    else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"1"];
                        [appDelegate.arrDirtinesNumber addObject:@"2"];
                        [appDelegate.arrDirtinesNumber addObject:@"3"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"6"];
                        appDelegate.dirtystartValue=1;
                        appDelegate.Dirtyvalue=6;
                        appDelegate.dirtystartValueformine=1;
                        
                        
                    }
                    else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
                    {
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"0"];
                        [appDelegate.arrDirtinesNumber addObject:@"4"];
                        [appDelegate.arrDirtinesNumber addObject:@"5"];
                        [appDelegate.arrDirtinesNumber addObject:@"6"];
                        appDelegate.dirtystartValue=4;
                        appDelegate.Dirtyvalue=6;
                        appDelegate.dirtystartValueformine=4;
                        
                    }
                    
                }
                else if(appDelegate.dirtinessLevel == 3)
                {
                    [appDelegate.arrDirtinesNumber addObject:@"1"];
                    [appDelegate.arrDirtinesNumber addObject:@"2"];
                    [appDelegate.arrDirtinesNumber addObject:@"3"];
                    [appDelegate.arrDirtinesNumber addObject:@"4"];
                    [appDelegate.arrDirtinesNumber addObject:@"5"];
                    [appDelegate.arrDirtinesNumber addObject:@"6"];
                    appDelegate.dirtystartValue=1;
                    appDelegate.Dirtyvalue=6;
                    appDelegate.dirtystartValueformine=1;
                }
                // }
            }               
        }
    }
    btnAddPlayer.userInteractionEnabled=YES;
    txtPlayerName.userInteractionEnabled=YES;
    tblPlayer.userInteractionEnabled=YES;
    settingbtn.userInteractionEnabled=YES;
    playbtn.userInteractionEnabled=YES;
    [alertview removeFromSuperview]; 
    self.view.userInteractionEnabled=YES; 
}

//Play method
-(IBAction)play
{
    if (![txtPlayerName.text isEqualToString:@""]) 
    {
        strLocal=[[NSString alloc]initWithString:NSLocalizedString(@"Do you want to add", @"")];
        strLocal=[strLocal stringByReplacingOccurrencesOfString:@"*" withString:txtPlayerName.text];
        NSLog(@"%@",strLocal);
        textview.text = strLocal;
        btnAddPlayer.userInteractionEnabled=NO;
        txtPlayerName.userInteractionEnabled=NO;
        tblPlayer.userInteractionEnabled=NO;
        settingbtn.userInteractionEnabled=NO;
        playbtn.userInteractionEnabled=NO;
        
        alerttitle.text=NSLocalizedString(@"Add name", @"");
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            [textview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:40.0]];
            [alerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:40.0]];
            alertview.frame=CGRectMake(33, 400,705, 340);
            
        }
        else
        {
            if ([CurrentLang isEqualToString:@"fr"])
            {
                [textview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:12.0]];
            }
            else
                [textview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:15.0]];
            [alerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
            alertview.frame=CGRectMake(20, 200,280, 153);
        }
        [textview setTextColor:[UIColor whiteColor]];
        [alerttitle setTextColor:[UIColor whiteColor]];
        [self.view addSubview:alertview];
        [self.view bringSubviewToFront:alertview];
    }
    else
    {
        couplealerttitle.text=NSLocalizedString(@"Change Setting", @"");
        if (appDelegate.Changesettingint==1) 
        {
            NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
            if ([dictSettings count]>0) 
            {
                NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
                if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"])&&([[dictSettings valueForKey:@"Speed"]integerValue]<3)) 
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-1", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45, 200, 660, 570);
                    }
                    else
                    {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                        
                    }
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple];
                }
                else if (([arrPlayers count]>2)&&([strSuperDirty isEqualToString:@"ON"]))
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-2", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45,  200, 660, 570);
                        
                    }
                    else{
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                    }
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple];
                }
                else if(([arrPlayers count]>2)&&([[dictSettings valueForKey:@"Speed"]integerValue]<3))
                {
                    alertforcoupletextview.text=[[NSString alloc]initWithString:NSLocalizedString(@"Alert for couple textview key-3", @"")];
                    btnAddPlayer.userInteractionEnabled=NO;
                    txtPlayerName.userInteractionEnabled=NO;
                    tblPlayer.userInteractionEnabled=NO;
                    settingbtn.userInteractionEnabled=NO;
                    playbtn.userInteractionEnabled=NO;
                    
                    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
                    {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:25.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:30.0]];
                        alertforcouple.frame=CGRectMake(45,  200, 660, 570);
                    }
                    else
                    {
                        [alertforcoupletextview setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:11.0]];
                        [couplealerttitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:18.0]];
                        alertforcouple.frame=CGRectMake(25, 100,280, 268);
                    }
                    
                    [textview setTextColor:[UIColor whiteColor]];
                    [couplealerttitle setTextColor:[UIColor blackColor]];
                    [self.view addSubview:alertforcouple];
                    [self.view bringSubviewToFront:alertforcouple]; 
                }
                else
                {
                    [self changesettings];
                }
            }
            else
            {
                [self changesettings];
            }
        }
        else
        {
            [self changesettings];
        }
    }
}
-(IBAction)YesbtnActionforSetting:(id)sender
{
    btnAddPlayer.userInteractionEnabled=YES;
    txtPlayerName.userInteractionEnabled=YES;
    tblPlayer.userInteractionEnabled=YES;
    settingbtn.userInteractionEnabled=YES;
    playbtn.userInteractionEnabled=YES;
    [alertforcouple removeFromSuperview]; 
    self.view.userInteractionEnabled=YES;
    
    SettingsViewController *settingsObj;
    thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        settingsObj = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:nil];
    }
    else
    {
        settingsObj = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    }
    [self.navigationController pushViewController:settingsObj animated:YES];
    [settingsObj release];
}
-(IBAction)NobtnActionforSetting:(id)sender
{
    appDelegate.Changesettingint=0;
    btnAddPlayer.userInteractionEnabled=YES;
    txtPlayerName.userInteractionEnabled=YES;
    tblPlayer.userInteractionEnabled=YES;
    settingbtn.userInteractionEnabled=YES;
    playbtn.userInteractionEnabled=YES;
    [alertforcouple removeFromSuperview]; 
    self.view.userInteractionEnabled=YES; 
    [self changesettings];
}
-(void)changesettings{
    
    NSDictionary *dictSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
    if([dictSettings count] == 0)
    {
        NSString *strSound=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strTakesTrueInOrder=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strMyDaresOnly=[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strAllowChangingDares=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strClean=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strDirty=[[[NSString alloc]initWithFormat:@"ON"]autorelease];
        NSString *strSuperDirty =[[[NSString alloc]initWithFormat:@"OFF"]autorelease];
        NSString *strTruthMode =[[[NSString alloc]initWithFormat:@"Off"]autorelease];
        NSString *strSpeed =[[[NSString alloc]initWithFormat:@"3"]autorelease];
        NSString *strAutoTruth =[[[NSString alloc]initWithFormat:@"6"]autorelease];
        NSString *strAutoTruthFlag=[[[NSString alloc]initWithFormat:@"YES"]autorelease];
        NSArray *objects = [NSArray arrayWithObjects:
                            strSound, 
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
                            nil];
        NSArray *keys = [NSArray arrayWithObjects:@"Sound", @"Takes True In Order", @"My Dares Only", @"Allow Changing Dares", @"Clean", @"Dirty", @"Super Dirty", @"Truth Mode", @"Speed", @"Auto Truth",@"AutoTruthFlag",nil];
        
        if (dictSettings != nil)
        {
            dictSettings = nil;
        }
        dictSettings = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [[UserDefaultSettings sharedSetting] storeDictionary:dictSettings withKey:@"Settings"];  
    }
    else
    {
        NSString *versionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
        NSString *AppVersion=[NSString stringWithFormat:@"Settings/AppVersion-%@",versionString];
        [FlurryAnalytics logEvent:AppVersion];
        
        NSString *strNumPlayers = [NSString stringWithFormat:@"Settings/NumPlayers-%d",[arrPlayers count]];
        [FlurryAnalytics logEvent:strNumPlayers];
        
        NSString *strSound1 = [NSString stringWithFormat:@"Settings/Sound-%@",[dictSettings valueForKey:@"Sound"]];
        [FlurryAnalytics logEvent:strSound1];
        
        NSString *strTakesTrueInOrder =[NSString stringWithFormat:@"Settings/RandomTurns-%@",[dictSettings valueForKey:@"Takes True In Order"]];
        [FlurryAnalytics logEvent:strTakesTrueInOrder];
        
        NSString *strMyDaresOnly = [NSString stringWithFormat:@"Settings/MyChallengesOnly-%@",[dictSettings valueForKey:@"My Dares Only"]];
        [FlurryAnalytics logEvent:strMyDaresOnly];
        
        NSString *strAllowChangingDares =[NSString stringWithFormat:@"Settings/IsDareChangeAllowed-%@",[dictSettings valueForKey:@"Allow Changing Dares"]];
        [FlurryAnalytics logEvent:strAllowChangingDares];
        
        NSString *strClean =[NSString stringWithFormat:@"Settings/IsCleanOn-%@", [dictSettings valueForKey:@"Clean"]];
        [FlurryAnalytics logEvent:strClean];
        
        NSString *strDirty =[NSString stringWithFormat:@"Settings/IsDirtyOn-%@", [dictSettings valueForKey:@"Dirty"]];
        [FlurryAnalytics logEvent:strDirty];
        
        NSString *strSuperDirty = [NSString stringWithFormat:@"Settings/IsSuperDirtyOn-%@",[dictSettings valueForKey:@"Super Dirty"]];
        [FlurryAnalytics logEvent:strSuperDirty];
        
        NSString *strSpeed = [NSString stringWithFormat:@"Settings/NumDaresPerLevel-%@",[dictSettings valueForKey:@"Speed"]];
        [FlurryAnalytics logEvent:strSpeed];
        
        NSString *strTruthMode =[NSString stringWithFormat:@"Settings/AutoTruthThreshold-%@",[dictSettings valueForKey:@"Auto Truth"] ];
        [FlurryAnalytics logEvent:strTruthMode];
        
        NSString *strAutoTruth = [NSString stringWithFormat:@"Settings/ShakeItUp-%@", [dictSettings valueForKey:@"Truth Mode"]];
        [FlurryAnalytics logEvent:strAutoTruth];
        
    }
    
    
    if([arrPlayers count] < 2)
    {
        strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Minimum two players", @"")];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    else
    {
        NSMutableArray *arr = [[NSMutableArray alloc] init];
        appDelegate.usedGender = arr;
        [arr release];
        
        PlayViewController *playObj;
        if(thisDevice.userInterfaceIdiom==UIUserInterfaceIdiomPad)
        {
            playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController_iPad" bundle:nil];
        }
        else
        {
            playObj = [[PlayViewController alloc] initWithNibName:@"PlayViewController" bundle:nil];
        }
        
        playObj.arrPlayerName = arrPlayers;
        playObj.arrPlayerGender = arrPlayersGender;
        appDelegate.stackArr = [NSMutableArray arrayWithArray:arrPlayers];
        appDelegate.stackGenderArr = [NSMutableArray arrayWithArray:arrPlayersGender];
        NSMutableArray *tempArr = [[NSMutableArray alloc] init];
        appDelegate.playerDetailsArray = tempArr;
        [tempArr release];
        
        for (int i=0; i<[arrPlayers count]; i++) 
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            [dict setObject:[arrPlayers objectAtIndex:i] forKey:@"Player"];
            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"DareNumber"];
            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"TruthNumber"];
            //------Speed--------------//
            [dict setObject:[NSString stringWithFormat:@"0"] forKey:@"SpeedNo"];
            [appDelegate.playerDetailsArray addObject:dict];
            [dict release];
        }
        
        [self.navigationController pushViewController:playObj animated:YES];
        [playObj release];
        
    }
    if(appDelegate.arrDirtinesNumber>0)
    {
        [appDelegate.arrDirtinesNumber removeAllObjects];
    }
    appDelegate.arrDirtinesNumber=[[NSMutableArray alloc]init];
    NSString *strClean = [dictSettings objectForKey:@"Clean"];
    NSString *strDirty = [dictSettings objectForKey:@"Dirty"];
    NSString *strSuperDirty = [dictSettings objectForKey:@"Super Dirty"];
    appDelegate.dirtinessLevel = 0;
    
    if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        appDelegate.dirtinessLevel = 3;
    else if(([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]) || ([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]) || ([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]))
        appDelegate.dirtinessLevel = 2;
    else 
        appDelegate.dirtinessLevel = 1;
    if(appDelegate.dirtinessLevel == 1)
    {
        if([strClean isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=3;
            appDelegate.dirtystartValueformine=1;
        }
        else if([strDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.Dirtyvalue=5;
            appDelegate.dirtystartValue=4;
            appDelegate.dirtystartValueformine=4;
        }
        else if([strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=6;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=6;
        }
        
        
        
    }
    else if(appDelegate.dirtinessLevel == 2)
    {
        if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=5;
            appDelegate.dirtystartValueformine=1;
        }
        else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"1"];
            [appDelegate.arrDirtinesNumber addObject:@"2"];
            [appDelegate.arrDirtinesNumber addObject:@"3"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=1;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=1;
            
            
        }
        else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"0"];
            [appDelegate.arrDirtinesNumber addObject:@"4"];
            [appDelegate.arrDirtinesNumber addObject:@"5"];
            [appDelegate.arrDirtinesNumber addObject:@"6"];
            appDelegate.dirtystartValue=4;
            appDelegate.Dirtyvalue=6;
            appDelegate.dirtystartValueformine=4;
            
        }
        
    }
    else if(appDelegate.dirtinessLevel == 3)
    {
        [appDelegate.arrDirtinesNumber addObject:@"1"];
        [appDelegate.arrDirtinesNumber addObject:@"2"];
        [appDelegate.arrDirtinesNumber addObject:@"3"];
        [appDelegate.arrDirtinesNumber addObject:@"4"];
        [appDelegate.arrDirtinesNumber addObject:@"5"];
        [appDelegate.arrDirtinesNumber addObject:@"6"];
        appDelegate.dirtystartValue=1;
        appDelegate.Dirtyvalue=6;
        appDelegate.dirtystartValueformine=1;
    }
}

#pragma mark popup delegate method
- (void)popupViewControllerDidClose:(NSString*)actionType withResponse:(BOOL)response
{
    
}
//textField delegate methods
#pragma mark - textField delegate methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField 
{
	
    [textField resignFirstResponder];
    
	return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] == 25)
    {
        [txtPlayerName resignFirstResponder];
        strAlertMessage = [[NSString alloc]initWithString:NSLocalizedString(@"Maximum 25 char key", @"")];
        dictAlertMessage = [[NSMutableDictionary alloc] init];
        [dictAlertMessage setObject:strAlertMessage forKey:kPopupMessage];
        [Popup popUpWithMessage:dictAlertMessage delegate:self withType:nil];
        [dictAlertMessage release];
    }
    return YES;
    
}

//Table view delegate methods
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrPlayers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{  
    thisDevice = [UIDevice currentDevice];
    UIImageView *seprator;
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(indexPath.row == 0)
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 768, 6)]; 
        }
        else
        {
            seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 3)];
        }
        [seprator setImage:[UIImage imageNamed:@"divider.png"]];
        [cell addSubview:seprator];
        [seprator release];
    }
    
    UILabel *lbl = [[UILabel alloc] init];
    
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = [arrPlayers objectAtIndex:indexPath.row];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = UITextAlignmentLeft;
    
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        lbl.frame = CGRectMake(10, 15, 600, 60);
        [lbl setFont: [UIFont fontWithName:@"Segoe Print" size:40.0]];          
    }
    else
    {    
        lbl.frame = CGRectMake(5, 5, 212, 40);
        [lbl setFont: [UIFont fontWithName:@"Segoe Print" size:15.0]];
    }
    
    [cell addSubview:lbl];
    [lbl release];
    UIButton *btnGender = [UIButton buttonWithType:UIButtonTypeCustom];
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        btnGender.frame = CGRectMake(((tblPlayer.frame.size.width)-80- 100), 10, 80, 80);
        
        if([[arrPlayersGender objectAtIndex:indexPath.row] isEqualToString:@"Male"])
            [btnGender setImage:[UIImage imageNamed:@"malebtn_iPad.png"] forState:UIControlStateNormal];
        else
            [btnGender setImage:[UIImage imageNamed:@"femalebtn_iPad.png"] forState:UIControlStateNormal];    
    }
    else
    {
        btnGender.frame = CGRectMake(((tblPlayer.frame.size.width)-39- 65), 6, 39, 39);
        
        if([[arrPlayersGender objectAtIndex:indexPath.row] isEqualToString:@"Male"])
            [btnGender setImage:[UIImage imageNamed:@"malebtn.png"] forState:UIControlStateNormal];
        else
            [btnGender setImage:[UIImage imageNamed:@"femalebtn.png"] forState:UIControlStateNormal];
    }
    
    btnGender.tag = indexPath.row;
    [btnGender addTarget:self action:@selector(changeGender:) forControlEvents:UIControlEventTouchUpInside];
    [btnGender setUserInteractionEnabled:YES];
    [cell addSubview:btnGender];
    
    UIButton *btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        btnDelete.frame = CGRectMake(((tblPlayer.frame.size.width)-80-10),10,80,80);
        [btnDelete setImage:[UIImage imageNamed:@"deletebtn_iPad.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        btnDelete.frame = CGRectMake(((tblPlayer.frame.size.width)-39-10),6,39,39);
        [btnDelete setImage:[UIImage imageNamed:@"deletebtn.png"] forState:UIControlStateNormal];
        
    }
    btnDelete.tag = indexPath.row;
    [btnDelete addTarget:self action:@selector(removePlayer:) forControlEvents:UIControlEventTouchUpInside];
    [btnDelete setUserInteractionEnabled:YES];
    [cell addSubview:btnDelete];
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 95, 768, 6)]; 
        
    }
    else
    {
        seprator=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, 320, 3)];
    }
    
    [seprator setImage:[UIImage imageNamed:@"divider.png"]];
    [cell addSubview:seprator];
    [seprator release];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    thisDevice = [UIDevice currentDevice];
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        return 95;
    }
    else
    {
        return 50;
    }
}

//Change Gender method
-(void)changeGender:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"malebtn_iPad.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"femalebtn_iPad.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Female"];
            
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"malebtn_iPad.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Male"];
            
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
        }
        
        
    }
    else
    {
        if([btn.currentImage isEqual:[UIImage imageNamed:@"malebtn.png"]])
        {
            [btn setImage:[UIImage imageNamed:@"femalebtn.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Female"];
            
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
            
        }
        else
        {
            [btn setImage:[UIImage imageNamed:@"malebtn.png"] forState:UIControlStateNormal];
            [arrPlayersGender replaceObjectAtIndex:btn.tag withObject:@"Male"];
            
            NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
            [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
        }
    }
}
//Remove Player method
-(void)removePlayer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    [arrPlayers removeObjectAtIndex:btn.tag];
    [arrPlayersGender removeObjectAtIndex:btn.tag];
    
    NSArray *arrName = [NSArray arrayWithArray:arrPlayers];
    [[UserDefaultSettings sharedSetting] storeArray:arrName withKey:@"Player Name"];
    NSArray *arrGender = [NSArray arrayWithArray:arrPlayersGender];
    [[UserDefaultSettings sharedSetting] storeArray:arrGender withKey:@"Player Gender"];
    [FlurryAnalytics logEvent:@"PlayerRemoved"];
    [tblPlayer reloadData];
    
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}
-(void)dealloc
{
    [arrCustomTruths release];
    [arrCustomDares release];
    self.tblPlayer = nil;
    self.txtPlayerName = nil;
    self.btnAddPlayer = nil;
    
    [arrPlayers release];
    [arrPlayersGender release];
}

@end
