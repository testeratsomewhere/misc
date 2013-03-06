

#import <Foundation/Foundation.h>
#import "SHKOAuthSharer.h"
#import "SHKTwitterForm.h"

@interface SHKTwitter : SHKOAuthSharer 
{	
	BOOL xAuth;		
}

@property BOOL xAuth;


#pragma mark -
#pragma mark UI Implementation

- (void)showTwitterForm;

#pragma mark -
#pragma mark Share API Methods

- (void)shortenURL;
- (void)shortenURLFinished:(SHKRequest *)aRequest;

- (void)sendForm:(SHKTwitterForm *)form;

- (void)sendStatus;
- (void)sendStatusTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)sendStatusTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error;
- (void)sendImage;
- (void)sendImageTicket:(OAServiceTicket *)ticket didFinishWithData:(NSData *)data;
- (void)sendImageTicket:(OAServiceTicket *)ticket didFailWithError:(NSError*)error;

- (void)followMe;

@end
