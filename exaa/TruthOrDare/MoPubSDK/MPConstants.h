//
//  MPConstants.h
//  MoPub
//
//  Created by Nafis Jamal on 2/9/11.
//  Copyright 2011 MoPub, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MP_DEBUG_MODE				1

#define HOSTNAME					@"ads.mopub.com"
#define DEFAULT_PUB_ID				@"agltb3B1Yi1pbmNyDAsSBFNpdGUYkaoMDA"
#define MP_SDK_VERSION              @"1.9.0.0"
#define Appkey @"agltb3B1Yi1pbmNyDQsSBFNpdGUY39npFAw" 
#define Appipadkey @"agltb3B1Yi1pbmNyDQsSBFNpdGUY6YekFQw"
 
// Sizing constants.
#define MOPUB_BANNER_SIZE			CGSizeMake(320, 50)
#define MOPUB_MEDIUM_RECT_SIZE		CGSizeMake(300, 250)
#define MOPUB_LEADERBOARD_SIZE		CGSizeMake(728, 90)
#define MOPUB_WIDE_SKYSCRAPER_SIZE	CGSizeMake(160, 600)

// Miscellaneous constants.
#define MINIMUM_REFRESH_INTERVAL	5.0

// In-app purchase constants.
#define STORE_RECEIPT_SUFFIX		@"/m/purchase"

// Constant for conditional compilation of -[UIDevice uniqueIdentifier] (UDID). The SDK will never
// utilize -[UIDevice uniqueIdentifier] if this value is set to 0.
#define MOPUB_ENABLE_UDID           1
