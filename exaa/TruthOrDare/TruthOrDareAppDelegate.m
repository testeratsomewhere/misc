

#import "TruthOrDareAppDelegate.h"
#import "RootViewController.h"
#import "FlurryAnalytics.h"
#import "TapjoyConnect.h"
#import "UserDefaultSettings.h"
#import "MPAdConversionTracker.h"
@implementation TruthOrDareAppDelegate

@synthesize window = _window;
@synthesize navigationController;

@synthesize database;
@synthesize databaseOLD;
@synthesize flgUpdate;
@synthesize arrDelegateMaleTruth, arrDelegateMaleDare, arrDelegateFemaleTruth, arrDelegateFemaleDare;
@synthesize playerCount;
@synthesize objactivity;
@synthesize arrayDirtyness;
@synthesize dirtinessLevel;
@synthesize flagfilter;
@synthesize strCurrentPlayerGender, strCurrentPlayerName;
@synthesize arrMaleTruthChallengeId, arrFemaleTruthChallengeId, arrFemaleDareChallengeId, arrMaleDareChallengeId, arrFacedDare;
@synthesize arrDirtinesNumber;
@synthesize roundCount;
@synthesize stackArr;
@synthesize stackGenderArr;
@synthesize usedGender;
@synthesize playerDetailsArray;
@synthesize dirtystartValue;
@synthesize speedCountArray;
@synthesize changedirtiness;
@synthesize Dirtyvalue;
@synthesize dirtystartValueformine;
@synthesize Changesettingint;
@synthesize changeLang;

#pragma mark Uncaught exception handler
void uncaughtExceptionHandler(NSException *exception)
{
    [FlurryAnalytics logError:@"Uncaught Exception"
                      message:[exception name]
                    exception:exception];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    

    [[MPAdConversionTracker sharedConversionTracker] reportApplicationOpenForApplicationID:@"agltb3B1Yi1pbmNyCwsSA0FwcBii-wsM"];
    NSString * language = [[NSLocale preferredLanguages] objectAtIndex:0];
   NSLog(@"%@", language);
    NSLog(@"%@", CurrentLang);
    if(![CurrentLang isEqualToString:@"en"] && ![CurrentLang isEqualToString:@"fr"] && ![CurrentLang isEqualToString:@"de"] &&  ![CurrentLang isEqualToString:@"es"])
    {        
        NSArray *arr = [NSArray arrayWithObjects:@"en", @"de", @"es", @"fr", nil];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"AppleLanguages"];
        
    }
 
    
    
    changeLang = 1;
    [FlurryAnalytics startSession:@"C2W8YCL8GPAUN6PVT2FW"];
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    [FlurryAnalytics logAllPageViews:navigationController];
    [TapjoyConnect requestTapjoyConnect:@"0dedddc7-8cb0-4dc4-9276-9fd9215b73c2" secretKey:@"yHxT1bmXe4854CIaKhAY"];
    changedirtiness=NO;
    Changesettingint=1;
    objactivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    objactivity.frame = CGRectMake(round((self.window.frame.size.width - 25) / 2), round((self.window.frame.size.height - 25) / 2), 25, 25);
    objactivity.hidesWhenStopped = YES;
    
    navigationController = [[UINavigationController alloc] init];
    [self.window addSubview:navigationController.view];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    thisDevice = [UIDevice currentDevice];
    RootViewController *rootObject;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        rootObject = [[RootViewController alloc] initWithNibName:@"RootViewController_iPad" bundle:nil];
        
    }
    else{
        rootObject = [[RootViewController alloc] initWithNibName:@"RootViewController" bundle:nil];
    }
    [self.navigationController pushViewController:rootObject animated:YES];
    [rootObject release];
    
    flgUpdate = FALSE;
    playerCount = 0;
    arrDelegateMaleTruth = [[NSMutableArray alloc] init];
    arrDelegateMaleDare = [[NSMutableArray alloc] init];
    arrDelegateFemaleTruth = [[NSMutableArray alloc] init];
    arrDelegateFemaleDare = [[NSMutableArray alloc] init];
    arrayDirtyness=[[NSMutableArray alloc]init];
    dirtinessLevel = 0;
    arrDirtinesNumber=[[NSMutableArray alloc]init];
    roundCount = 0;
    arrFemaleTruthChallengeId = [[NSMutableArray alloc] init];
    arrMaleTruthChallengeId = [[NSMutableArray alloc] init];
    arrFemaleDareChallengeId = [[NSMutableArray alloc] init];
    arrMaleDareChallengeId = [[NSMutableArray alloc] init];    
    
    arrFacedDare = [[NSMutableArray alloc] init];
    
    strCurrentPlayerGender = [[NSString alloc] init];
    strCurrentPlayerName = [[NSString alloc] init];
    stackArr = [[NSMutableArray alloc] init];
    stackGenderArr = [[NSMutableArray alloc] init];
    return YES;
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
}

#pragma mark database methods

- (void)dealloc
{
    self.playerDetailsArray = nil;
    [arrDelegateMaleTruth release]; 
    [arrDelegateMaleDare release]; 
    [arrDelegateFemaleTruth release]; 
    [arrDelegateFemaleDare release]; 
    [arrayDirtyness release];
    
    [arrFemaleTruthChallengeId release];
    [arrMaleTruthChallengeId release];
    [arrFacedDare release];
    
    [strCurrentPlayerName release];
    [strCurrentPlayerGender release];
    
    [arrMaleDareChallengeId release];
    [arrFemaleDareChallengeId release];
    [stackArr release];
    [stackGenderArr release];
    [usedGender release];
    
	[super dealloc];
}



@end
