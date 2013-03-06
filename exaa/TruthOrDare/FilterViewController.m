

#import "FilterViewController.h"
#import "UserDefaultSettings.h"

@implementation FilterViewController

@synthesize strMin;
@synthesize strMax;
@synthesize dictFilter;
@synthesize strbuildin;
@synthesize strmine;
@synthesize stractive;
@synthesize strinactive;
@synthesize strbothsexes;
@synthesize strformales;
@synthesize strforfemales;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    thisDevice = [UIDevice currentDevice];
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication]delegate];
    
    lblTitle.text=NSLocalizedString(@"Filter", @"");
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        scrollview.contentSize=CGSizeMake(768, 1110);
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:42.0]];
    }
    else
    {
        scrollview.contentSize=CGSizeMake(320, 610);
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
    }
    [lblTitle setTextColor:[UIColor whiteColor]];
    
    self.dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Filter"];
    if([dictFilter count] == 0)
    {
        self.strMin = @"1";
        self.strMax = @"3";
        self.strbuildin = @"1";
        self.strmine=@"1";
        self.stractive = @"1";
        self.strinactive = @"0";
        self.strbothsexes=@"1";
        self.strformales=@"1";
        self.strforfemales=@"1";
    }
    else
    {
        self.strMin = [dictFilter valueForKey:@"Min"];
        self.strMax = [dictFilter valueForKey:@"Max"];
        self.strbuildin = [dictFilter valueForKey:@"Buid in"];
        self.strmine = [dictFilter valueForKey:@"Mine"];
        self.stractive = [dictFilter valueForKey:@"Active"];
        self.strinactive =[dictFilter valueForKey:@"InActive"];
        self.strbothsexes=[dictFilter valueForKey:@"For both sexes"];
        self.strformales=[dictFilter valueForKey:@"For Males"];
        self.strforfemales=[dictFilter valueForKey:@"For Females"];
    }
    
    minCount = strMin.integerValue;
    maxCount = strMax.integerValue;
}


-(void)viewWillAppear:(BOOL)animated
{
    lblDirtiness.text=NSLocalizedString(@"Dirtiness", @"");
    lblMin.text=NSLocalizedString(@"Minimum", @"");
    lblMax.text=NSLocalizedString(@"Maximum", @"");
    lblSource.text=NSLocalizedString(@"Source", @"");
    lblbuildin.text=NSLocalizedString(@"Built In", @"");
    lblmine.text=NSLocalizedString(@"Mine", @"");
    lblActive.text=NSLocalizedString(@"Active label", @"");
    lblactive.text=NSLocalizedString(@"Active", @"");
    lblinactive.text=NSLocalizedString(@"Inactive", @"");
    lblGender.text=NSLocalizedString(@"Gender", @"");
    lblbothsexes.text=NSLocalizedString(@"For both sexes", @"");
    lblformales.text=NSLocalizedString(@"For males", @"");
    lblforfemales.text=NSLocalizedString(@"For females", @"");
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        [lblDirtiness setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblMin setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblMax setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        
        [lblSource setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblActive setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblGender setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        
        [lblactive setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblinactive setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblbuildin setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblmine setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblbothsexes setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblformales setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        [lblforfemales setFont:[UIFont fontWithName:@"SegoePrint" size:35.0]];
        
        if ([strbuildin isEqualToString:@"1"]) 
        {
            [btnbuildin setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([strmine isEqualToString:@"1"]) 
        {
            [btnmine setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([stractive isEqualToString:@"1"]) {
            [btnactive setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([strinactive isEqualToString:@"1"]) {
            [btninactive setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([strbothsexes isEqualToString:@"1"]) {
            [btnbothsexes setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([strforfemales isEqualToString:@"1"]) {
            [btnforfemales setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
        if ([strformales isEqualToString:@"1"]) {
            [btnformales setImage:[UIImage imageNamed:@"check_iPad.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [lblDirtiness setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblMin setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblMax setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        
        [lblSource setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblActive setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblGender setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        
        [lblactive setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblinactive setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblbuildin setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblmine setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblbothsexes setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblformales setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        [lblforfemales setFont:[UIFont fontWithName:@"SegoePrint" size:15.0]];
        
        if ([strbuildin isEqualToString:@"1"]) {
            [btnbuildin setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([strmine isEqualToString:@"1"]) {
            [btnmine setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([stractive isEqualToString:@"1"]) {
            [btnactive setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([strinactive isEqualToString:@"1"]) {
            [btninactive setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([strbothsexes isEqualToString:@"1"]) {
            [btnbothsexes setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([strforfemales isEqualToString:@"1"]) {
            [btnforfemales setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
        if ([strformales isEqualToString:@"1"]) {
            [btnformales setImage:[UIImage imageNamed:@"checkmark_selected"] forState:UIControlStateNormal];
        }
    }
    
    if([strMax isEqualToString:@"1"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMax isEqualToString:@"2"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMax isEqualToString:@"3"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMax isEqualToString:@"4"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
        
    }
    if([strMax isEqualToString:@"5"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMax isEqualToString:@"6"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
        }
    }
    
    
    if([strMin isEqualToString:@"1"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMin isEqualToString:@"2"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMin isEqualToString:@"3"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];

        }
    }
    if([strMin isEqualToString:@"4"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    if([strMin isEqualToString:@"5"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];

        }
           }
    if([strMin isEqualToString:@"6"])
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
        }
        else
        {
            [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnMin6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
        }
    }
}

#pragma mark custom methods
//Back to Truth and dare Display screen method
-(IBAction)back
{
    NSArray *objects = [NSArray arrayWithObjects:
                        strMin, 
                        strMax, 
                        strbuildin,
                        strmine,
                        stractive,
                        strinactive,
                        strbothsexes,
                        strforfemales,
                        strformales,
                        nil];
    NSArray *keys = [NSArray arrayWithObjects:@"Min", @"Max", @"Buid in", @"Mine", @"Active", @"InActive", @"For both sexes",@"For Females",@"For Males",nil];
    
    
    self.dictFilter = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    [[UserDefaultSettings sharedSetting] storeDictionary:dictFilter withKey:@"Filter"];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//Source selection method
-(IBAction)Sourcebtnaction:(id)sender
{
    appDelegate.flagfilter=TRUE;
    UIButton *btn=sender;

    if ([btn tag]==1) 
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btnbuildin.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnbuildin setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strbuildin=@"1";
            }
            else
            {
                [btnbuildin setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strbuildin=@"0";
            }
        }
        else
        {
            if([btnbuildin.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnbuildin setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strbuildin=@"1";
            }
            else
            {
                [btnbuildin setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strbuildin=@"0";
            }
        }
    }
    else
    {
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            if([btnmine.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnmine setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strmine=@"1";
            }
            else
            {
                [btnmine setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strmine=@"0";
            }
        }
        else
        {
            if([btnmine.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnmine setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strmine=@"1";
            }
            else
            {
                [btnmine setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strmine=@"0";
            }

        }
    }
}
//Active  selection method
-(IBAction)Activebtnaction:(id)sender
{
     appDelegate.flagfilter=TRUE;
    UIButton *btn=sender;

    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if ([btn tag]==1) {
            if([btnactive.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnactive setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.stractive=@"1";
            }
            else
            {
                [btnactive setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.stractive=@"0";
            }
        }
        else
        {
            if([btninactive.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btninactive setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strinactive=@"1";
            }
            else
            {
                [btninactive setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strinactive=@"0";
            }
        }

    }
    else
    {
        if ([btn tag]==1) {
            if([btnactive.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnactive setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.stractive=@"1";
            }
            else
            {
                [btnactive setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.stractive=@"0";
            }
            
        }
        else
        {
            if([btninactive.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btninactive setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strinactive=@"1";
            }
            else
            {
                [btninactive setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strinactive=@"0";
            }
            
        }

    }
    
}
//Gender  selection method
-(IBAction)gender:(id)sender
{
    appDelegate.flagfilter=TRUE;
    UIButton *btn=sender;
    thisDevice = [UIDevice currentDevice];

    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if ([btn tag]==1) {
            if([btnbothsexes.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnbothsexes setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strbothsexes=@"1";
            }
            else
            {
                [btnbothsexes setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strbothsexes=@"0";
            }
            
        }
        else if([btn tag]==2)
        {
            if([btnforfemales.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnforfemales setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strforfemales=@"1";
            }
            else
            {
                [btnforfemales setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strforfemales=@"0";
            }
            
        }
        else
        {
            if([btnformales.currentImage isEqual:[UIImage imageNamed:@"uncheck_iPad.png"]])
            {
                [btnformales setImage:[UIImage imageNamed: @"check_iPad.png"] forState:UIControlStateNormal]; 
                self.strformales=@"1";
            }
            else
            {
                [btnformales setImage:[UIImage imageNamed: @"uncheck_iPad.png"] forState:UIControlStateNormal]; 
                self.strformales=@"0";
            }
        }
        

    }
    else
    {
        if ([btn tag]==1) {
            if([btnbothsexes.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnbothsexes setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strbothsexes=@"1";
            }
            else
            {
                [btnbothsexes setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strbothsexes=@"0";
            }
            
        }
        else if([btn tag]==2)
        {
            if([btnforfemales.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnforfemales setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strforfemales=@"1";
            }
            else
            {
                [btnforfemales setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strforfemales=@"0";
            }
            
        }
        else
        {
            if([btnformales.currentImage isEqual:[UIImage imageNamed:@"checkmark_normal.png"]])
            {
                [btnformales setImage:[UIImage imageNamed: @"checkmark_selected.png"] forState:UIControlStateNormal]; 
                self.strformales=@"1";
            }
            else
            {
                [btnformales setImage:[UIImage imageNamed: @"checkmark_normal.png"] forState:UIControlStateNormal]; 
                self.strformales=@"0";
            }
        }
        

    }
        
}

//Maximum Dirtiness selection method
-(IBAction)setMax:(id)sender
{
     appDelegate.flagfilter=TRUE;
    UIButton *btn = (UIButton *)sender;
   // thisDevice = [UIDevice currentDevice];
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        if(btn.tag == 1)
        {
            if([btnMax1.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 1;
                strMax = @"1";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 1;
                strMax = @"1";
                
            }
            [self checkMin];
        }
        if(btn.tag == 2)
        {
            if([btnMax2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 2;
                strMax = @"2";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 2;
                strMax = @"2";
                
            }
            [self checkMin]; 
        }
        if(btn.tag == 3)
        {
            if([btnMax3.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 3;
                strMax = @"3";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 3;
                strMax = @"3";
                
            }
            [self checkMin];
        }
        if(btn.tag == 4)
        {
            if([btnMax4.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 4;
                strMax = @"4";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 4;
                strMax = @"4";
                
            }
            [self checkMin];
        }
        if(btn.tag == 5)
        {
            if([btnMax5.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 5;
                strMax = @"5";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                maxCount = 5;
                strMax = @"5";
                
            }
            [self checkMin];
        }
        if(btn.tag == 6)
        {
            if([btnMax6.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                maxCount = 6;
                strMax = @"6";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                maxCount = 6;
                strMax = @"6";
                
            }
            [self checkMin];
        }
    }
    else
    {
        if(btn.tag == 1)
        {
            if([btnMax1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 1;
                strMax = @"1";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 1;
                strMax = @"1";
                
            }
            [self checkMin];
        }
        if(btn.tag == 2)
        {
            if([btnMax2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 2;
                strMax = @"2";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 2;
                strMax = @"2";
                
            }
            [self checkMin]; 
        }
        if(btn.tag == 3)
        {
            if([btnMax3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 3;
                strMax = @"3";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 3;
                strMax = @"3";
                
            }
            [self checkMin];
        }
        if(btn.tag == 4)
        {
            if([btnMax4.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 4;
                strMax = @"4";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 4;
                strMax = @"4";
                
            }
            [self checkMin];
        }
        if(btn.tag == 5)
        {
            if([btnMax5.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 5;
                strMax = @"5";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                maxCount = 5;
                strMax = @"5";
                
            }
            [self checkMin];
        }
        if(btn.tag == 6)
        {
            if([btnMax6.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                maxCount = 6;
                strMax = @"6";
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                maxCount = 6;
                strMax = @"6";
                
            }
            [self checkMin];
        }
    }
    
    
}
//Minimum Dirtiness selection method
-(IBAction)setMin:(id)sender
{
     appDelegate.flagfilter=TRUE;
    UIButton *btn = (UIButton *)sender;

    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        if(btn.tag == 1)
        {
            if([btnMin1.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 1;
                strMin = @"1";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 1;
                strMin = @"1";
                
            }
            [self checkMax];
        }
        if(btn.tag == 2)
        {
            if([btnMin2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 2;
                strMin = @"2";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 2;
                strMin = @"2";
            }
            [self checkMax];
        }
        if(btn.tag == 3)
        {
            if([btnMin3.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 3;
                strMin = @"3";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 3;
                strMin = @"3";
            }
            [self checkMax]; 
        }
        if(btn.tag == 4)
        {
            if([btnMin4.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 4;
                strMin = @"4";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 4;
                strMin = @"4";
            }
            [self checkMax];
        }
        if(btn.tag == 5)
        {
            if([btnMin5.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 5;
                strMin = @"5";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                minCount = 5;
                strMin = @"5";
                
            }
            [self checkMax]; 
        }
        if(btn.tag == 6)
        {
            if([btnMin6.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                minCount = 6;
                strMin = @"6";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                minCount = 6;
                strMin = @"6";
                
            }
            [self checkMax];
        }
    }
    else
    {
        if(btn.tag == 1)
        {
            if([btnMin1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 1;
                strMin = @"1";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 1;
                strMin = @"1";
                
            }
            [self checkMax];
        }
        if(btn.tag == 2)
        {
            if([btnMin2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 2;
                strMin = @"2";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 2;
                strMin = @"2";
            }
            [self checkMax];
        }
        if(btn.tag == 3)
        {
            if([btnMin3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 3;
                strMin = @"3";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 3;
                strMin = @"3";
            }
            [self checkMax]; 
        }
        if(btn.tag == 4)
        {
            if([btnMin4.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 4;
                strMin = @"4";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 4;
                strMin = @"4";
            }
            [self checkMax];
        }
        if(btn.tag == 5)
        {
            if([btnMin5.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 5;
                strMin = @"5";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                minCount = 5;
                strMin = @"5";
                
            }
            [self checkMax]; 
        }
        if(btn.tag == 6)
        {
            if([btnMin6.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                minCount = 6;
                strMin = @"6";
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                minCount = 6;
                strMin = @"6";
                
            }
            [self checkMax];
        }
    }
    
    
}
// check Minimum method
-(void)checkMin
{
    
    if(minCount > maxCount)
    {
        if(maxCount == 2)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];

            }
            minCount = 1;
            strMin = @"1";
        }
        else if(maxCount == 3)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            
            minCount = 2;
            strMin = @"2";
        }
        else if(maxCount == 4)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            
            minCount = 3;
            strMin = @"3";
        }
        else if(maxCount == 5)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            minCount = 4;
            strMin = @"4";
        }
        else if(maxCount == 6)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            minCount = 5;
            strMin = @"5";
        }
        else 
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnMin1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMin2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMin4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMin6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }

            minCount = 1;
            strMin = @"1";
        }
    }
    
}
// check Maximum method
-(void)checkMax
{
  //  thisDevice = [UIDevice currentDevice];
    
    if(minCount > maxCount)
    {
        if(minCount == 1)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];

            }
            maxCount = 2;
            strMax = @"2";
        }
        else if (minCount == 2)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];

            }
            maxCount = 3;
            strMax = @"3";
        }
        else if (minCount == 3)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            maxCount = 4;
            strMax = @"4";
        }
        else if (minCount == 4)
        {
            if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            maxCount = 5;
            strMax = @"5";
        }
        else if (minCount == 5)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                
            }
            maxCount = 6;
            strMax = @"6";
        }
        else
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnMax1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnMax1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnMax4 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax5 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnMax6 setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                
            }
            maxCount = 6;
            strMax = @"6";
        }
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    
    [btnBack release];
    [lblTitle release];
    [lblDirtiness release];
    [lblMin release];
    [lblMax release];
    [lblSource release];
    [lblActive release];
    [lblGender release];
    [btnMax1 release];
    [btnMax2 release];
    [btnMax3 release];
    [btnMax4 release];
    [btnMax5 release];
    [btnMax6 release];
    [btnMin1 release];
    [btnMin2 release];
    [btnMin3 release];
    [btnMin4 release];
    [btnMin5 release];
    [btnMin6 release];
    [btnactive release];
    [btninactive release];
    [btnbuildin release];
    [btnmine release];
    [btnbothsexes release];
    [btnformales release];
    [btnforfemales release];
    [scrollview release];
    [lblactive release];
    [lblinactive release];
    [lblbuildin release];
    [lblmine release];
    [lblbothsexes release];
    [lblformales release];
    [lblforfemales release];
    
    self.strMin = nil;
    self.strMax= nil;
    self.dictFilter = nil;
    self.strbuildin = nil;
    self.strmine = nil;
    self.stractive = nil;
    self.strinactive = nil;
    self.strbothsexes = nil;
    self.strformales = nil;
    self.strforfemales = nil;
    
    [super dealloc];
}

@end
