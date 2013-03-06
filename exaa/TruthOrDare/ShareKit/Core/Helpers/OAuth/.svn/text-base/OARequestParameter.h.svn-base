


#import <Foundation/Foundation.h>
#import "NSString+URLEncoding.h"


@interface OARequestParameter : NSObject {
@protected
    NSString *name;
    NSString *value;
}
@property(retain) NSString *name;
@property(retain) NSString *value;

+ (id)requestParameterWithName:(NSString *)aName value:(NSString *)aValue;
- (id)initWithName:(NSString *)aName value:(NSString *)aValue;
- (NSString *)URLEncodedName;
- (NSString *)URLEncodedValue;
- (NSString *)URLEncodedNameValuePair;

@end
