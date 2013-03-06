

#import <Foundation/Foundation.h>
#import "SHK.h"
#import "SHKSharer.h"

@interface SHKOfflineSharer : NSOperation <SHKSharerDelegate>
{
	SHKItem *item;
	NSString *sharerId;
	NSString *uid;
	BOOL readyToFinish;
	NSThread *runLoopThread;
	SHKSharer *sharer;
}

@property (nonatomic, retain) SHKItem *item;
@property (nonatomic, retain) NSString *sharerId;
@property (nonatomic, retain) NSString *uid;
@property BOOL readyToFinish;
@property (nonatomic, retain) NSThread *runLoopThread;
@property (nonatomic, retain) SHKSharer *sharer;

- (id)initWithItem:(SHKItem *)i forSharer:(NSString *)s uid:(NSString *)u;

- (void)share;
- (BOOL)shouldRun;
- (void)finish;
- (void)lastSpin;

@end
