

#import "FBSession.h"

typedef enum {
  FBLoginButtonStyleNormal,
  FBLoginButtonStyleWide,
} FBLoginButtonStyle;


@interface FBLoginButton : UIControl <FBSessionDelegate> {
  FBLoginButtonStyle _style;
  FBSession* _session;
  UIImageView* _imageView;
}

@property(nonatomic) FBLoginButtonStyle style;


@property(nonatomic,retain) FBSession* session;

@end
