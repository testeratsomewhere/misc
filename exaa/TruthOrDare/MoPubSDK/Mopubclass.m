//
//  Mopubclass.m
//  TruthOrDare
//


#import "Mopubclass.h"

@implementation Mopubclass
@synthesize mpAdView;
static Mopubclass *sharedInstance = nil;

+ (Mopubclass *)sharedInstance {
    UIDevice *thisDevice = [UIDevice currentDevice];
    if (sharedInstance == nil) {
        sharedInstance =[[Mopubclass alloc] init];
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
                sharedInstance.mpAdView = [[MPAdView alloc] initWithAdUnitId:Appipadkey size:MOPUB_LEADERBOARD_SIZE];

        }
        else{
                sharedInstance.mpAdView = [[MPAdView alloc] initWithAdUnitId:Appkey size:MOPUB_BANNER_SIZE];


        }
       
    }
    
    return sharedInstance;
}




-(void)dealloc
{
    [mpAdView release];
    [super dealloc];
}
@end
