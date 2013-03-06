

#import "SHKInstapaper.h"

static NSString * const kInstapaperAuthenticationURL = @"https://www.instapaper.com/api/authenticate";
static NSString * const kInstapaperSharingURL = @"https://www.instapaper.com/api/add";

@implementation SHKInstapaper

#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return @"Instapaper";
}

+ (BOOL)canShareURL
{
	return YES;
}

#pragma mark -
#pragma mark Configuration : Dynamic Enable

+ (BOOL)canShare
{
	return YES;
}

#pragma mark -
#pragma mark Authorization

+ (NSString *)authorizationFormCaption
{
	return SHKLocalizedString(@"Create a free account at %@", @"Instapaper.com");
}

- (void)authorizationFormValidate:(SHKFormController *)form
{
	// Display an activity indicator
	if (!quiet)
		[[SHKActivityIndicator currentIndicator] displayActivity:SHKLocalizedString(@"Logging In...")];
	
	
	// Authorize the user through the server
	NSDictionary *formValues = [form formValues];
	
	NSString *params = [NSMutableString stringWithFormat:@"username=%@&password=%@",
                       SHKEncode([formValues objectForKey:@"username"]),
                       SHKEncode([formValues objectForKey:@"password"])
                       ];
	
	self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:kInstapaperAuthenticationURL]
                                           params:params
                                         delegate:self
                               isFinishedSelector:@selector(authFinished:)
                                           method:@"POST"
                                        autostart:YES] autorelease];
	
	self.pendingForm = form;
}

- (void)authFinished:(SHKRequest *)aRequest
{		
	[[SHKActivityIndicator currentIndicator] hide];
	
	if (aRequest.success)
		[pendingForm saveForm];
	
	else {
    NSString *errorMessage = nil;
    if (aRequest.response.statusCode == 403)
      errorMessage = SHKLocalizedString(@"Sorry, Instapaper did not accept your credentials. Please try again.");
    else
      errorMessage = SHKLocalizedString(@"Sorry, Instapaper encountered an error. Please try again.");
      
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"Login Error")
                                 message:errorMessage
                                delegate:nil
                       cancelButtonTitle:SHKLocalizedString(@"Close")
                       otherButtonTitles:nil] autorelease] show];
	}
}

#pragma mark -
#pragma mark Share Form

- (NSArray *)shareFormFieldsForType:(SHKShareType)type
{
  // Instapaper will automatically obtain a title for the URL, so we do not need
  // any other information.
	return nil;
}

#pragma mark -
#pragma mark Share API Methods

- (BOOL)send
{		
	if ([self validateItem]) {	
		NSString *params = [NSMutableString stringWithFormat:@"url=%@&username=%@&password=%@",
                         SHKEncodeURL(self.item.URL),
                         SHKEncode([self getAuthValueForKey:@"username"]),
                         SHKEncode([self getAuthValueForKey:@"password"])];
		
		self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:kInstapaperSharingURL]
                                             params:params
                                           delegate:self
                                 isFinishedSelector:@selector(sendFinished:)
                                             method:@"POST"
                                          autostart:YES] autorelease];
		
		// Notify delegate
		[self sendDidStart];
		
		return YES;
	}
	
	return NO;
}

- (void)sendFinished:(SHKRequest *)aRequest
{
	if (!aRequest.success) {
		if (aRequest.response.statusCode == 403) {
			[self sendDidFailWithError:[SHK error:SHKLocalizedString(@"Sorry, Instapaper did not accept your credentials. Please try again.")] shouldRelogin:YES];
			return;
		}
    else if (aRequest.response.statusCode == 500) {		
      [self sendDidFailWithError:[SHK error:SHKLocalizedString(@"The service encountered an error. Please try again later.")]];
      return;
    }
    
		[self sendDidFailWithError:[SHK error:SHKLocalizedString(@"There was a problem saving to Instapaper.")]];
		return;
	}
  
	[self sendDidFinish];
}

@end
