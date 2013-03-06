

#import <UIKit/UIKit.h>
#import <sqlite3.h>
//#import "PlayViewController.h"
#import "FlurryAnalytics.h"
#import <Heyzap/Heyzap.h>
@class PlayViewController;
//@class MPInterstitialAdController;
@interface TruthOrDareAppDelegate : NSObject <UIApplicationDelegate>
{
    UINavigationController *navigationController;
    sqlite3 *database;
    sqlite3 *databaseOLD;
    
    BOOL flgUpdate;
    
    int playerCount;
    
    NSMutableArray *arrDelegateMaleTruth;
    NSMutableArray *arrDelegateMaleDare;
    NSMutableArray *arrDelegateFemaleTruth;
    NSMutableArray *arrDelegateFemaleDare;
    NSInteger Changesettingint;
    UIActivityIndicatorView *objactivity;
    NSMutableArray *arrayDirtyness;
    
    int dirtinessLevel;
    BOOL flagfilter;
    
    NSMutableArray *arrMaleTruthChallengeId;
    NSMutableArray *arrFemaleTruthChallengeId;
    NSMutableArray *arrMaleDareChallengeId;
    NSMutableArray *arrFemaleDareChallengeId;
    NSMutableArray *arrDirtinesNumber;
    NSMutableArray *arrFacedDare;
    int roundCount;
    
    NSString *strCurrentPlayerName;
    NSString *strCurrentPlayerGender;
    NSInteger dirtystartValue;
    NSInteger dirtystartValueformine;
    NSMutableArray *speedCountArray;
    
    NSMutableArray *stackArr;
    NSMutableArray *stackGenderArr;
    NSMutableArray *usedGender;
    BOOL changedirtiness;
    NSMutableArray *playerDetailsArray;
    NSInteger Dirtyvalue;
    
    UIDevice *thisDevice;
    
}
@property(nonatomic)NSInteger Changesettingint;
@property(nonatomic)NSInteger dirtystartValueformine;
@property(nonatomic)NSInteger Dirtyvalue;
@property(nonatomic,readwrite)BOOL changedirtiness;
@property(nonatomic,retain)NSMutableArray *speedCountArray;
@property(nonatomic) NSInteger dirtystartValue;
@property (nonatomic,retain) NSMutableArray *playerDetailsArray;
@property(nonatomic,retain) UIActivityIndicatorView *objactivity;
@property (nonatomic) sqlite3 *database;
@property (nonatomic) sqlite3 *databaseOLD;
@property (nonatomic, retain) UINavigationController *navigationController;
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, readwrite) BOOL flgUpdate;
@property (nonatomic, retain) NSMutableArray *arrDelegateMaleTruth;
@property (nonatomic, retain) NSMutableArray *arrDirtinesNumber;
@property (nonatomic, retain) NSMutableArray *arrDelegateMaleDare;
@property (nonatomic, retain) NSMutableArray *arrDelegateFemaleTruth;
@property (nonatomic, retain) NSMutableArray *arrDelegateFemaleDare;
@property (nonatomic, readwrite) int playerCount;
@property(nonatomic,retain)NSMutableArray *arrayDirtyness;
@property (nonatomic, readwrite) int dirtinessLevel;
@property (nonatomic, readwrite) BOOL flagfilter;

@property (nonatomic, retain) NSMutableArray *arrMaleTruthChallengeId;
@property (nonatomic, retain) NSMutableArray *arrFemaleTruthChallengeId;
@property (nonatomic, retain) NSMutableArray *arrMaleDareChallengeId;
@property (nonatomic, retain) NSMutableArray *arrFemaleDareChallengeId;
@property (nonatomic, retain) NSMutableArray *arrFacedDare;
@property (nonatomic, readwrite) int roundCount;

@property (nonatomic, retain) NSString *strCurrentPlayerName;
@property (nonatomic, retain) NSString *strCurrentPlayerGender;
@property (nonatomic, retain) NSMutableArray *usedGender;

@property (nonatomic, retain) NSMutableArray *stackArr;
@property (nonatomic, retain) NSMutableArray *stackGenderArr;

@property (nonatomic, readwrite)int changeLang;


void uncaughtExceptionHandler(NSException *exception);


@end
