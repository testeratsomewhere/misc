

#import <Foundation/Foundation.h>


@interface SHKRequest : NSObject 
{
	NSURL *url;
	NSString *params;
	NSString *method;
	NSDictionary *headerFields;
	
	id delegate;
	SEL isFinishedSelector;
	
	NSURLConnection *connection;
	
	NSHTTPURLResponse *response;
	NSDictionary *headers;
	
	NSMutableData *data;
	NSString *result;
	BOOL success;
}

@property (retain) NSURL *url;
@property (retain) NSString *params;
@property (retain) NSString *method;
@property (retain) NSDictionary *headerFields;

@property (assign) id delegate;
@property (assign) SEL isFinishedSelector;

@property (retain) NSURLConnection *connection;

@property (retain) NSHTTPURLResponse *response;
@property (retain) NSDictionary *headers;

@property (retain) NSMutableData *data;
@property (retain, getter=getResult) NSString *result;
@property (nonatomic) BOOL success;

- (id)initWithURL:(NSURL *)u params:(NSString *)p delegate:(id)d isFinishedSelector:(SEL)s method:(NSString *)m autostart:(BOOL)autostart;

- (void)start;
- (void)finish;


@end
