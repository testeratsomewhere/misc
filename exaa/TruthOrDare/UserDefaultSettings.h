

#import <Foundation/Foundation.h>

@interface UserDefaultSettings : NSObject
{
    NSUserDefaults *prefs;
}

+(UserDefaultSettings *)sharedSetting;


-(void)storeDictionary:(NSDictionary *)dictionary withKey:(NSString *)key;
-(NSDictionary *) retrieveDictionary:(NSString *)key;

-(void)storeArray:(NSArray *)array withKey:(NSString *)key;
-(NSArray *)retrieveArray:(NSString *)key;


@end
