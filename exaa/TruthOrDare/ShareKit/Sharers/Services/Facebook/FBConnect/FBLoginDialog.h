
#import "FBDialog.h"
#import "FBRequest.h"

@interface FBLoginDialog : FBDialog <FBRequestDelegate> {
  FBRequest* _getSessionRequest;
}

@end
