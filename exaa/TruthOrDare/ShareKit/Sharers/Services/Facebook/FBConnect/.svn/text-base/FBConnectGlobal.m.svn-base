

#import "FBConnectGlobal.h"

const NSString* kFB_SDK_VersionNumber = @"iphone/1.3.0";

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

const void* RetainNoOp(CFAllocatorRef allocator, const void *value) { return value; }
void ReleaseNoOp(CFAllocatorRef allocator, const void *value) { }

///////////////////////////////////////////////////////////////////////////////////////////////////
// public

NSMutableArray* FBCreateNonRetainingArray() {
  CFArrayCallBacks callbacks = kCFTypeArrayCallBacks;
  callbacks.retain = RetainNoOp;
  callbacks.release = ReleaseNoOp;
  return (NSMutableArray*)CFArrayCreateMutable(nil, 0, &callbacks);
}


BOOL FBIsDeviceIPad() {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 30200
  if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
    return YES; 
  }
#endif
  return NO;
}
