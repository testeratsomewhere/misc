

#import "FBLoginDialog.h"

@interface FBPermissionDialog : FBLoginDialog {
  NSString* _permission;
  NSTimer* _redirectTimer;
}


@property(nonatomic,copy) NSString* permission;

@end
