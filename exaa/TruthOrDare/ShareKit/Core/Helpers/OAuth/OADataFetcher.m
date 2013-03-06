


#import "OADataFetcher.h"


@implementation OADataFetcher

- (void)fetchDataWithRequest:(OAMutableURLRequest *)aRequest 
					delegate:(id)aDelegate 
		   didFinishSelector:(SEL)finishSelector 
			 didFailSelector:(SEL)failSelector 
{
    request = aRequest;
    delegate = aDelegate;
    didFinishSelector = finishSelector;
    didFailSelector = failSelector;
    
    [request prepare];
    
    responseData = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
	
    if (response == nil || responseData == nil || error != nil) {
        OAServiceTicket *ticket= [[OAServiceTicket alloc] initWithRequest:request
                                                                 response:response
                                                               didSucceed:NO];
        [delegate performSelector:didFailSelector
                       withObject:ticket
                       withObject:error];
    } else {
        OAServiceTicket *ticket = [[OAServiceTicket alloc] initWithRequest:request
                                                                  response:response
                                                                didSucceed:[(NSHTTPURLResponse *)response statusCode] < 400];
        [delegate performSelector:didFinishSelector
                       withObject:ticket
                       withObject:responseData];
    }   
}

@end
