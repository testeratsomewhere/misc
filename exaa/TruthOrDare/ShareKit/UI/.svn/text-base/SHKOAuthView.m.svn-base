

#import "SHKOAuthView.h"
#import "SHK.h"
#import "SHKOAuthSharer.h"

@implementation SHKOAuthView

@synthesize webView, delegate, spinner;

- (void)dealloc
{
	[webView release];
	[delegate release];
	[spinner release];
	[super dealloc];
}

- (id)initWithURL:(NSURL *)authorizeURL delegate:(id)d
{
    if ((self = [super initWithNibName:nil bundle:nil])) 
	{
		[self.navigationItem setLeftBarButtonItem:[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
																								  target:self
																								  action:@selector(cancel)] autorelease] animated:NO];
		
		self.delegate = d;
		
		self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
		webView.delegate = self;
		webView.scalesPageToFit = YES;
		webView.dataDetectorTypes = UIDataDetectorTypeNone;
		[webView release];
		
		[webView loadRequest:[NSURLRequest requestWithURL:authorizeURL]];		
		
    }
    return self;
}

- (void)loadView 
{ 	
	self.view = webView;
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
	
	// Remove the SHK view wrapper from the window
	[[SHK currentHelper] viewWasDismissed];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{		
	if ([request.URL.absoluteString rangeOfString:[delegate authorizeCallbackURL].absoluteString].location != NSNotFound)
	{
		// Get query
		NSMutableDictionary *queryParams = nil;
		if (request.URL.query != nil)
		{
			queryParams = [NSMutableDictionary dictionaryWithCapacity:0];
			NSArray *vars = [request.URL.query componentsSeparatedByString:@"&"];
			NSArray *parts;
			for(NSString *var in vars)
			{
				parts = [var componentsSeparatedByString:@"="];
				if (parts.count == 2)
					[queryParams setObject:[parts objectAtIndex:1] forKey:[parts objectAtIndex:0]];
			}
		}
		
		[delegate tokenAuthorizeView:self didFinishWithSuccess:YES queryParams:queryParams error:nil];
		self.delegate = nil;
		
		return NO;
	}
	
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self startSpinner];
}

- (void)webViewDidFinishLoad:(UIWebView *)aWebView
{	
	[self stopSpinner];
	
	// Extra sanity check for Twitter OAuth users to make sure they are using BROWSER with a callback instead of pin based auth
	if ([webView.request.URL.host isEqualToString:@"twitter.com"] && [webView stringByEvaluatingJavaScriptFromString:@"document.getElementById('oauth_pin').innerHTML"].length)
		[delegate tokenAuthorizeView:self didFinishWithSuccess:NO queryParams:nil error:[SHK error:@"Your SHKTwitter config is incorrect.  You must set your application type to Browser and define a callback url.  See SHKConfig.h for more details"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{	
	if ([error code] != NSURLErrorCancelled && [error code] != 102 && [error code] != NSURLErrorFileDoesNotExist)
	{
		[self stopSpinner];
		[delegate tokenAuthorizeView:self didFinishWithSuccess:NO queryParams:nil error:error];
	}
}

- (void)startSpinner
{
	if (spinner == nil)
	{
		self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[self.navigationItem setRightBarButtonItem:[[[UIBarButtonItem alloc] initWithCustomView:spinner] autorelease] animated:NO];
		spinner.hidesWhenStopped = YES;
		[spinner release];
	}
	
	[spinner startAnimating];
}

- (void)stopSpinner
{
	[spinner stopAnimating];	
}


#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return YES;
}

- (void)cancel
{
	[delegate tokenAuthorizeCancelledView:self];
	[[SHK currentHelper] hideCurrentViewControllerAnimated:YES];
}

@end
