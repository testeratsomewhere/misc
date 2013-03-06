




#import "UIView-AlertAnimations.h"
#import <QuartzCore/QuartzCore.h>

#define kAnimationDuration 0.2

@implementation UIView(AlertAnimations)

- (void)doPopInAnimationX {
}

- (void)doPopInAnimationY {
}

////////////////////// scale x ///////////////////////////

- (void)doPopInAnimationXWithDelegate:(id)animationDelegate {
    CALayer *viewLayer = self.layer;
	
	////////////////////// dynamic for x ////////////////////////
	
    CAKeyframeAnimation *popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    
    popInAnimation.duration = kAnimationDuration;
	
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.1],
                             [NSNumber numberWithFloat:1.0],
                             nil];
	
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0], 
                               nil];  
	
    popInAnimation.delegate = self;
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale.x"];  
	
	////////////////////// const for y ////////////////////////
	
	popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    
    popInAnimation.duration = kAnimationDuration;
	
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.1],
                             [NSNumber numberWithFloat:0.1],
                             nil];
	
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0], 
                               nil];  
	
    popInAnimation.delegate = self;
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale.y"];  
}

////////////////////// scale y ///////////////////////////

- (void)doPopInAnimationYWithDelegate:(id)animationDelegate {
    CALayer *viewLayer = self.layer;
	
	////////////////////// dynamic for y ////////////////////////
	
    CAKeyframeAnimation *popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    
    popInAnimation.duration = kAnimationDuration;
	
    popInAnimation.values = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.1],
                             [NSNumber numberWithFloat:1.0],
                             nil];
	
    popInAnimation.keyTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:1.0], 
                               nil];  
	
    [viewLayer addAnimation:popInAnimation forKey:@"transform.scale.y"];  
}

- (void)doFadeInAnimation {
    [self doFadeInAnimationWithDelegate:nil];
}

- (void)doFadeInAnimationWithDelegate:(id)animationDelegate {
    CALayer *viewLayer = self.layer;
    CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeInAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0];
    fadeInAnimation.duration = kAnimationDuration;
    fadeInAnimation.delegate = animationDelegate;
    [viewLayer addAnimation:fadeInAnimation forKey:@"opacity"];
}

#pragma mark CAAnimation Delegate Methods
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
	[self doPopInAnimationY];
}

@end
