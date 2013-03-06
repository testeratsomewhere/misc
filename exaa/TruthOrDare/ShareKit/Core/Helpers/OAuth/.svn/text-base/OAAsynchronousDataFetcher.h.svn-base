

#import <Foundation/Foundation.h>

#import "OAMutableURLRequest.h"

@interface OAAsynchronousDataFetcher : NSObject {
    OAMutableURLRequest *request;
    NSHTTPURLResponse *response;
    NSURLConnection *connection;
    NSMutableData *responseData;
    id delegate;
    SEL didFinishSelector;
    SEL didFailSelector;
}

+ (id)asynchronousFetcherWithRequest:(OAMutableURLRequest *)aRequest delegate:(id)aDelegate didFinishSelector:(SEL)finishSelector didFailSelector:(SEL)failSelector;
- (id)initWithRequest:(OAMutableURLRequest *)aRequest delegate:(id)aDelegate didFinishSelector:(SEL)finishSelector didFailSelector:(SEL)failSelector;

- (void)start;
- (void)cancel;

@end
