

#import <UIKit/UIKit.h>

@class SHKOAuthView;
@class SHKOAuthSharer;

@protocol SHKOAuthViewDelegate

- (void)tokenAuthorizeView:(SHKOAuthView *)authView didFinishWithSuccess:(BOOL)success queryParams:(NSMutableDictionary *)queryParams error:(NSError *)error;
- (void)tokenAuthorizeCancelledView:(SHKOAuthView *)authView;
- (NSURL *)authorizeCallbackURL;

@end


@interface SHKOAuthView : UIViewController <UIWebViewDelegate>
{
	UIWebView *webView;
	id delegate;
	UIActivityIndicatorView *spinner;
}

@property (nonatomic, retain) UIWebView *webView;
@property (retain) id<SHKOAuthViewDelegate> delegate;
@property (nonatomic, retain) UIActivityIndicatorView *spinner;

- (id)initWithURL:(NSURL *)authorizeURL delegate:(id)d;

- (void)startSpinner;
- (void)stopSpinner;

@end
