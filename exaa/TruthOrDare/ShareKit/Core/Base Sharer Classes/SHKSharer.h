
#import <UIKit/UIKit.h>
#import "SHK.h"
#import "SHKCustomFormController.h"
#import "TruthOrDareAppDelegate.h"

@class SHKSharer;

@protocol SHKSharerDelegate

- (void)sharerStartedSending:(SHKSharer *)sharer;
- (void)sharerFinishedSending:(SHKSharer *)sharer;
- (void)sharer:(SHKSharer *)sharer failedWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin;
- (void)sharerCancelledSending:(SHKSharer *)sharer;

@end


typedef enum 
{
	SHKPendingNone,
	SHKPendingShare,
	SHKPendingRefreshToken
} SHKSharerPendingAction;


@interface SHKSharer : UINavigationController <SHKSharerDelegate>
{	
	id shareDelegate;
	
	SHKItem *item;
	SHKFormController *pendingForm;
	SHKRequest *request;
		
	NSError *lastError;
	
	BOOL quiet;
	SHKSharerPendingAction pendingAction;
}

@property (nonatomic, retain)	id<SHKSharerDelegate> shareDelegate;

@property (retain) SHKItem *item;
@property (retain) SHKFormController *pendingForm;
@property (retain) SHKRequest *request;

@property (nonatomic, retain) NSError *lastError;

@property BOOL quiet;
@property SHKSharerPendingAction pendingAction;



#pragma mark -
#pragma mark Configuration : Service Defination

+ (NSString *)sharerTitle;
- (NSString *)sharerTitle;
+ (NSString *)sharerId;
- (NSString *)sharerId;
+ (BOOL)canShareText;
+ (BOOL)canShareURL;
+ (BOOL)canShareImage;
+ (BOOL)canShareFile;
+ (BOOL)shareRequiresInternetConnection;
+ (BOOL)canShareOffline;
+ (BOOL)requiresAuthentication;
+ (BOOL)canShareType:(SHKShareType)type;
+ (BOOL)canAutoShare;


#pragma mark -
#pragma mark Configuration : Dynamic Enable

+ (BOOL)canShare;
- (BOOL)shouldAutoShare;

#pragma mark -
#pragma mark Initialization

- (id)init;


#pragma mark -
#pragma mark Share Item Loading Convenience Methods

+ (id)shareItem:(SHKItem *)i;

+ (id)shareURL:(NSURL *)url;
+ (id)shareURL:(NSURL *)url title:(NSString *)title;

+ (id)shareImage:(UIImage *)image title:(NSString *)title;

+ (id)shareText:(NSString *)text;

+ (id)shareFile:(NSData *)file filename:(NSString *)filename mimeType:(NSString *)mimeType title:(NSString *)title;


#pragma mark -
#pragma mark Commit Share

- (void)share;

#pragma mark -
#pragma mark Authentication

- (BOOL)isAuthorized;
- (BOOL)authorize;
- (void)promptAuthorization;
- (NSString *)getAuthValueForKey:(NSString *)key;

#pragma mark Authorization Form

- (void)authorizationFormShow;
- (void)authorizationFormValidate:(SHKFormController *)form;
- (void)authorizationFormSave:(SHKFormController *)form;
- (NSArray *)authorizationFormFields;
- (NSString *)authorizationFormCaption;
+ (NSArray *)authorizationFormFields;
+ (NSString *)authorizationFormCaption;
+ (void)logout;
+ (BOOL)isServiceAuthorized;

#pragma mark -
#pragma mark API Implementation

- (BOOL)validateItem;
- (BOOL)tryToSend;
- (BOOL)send;

#pragma mark -
#pragma mark UI Implementation

- (void)show;

#pragma mark -
#pragma mark Share Form

- (NSArray *)shareFormFieldsForType:(SHKShareType)type;
- (void)shareFormValidate:(SHKFormController *)form;
- (void)shareFormSave:(SHKFormController *)form;

#pragma mark -
#pragma mark Pending Actions

- (void)tryPendingAction;

#pragma mark -
#pragma mark Delegate Notifications

- (void)sendDidStart;
- (void)sendDidFinish;
- (void)sendDidFailShouldRelogin;
- (void)sendDidFailWithError:(NSError *)error;
- (void)sendDidFailWithError:(NSError *)error shouldRelogin:(BOOL)shouldRelogin;
- (void)sendDidCancel;

@end



