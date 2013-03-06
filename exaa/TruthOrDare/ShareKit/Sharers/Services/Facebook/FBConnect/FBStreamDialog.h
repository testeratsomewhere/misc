

#import "FBDialog.h"

@interface FBStreamDialog : FBDialog {
	NSString* _attachment;
	NSString* _actionLinks;
	NSString* _targetId;
	NSString* _userMessagePrompt;
}


@property(nonatomic,copy) NSString* attachment;

@property(nonatomic,copy) NSString* actionLinks;


@property(nonatomic,copy) NSString* targetId;


@property(nonatomic,copy) NSString* userMessagePrompt;

@end
