

#import <Foundation/Foundation.h>
#import "SHKSharer.h"
#import "FBConnect.h"

typedef enum 
{
	SHKFacebookPendingNone,
	SHKFacebookPendingLogin,
	SHKFacebookPendingStatus,
	SHKFacebookPendingImage
} SHKFacebookPendingAction;


@interface SHKFacebook : SHKSharer <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate>
{
	FBSession *session;
	SHKFacebookPendingAction pendingFacebookAction;
	FBLoginDialog *login;
}

@property (retain) FBSession *session;
@property SHKFacebookPendingAction pendingFacebookAction;
@property (retain) FBLoginDialog *login;

@end
