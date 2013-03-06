//
//  Mopubclass.h
//  TruthOrDare
//


#import <Foundation/Foundation.h>
#import "MPAdView.h"
@interface Mopubclass : NSObject<MPAdViewDelegate>{
     MPAdView* mpAdView;
//     UIDevice *thisDevice;
}
@property(nonatomic,retain) MPAdView* mpAdView;
//+ (id)sharedInstance;
@end
