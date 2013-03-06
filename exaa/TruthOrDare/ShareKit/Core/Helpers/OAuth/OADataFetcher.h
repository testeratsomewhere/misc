

#import <Foundation/Foundation.h>
#import "OAMutableURLRequest.h"
#import "OAServiceTicket.h"


@interface OADataFetcher : NSObject {
@private
    OAMutableURLRequest *request;
    NSHTTPURLResponse *response;
    //NSURLConnection *connection;
    NSError *error;
    NSData *responseData;
    id delegate;
    SEL didFinishSelector;
    SEL didFailSelector;
}

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest delegate:(id)aDelegate didFinishSelector:(SEL)finishSelector didFailSelector:(SEL)failSelector;

@end
