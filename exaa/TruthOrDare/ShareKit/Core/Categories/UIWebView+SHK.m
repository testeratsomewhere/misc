
#import "UIWebView+SHK.h"

@implementation UIWebView (SHK)

- (NSString *)pageTitle
{
	return [self stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
