
#import "SettingsSegmentCustomCell.h"

@implementation SettingsSegmentCustomCell

@synthesize segmentedControl;
@synthesize lbl;
@synthesize delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    thisDevice = [UIDevice currentDevice];
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        segmentedControl = [[UISegmentedControl alloc] initWithItems:
                            [NSArray arrayWithObjects:NSLocalizedString(@"On", @""),NSLocalizedString(@"Off", @""),nil]]; 
        
        [segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            segmentedControl.frame = CGRectMake(490, 22, 250, 50);
        }
        else
        {
            segmentedControl.frame = CGRectMake(210, 8, 100, 30);
        }
        segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
        
        [self.contentView addSubview:segmentedControl];
        
        for(UIView* v in self.contentView.subviews)
        {
            if([v isKindOfClass:[UISegmentedControl class]])
            {
                UISegmentedControl* btn = (UISegmentedControl*)v;
                [btn setExclusiveTouch:YES];
            }
        }
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(10, 18, 450, 60)];
        }
        else
        {
            lbl=[[UILabel alloc]initWithFrame:CGRectMake(8,5, 240, 37)];
        }
        lbl.backgroundColor=[UIColor clearColor];
        lbl.textColor=[UIColor whiteColor];
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:35.0];
        }
        else
        {
            lbl.font=[UIFont fontWithName:@"SegoePrint-Bold" size:16.0];
        }
        [self.contentView addSubview:lbl];
    }
    return self;
}
// segmenControl Delegate method
-(void)segmentAction:(id)sender
{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
       
    }
    else
    {
        for (id segment in [segmentedControl subviews]) 
        {
            for (id label in [segment subviews]) 
            {
                if ([label isKindOfClass:[UILabel class]])
                {
                    UILabel *lble = (UILabel *)label;
                    lble.adjustsFontSizeToFitWidth = YES;
                    
                    [label setTextAlignment:UITextAlignmentCenter];
                    [label setFont:[UIFont boldSystemFontOfSize:12.5f]];
                }
            }           
        }
    }    
    
    if ([delegate respondsToSelector:@selector(settingsTag:)]) 
    {
        [delegate settingsTag:self];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIFont *font = nil;
    NSString *str = [[UIDevice currentDevice] systemVersion];
    float version = str.floatValue;
    if(version == 5.0)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
        {
            font = [UIFont boldSystemFontOfSize:24.0f];
        }
        else
        {
            font = [UIFont boldSystemFontOfSize:12.0f];
        }
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:UITextAttributeFont];
        [segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    else
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            font = [UIFont boldSystemFontOfSize:24.0f];
        }
        else
        {
            font = [UIFont boldSystemFontOfSize:12.5f];
        
            for (id segment in [segmentedControl subviews]) 
            {
                for (id label in [segment subviews]) 
                {
                    if ([label isKindOfClass:[UILabel class]])
                    {
                        UILabel *lble = (UILabel *)label;
                        lble.adjustsFontSizeToFitWidth = YES;
                            
                        [label setTextAlignment:UITextAlignmentCenter];
                        [label setFont:[UIFont boldSystemFontOfSize:12.5f]];
                    }
                }           
            }
        }
    }
    
}

-(void)dealloc
{
    [segmentedControl release];
    [lbl release];
    [super dealloc];
}

@end
