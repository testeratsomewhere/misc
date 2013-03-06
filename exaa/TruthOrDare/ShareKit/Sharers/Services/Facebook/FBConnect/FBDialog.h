

#import "FBConnectGlobal.h"

@protocol FBDialogDelegate;
@class FBSession;

@interface FBDialog : UIView <UIWebViewDelegate> {
  id<FBDialogDelegate> _delegate;
  FBSession* _session;
  NSURL* _loadingURL;
  UIWebView* _webView;
  UIActivityIndicatorView* _spinner;
  UIImageView* _iconView;
  UILabel* _titleLabel;
  UIButton* _closeButton;
  UIDeviceOrientation _orientation;
  BOOL _showingKeyboard;
}


@property(nonatomic,assign) id<FBDialogDelegate> delegate;


@property(nonatomic,assign) FBSession* session;


@property(nonatomic,copy) NSString* title;


- (id)initWithSession:(FBSession*)session;


- (void)show;


- (void)load;


- (void)loadURL:(NSString*)url method:(NSString*)method get:(NSDictionary*)getParams
        post:(NSDictionary*)postParams;


- (void)dismissWithSuccess:(BOOL)success animated:(BOOL)animated;


- (void)dismissWithError:(NSError*)error animated:(BOOL)animated;


- (void)dialogWillAppear;


- (void)dialogWillDisappear;

- (void)dialogDidSucceed:(NSURL*)url;

@end

///////////////////////////////////////////////////////////////////////////////////////////////////

@protocol FBDialogDelegate <NSObject>

@optional

- (void)dialogDidSucceed:(FBDialog*)dialog;


- (void)dialogDidCancel:(FBDialog*)dialog;


- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError*)error;

- (BOOL)dialog:(FBDialog*)dialog shouldOpenURLInExternalBrowser:(NSURL*)url;

@end
