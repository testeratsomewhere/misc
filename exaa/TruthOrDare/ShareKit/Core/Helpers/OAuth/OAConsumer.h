


#import <Foundation/Foundation.h>


@interface OAConsumer : NSObject {
@protected
	NSString *key;
	NSString *secret;
}
@property(retain) NSString *key;
@property(retain) NSString *secret;

- (id)initWithKey:(NSString *)aKey secret:(NSString *)aSecret;

@end
