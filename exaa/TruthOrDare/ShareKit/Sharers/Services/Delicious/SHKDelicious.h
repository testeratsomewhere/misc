

#import <Foundation/Foundation.h>
#import "SHKOAuthSharer.h"

@interface SHKDelicious : SHKOAuthSharer 
{

}

- (BOOL)handleResponse:(SHKRequest *)aRequest;

- (void)sendTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)sendTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error;

@end
