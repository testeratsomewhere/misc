
#import "FBStreamDialog.h"
#import "FBSession.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kStreamURL = @"http://www.facebook.com/connect/prompt_feed.php";

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FBStreamDialog

@synthesize attachment        = _attachment,
		    actionLinks       = _actionLinks,
            targetId          = _targetId,
            userMessagePrompt = _userMessagePrompt;

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithSession:(FBSession*)session {
	if (self = [super initWithSession:session]) {
		_attachment        = @"";
		_actionLinks       = @"";
		_targetId          = @"";
		_userMessagePrompt = @"";
	}
	return self;
}

- (void)dealloc {
	[_attachment        release];
	[_actionLinks       release];
	[_targetId          release];
	[_userMessagePrompt release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialog

- (void)load {
	NSDictionary* getParams = [NSDictionary dictionaryWithObjectsAndKeys:
							   @"touch", @"display", nil];
	
	NSDictionary* postParams = [NSDictionary dictionaryWithObjectsAndKeys:
								_session.apiKey,      @"api_key",
								_session.sessionKey,  @"session_key",
								@"1",                 @"preview",
								@"fbconnect:success", @"callback",
								@"fbconnect:cancel",  @"cancel",
								_attachment,          @"attachment",
								_actionLinks,         @"action_links",
								_targetId,            @"target_id",
								_userMessagePrompt,   @"user_message_prompt",
								nil];
	
	[self loadURL:kStreamURL method:@"POST" get:getParams post:postParams];
}

@end
