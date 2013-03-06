

#import "SHKReadItLater.h"


@implementation SHKReadItLater


#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle
{
	return @"Read It Later";
}

+ (BOOL)canShareURL
{
	return YES;
}


#pragma mark -
#pragma mark Configuration : Dynamic Enable

// Though manual sharing is supported (by changing removing this subclass), one tap to save is the ideal 'read later' behavior
- (BOOL)shouldAutoShare
{
	return YES; 
}



#pragma mark -
#pragma mark Authorization

+ (NSString *)authorizationFormCaption
{
	return SHKLocalizedString(@"Create a free account at %@", @"Readitlaterlist.com");
}

- (void)authorizationFormValidate:(SHKFormController *)form
{
	// Display an activity indicator
	if (!quiet)
		[[SHKActivityIndicator currentIndicator] displayActivity:SHKLocalizedString(@"Logging In...")];
	
	
	// Authorize the user through the server
	NSDictionary *formValues = [form formValues];
	
	NSString *params = [NSMutableString stringWithFormat:@"apikey=%@&username=%@&password=%@",
						SHKReadItLaterKey,
						SHKEncode([formValues objectForKey:@"username"]),
						SHKEncode([formValues objectForKey:@"password"])
						];
	
	self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:@"http://readitlaterlist.com/v2/auth"]
								 params:params
							   delegate:self
					 isFinishedSelector:@selector(authFinished:)
								 method:@"POST"
							  autostart:YES] autorelease];
	
	self.pendingForm = form;
}

- (void)authFinished:(SHKRequest *)aRequest
{		
	// Hide the activity indicator
	[[SHKActivityIndicator currentIndicator] hide];
	
	if (aRequest.success)
		[pendingForm saveForm];
	
	else
	{
		[[[[UIAlertView alloc] initWithTitle:SHKLocalizedString(@"Login Error")
									 message:[request.headers objectForKey:@"X-Error"]
									delegate:nil
						   cancelButtonTitle:SHKLocalizedString(@"Close")
						   otherButtonTitles:nil] autorelease] show];
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
				nil];
	
	return nil;
}


#pragma mark -
#pragma mark Share API Methods

- (BOOL)send
{		
	if ([self validateItem])
	{	
		NSString *new = [NSString stringWithFormat:@"&new={\"0\":{\"url\":\"%@\",\"title\":\"%@\"}}",
						 SHKEncodeURL(item.URL),
						 SHKEncode(item.title)];
		
		NSString *tags = item.tags == nil || !item.tags.length ? @"" :
		[NSString stringWithFormat:@"&update_tags={\"0\":{\"url\":\"%@\",\"tags\":\"%@\"}}",
						  SHKEncodeURL(item.URL), SHKEncode(item.tags)];
		
		NSString *params = [NSMutableString stringWithFormat:@"apikey=%@&username=%@&password=%@%@%@",
									SHKReadItLaterKey,
							SHKEncode([self getAuthValueForKey:@"username"]),
							SHKEncode([self getAuthValueForKey:@"password"]),
							new,
							tags];
		
		self.request = [[[SHKRequest alloc] initWithURL:[NSURL URLWithString:@"http://readitlaterlist.com/v2/send"]
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
	if (!aRequest.success)
	{
		if (aRequest.response.statusCode == 401)
		{
			[self sendDidFailShouldRelogin];
			return;
		}
		
		[self sendDidFailWithError:[SHK error:[request.headers objectForKey:@"X-Error"]]];
		return;
	}

	[self sendDidFinish];
}



@end
