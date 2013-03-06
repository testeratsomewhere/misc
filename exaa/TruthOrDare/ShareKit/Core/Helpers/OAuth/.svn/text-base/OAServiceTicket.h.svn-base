

#import <Foundation/Foundation.h>
#import "OAMutableURLRequest.h"


@interface OAServiceTicket : NSObject {
@private
    OAMutableURLRequest *request;
    NSHTTPURLResponse *response;
	NSData *data;
    BOOL didSucceed;
}
@property(readonly) OAMutableURLRequest *request;
@property(readonly) NSHTTPURLResponse *response;
@property(readonly) NSData *data;
@property(readonly) BOOL didSucceed;
@property(readonly) NSString *body;

- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSHTTPURLResponse *)aResponse didSucceed:(BOOL)success;
- (id)initWithRequest:(OAMutableURLRequest *)aRequest response:(NSHTTPURLResponse *)aResponse data:(NSData *)aData didSucceed:(BOOL)success;

@end
