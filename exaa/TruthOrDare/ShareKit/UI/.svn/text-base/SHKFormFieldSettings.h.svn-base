

#import <Foundation/Foundation.h>

typedef enum 
{
	SHKFormFieldTypeText,
	SHKFormFieldTypePassword,
	SHKFormFieldTypeSwitch
} SHKFormFieldType;

#define SHKFormFieldSwitchOff @"0"
#define SHKFormFieldSwitchOn @"1"

@interface SHKFormFieldSettings : NSObject 
{
	NSString *label;
	NSString *key;
	SHKFormFieldType type;	
	NSString *start;
}

@property (nonatomic, retain) NSString *label;
@property (nonatomic, retain) NSString *key;
@property SHKFormFieldType type;
@property (nonatomic, retain) NSString *start;

+ (id)label:(NSString *)l key:(NSString *)k type:(SHKFormFieldType)t start:(NSString *)s;

@end
