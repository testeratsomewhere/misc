

#import "FBConnectGlobal.h"

@interface FBXMLHandler : NSObject {
  NSMutableArray* _stack;
  NSMutableArray* _nameStack;
  id _rootObject;
  NSString* _rootName;
  NSMutableString* _chars;
  NSError* _parseError;
}

@property(nonatomic,readonly) id rootObject;
@property(nonatomic,readonly) NSString* rootName;
@property(nonatomic,readonly) NSError* parseError;

@end
