

#import "FBFeedDialog.h"
#import "FBSession.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
// global

static NSString* kFeedURL = @"http://www.facebook.com/connect/prompt_feed.php";

///////////////////////////////////////////////////////////////////////////////////////////////////

@implementation FBFeedDialog

@synthesize templateBundleId = _templateBundleId, templateData = _templateData,
  bodyGeneral = _bodyGeneral;

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

- (NSString*)generateFeedInfo {
  NSMutableArray* pairs = [NSMutableArray array];
  
  if (_templateBundleId) {
    [pairs addObject:[NSString stringWithFormat:@"\"template_id\": %lld", _templateBundleId]];
  }
  if (_templateData) {
    [pairs addObject:[NSString stringWithFormat:@"\"template_data\": %@", _templateData]];
  }
  if (_bodyGeneral) {
    [pairs addObject:[NSString stringWithFormat:@"\"body_general\": \"%@\"", _bodyGeneral]];
  }
  
  return [NSString stringWithFormat:@"{%@}", [pairs componentsJoinedByString:@","]];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (id)initWithSession:(FBSession*)session {
  if (self = [super initWithSession:session]) {
    _templateBundleId = 0;
    _templateData = nil;
    _bodyGeneral = nil;
  }
  return self;
}

- (void)dealloc {
  [_templateData release];
  [_bodyGeneral release];
  [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialog

- (void)load {
  NSDictionary* getParams = [NSDictionary dictionaryWithObjectsAndKeys:
    @"touch", @"display", nil];

  NSString* feedInfo = [self generateFeedInfo];
  NSDictionary* postParams = [NSDictionary dictionaryWithObjectsAndKeys:
    _session.apiKey, @"api_key", _session.sessionKey, @"session_key",
    @"1", @"preview", @"fbconnect:success", @"callback", @"fbconnect:cancel", @"cancel", 
    feedInfo, @"feed_info", @"self_feed", @"feed_target_type", nil];

  [self loadURL:kFeedURL method:@"POST" get:getParams post:postParams];
}

@end
