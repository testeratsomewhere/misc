

#import <Foundation/Foundation.h>

typedef enum 
{
	SHKShareTypeUndefined,
	SHKShareTypeURL,
	SHKShareTypeText,
	SHKShareTypeImage,
	SHKShareTypeFile
} SHKShareType;


@interface SHKItem : NSObject 
{	
	SHKShareType shareType;
	
	NSURL *URL;
	
	UIImage *image;
	
	NSString *title;
	NSString *text;
	NSString *tags;
	
	NSData *data;
	NSString *mimeType;
	NSString *filename;
	
	@private
		NSMutableDictionary *custom;
}

@property (nonatomic)			SHKShareType shareType;

@property (nonatomic, retain)	NSURL *URL;

@property (nonatomic, retain)	UIImage *image;

@property (nonatomic, retain)	NSString *title;
@property (nonatomic, retain)	NSString *text;
@property (nonatomic, retain)	NSString *tags;

@property (nonatomic, retain)	NSData *data;
@property (nonatomic, retain)	NSString *mimeType;
@property (nonatomic, retain)	NSString *filename;

+ (SHKItem *)URL:(NSURL *)url title:(NSString *)title;
+ (SHKItem *)image:(UIImage *)image title:(NSString *)title;
+ (SHKItem *)text:(NSString *)text;
+ (SHKItem *)file:(NSData *)data filename:(NSString *)filename mimeType:(NSString *)mimeType title:(NSString *)title;

- (void)setCustomValue:(NSString *)value forKey:(NSString *)key;
- (NSString *)customValueForKey:(NSString *)key;
- (BOOL)customBoolForSwitchKey:(NSString *)key;

- (NSDictionary *)dictionaryRepresentation;
+ (SHKItem *)itemFromDictionary:(NSDictionary *)dictionary;

@end
