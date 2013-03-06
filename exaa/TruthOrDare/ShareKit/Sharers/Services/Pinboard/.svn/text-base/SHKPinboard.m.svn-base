

#import "SHKPinboard.h"


@implementation SHKPinboard



#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return @"Pinboard";
}

+ (BOOL)canShareURL
{
	return YES;
}


#pragma mark -
#pragma mark Authorization

+ (NSString *)authorizationFormCaption
{
	return SHKLocalizedString(@"Create an account at %@", @"http://pinboard.in");
}

- (void)authorizationFormValidate:(SHKFormController *)form
{
	// Display an activity indicator	
	if (!quiet)
		[[SHKActivityIndicator currentIndicator] displayActivity:SHKLocalizedString(@"Logging In...")];
	
	
	// Authorize the user through the server
	NSDictionary *formValues = [form formValues];
	
	self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:
													[NSString stringWithFormat:@"https://%@:%@@api.pinboard.in/v1/posts/get",
													 SHKEncode([formValues objectForKey:@"username"]),
													 SHKEncode([formValues objectForKey:@"password"])
													 ]]
											params:nil
										  delegate:self
								isFinishedSelector:@selector(authFinished:)
											method:@"POST"
										 autostart:YES] autorelease];
	
	self.pendingForm = form;
}

- (BOOL)handleResponse:(SHKRequest *)aRequest
{
	NSString *response = [aRequest getResult];
	
	if ([response isEqualToString:SHKLocalizedString(@"401 Forbidden")])
	{
		[self sendDidFailShouldRelogin];		
		return NO;		
	} 
	
	return YES;
}

- (void)authFinished:(SHKRequest *)aRequest
{	
	// Hide the activity indicator
	[[SHKActivityIndicator currentIndicator] hide];
	
	if ([self handleResponse:aRequest])
	{
		[pendingForm saveForm];
	}
}


#pragma mark -
#pragma mark Share Form

- (NSArray *)shareFormFieldsForType:(SHKShareType)type
{
	if (type == SHKShareTypeURL)
		return [NSArray arrayWithObjects:
				[SHKFormFieldSettings label:SHKLocalizedString(@"Title") key:@"title" type:SHKFormFieldTypeText start:item.title],
				[SHKFormFieldSettings label:SHKLocalizedString(@"Tags") key:@"tags" type:SHKFormFieldTypeText start:item.tags],
				[SHKFormFieldSettings label:SHKLocalizedString(@"Notes") key:@"text" type:SHKFormFieldTypeText start:item.text],
				[SHKFormFieldSettings label:SHKLocalizedString(@"Shared") key:@"shared" type:SHKFormFieldTypeSwitch start:SHKFormFieldSwitchOff],
				nil];
	
	return nil;
}



#pragma mark -
#pragma mark Share API Methods

- (BOOL)send
{	
	if ([self validateItem])
	{			
		self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:
														[NSString stringWithFormat:@"https://%@:%@@api.pinboard.in/v1/posts/add?url=%@&description=%@&tags=%@&extended=%@&shared=%@",
														 SHKEncode([self getAuthValueForKey:@"username"]),
														 SHKEncode([self getAuthValueForKey:@"password"]),
														 SHKEncodeURL(item.URL),
														 SHKEncode(item.title),
														 SHKEncode(item.tags),
														 SHKEncode(item.text),
														 [item customBoolForSwitchKey:@"shared"]?@"yes":@"no"
														 ]]
												params:nil
											  delegate:self
									isFinishedSelector:@selector(sendFinished:)
												method:@"GET"
											 autostart:YES] autorelease];
		
		
		// Notify delegate
		[self sendDidStart];
		
		return YES;
	}
	
	return NO;
}

- (void)sendFinished:(SHKRequest *)aRequest
{	
	if ([self handleResponse:aRequest])
	{
		// TODO parse <result code="MESSAGE" to get response from api for better error message
		
		if ([[aRequest getResult] rangeOfString:@"\"done\""].location != NSNotFound)
		{
			[self sendDidFinish];
			return;
		}
	}
	
	[self sendDidFailWithError:[SHK error:SHKLocalizedString(@"There was an error saving to Pinboard")]];		
}

@end
