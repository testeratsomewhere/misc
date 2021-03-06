

#import "PlayerselectionVC.h"

@implementation PlayerselectionVC
@synthesize player;
@synthesize strselection;
@synthesize backbtn;
@synthesize language;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

// go to Back to Previous screen
-(IBAction)backbtnAction:(id)sender
{
    if ([strselection isEqualToString:@"player"])
    {
        
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        NSInteger Value1=[arrayNo indexOfObject:lblselectedplayer.text]; 
        NSString *strstring=[NSString stringWithFormat:@"%d",Value1+2];
        [prefs1 setObject:strstring forKey:@"No player"];
    }
    else if([strselection isEqualToString:@"speed"])
    {
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        
        NSInteger Value1=[arrayNo indexOfObject:lblselectedplayer.text]; 
        NSString *strstring=[NSString stringWithFormat:@"%d",Value1+1];
        [prefs1 setObject:strstring forKey:@"speed"];  
    }
    else if([strselection isEqualToString:@"language"])
    {
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        // NSInteger val = [arrayNo indexOfObject:lblselectedplayer.text];
        NSString *strstring = lblselectedplayer.text;
        [prefs1 setObject:strstring forKey:@"language"];
    }
    else
    {
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        NSInteger Value1=[arrayNo indexOfObject:lblselectedplayer.text]; 
        NSString *strstring=[NSString stringWithFormat:@"%d",Value1+1];
        [prefs1 setObject:strstring forKey:@"auto truth"]; 
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{
    
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    if ([strselection isEqualToString:@"player"])
    {
        lblTitle.text=NSLocalizedString(@"Number of players", @""); // @"Number of players";
    }
    else if([strselection isEqualToString:@"speed"])
    {
        lblTitle.text=NSLocalizedString(@"Speed", @"");// @"Speed"; 
    }
    else if([strselection isEqualToString:@"auto truth"])
    {
        lblTitle.text=NSLocalizedString(@"Auto Challenge", @"");//@"Auto Challenge";  
    }
    else
    {
        lblTitle.text=NSLocalizedString(@"Language Support", @"");
    }
    
    
    thisDevice = [UIDevice currentDevice];
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:42.0]];
        [lblselectedplayer setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:55.0]];
    }
    else
    {
        [lblTitle setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
        [lblselectedplayer setFont:[UIFont fontWithName:@"SegoePrint-Bold" size:20.0]];
    }
    [lblTitle setTextColor:[UIColor whiteColor]];
    [lblselectedplayer setTextColor:[UIColor whiteColor]];
    if ([strselection isEqualToString:@"player"]) 
    {
        NSString *strLocal = NSLocalizedString(@"players", @"");
        NSLog(@"%@",strLocal);
        arrayNo = [[NSMutableArray alloc] init] ;
        [arrayNo addObject:[NSString stringWithFormat:@" 2%@",strLocal]]; //@" 2+ players"];
        [arrayNo addObject:[NSString stringWithFormat:@" 3%@",strLocal]];
        [arrayNo addObject:[NSString stringWithFormat:@" 4%@",strLocal]];
        [arrayNo addObject:[NSString stringWithFormat:@" 5%@",strLocal]];
        [arrayNo addObject:[NSString stringWithFormat:@" 6%@",strLocal]];
        [arrayNo addObject:[NSString stringWithFormat:@" 7%@",strLocal]];
        
        NSString *strplayer=[NSString stringWithFormat:@"%d%@",player, strLocal];
        NSLog(@"%@",strplayer);
        Value=[arrayNo indexOfObject:strplayer];
        [picker selectRow:player-2 inComponent:0 animated:NO];
        lblselectedplayer.text= [arrayNo objectAtIndex:[picker selectedRowInComponent:0]]; 
    }
    else if([strselection isEqualToString:@"language"])
    {
        arrayNo = [[NSMutableArray alloc]init];
        [arrayNo addObject:[NSString stringWithFormat:@" Deutsch"]];
        [arrayNo addObject:[NSString stringWithFormat:@" English"]];
        [arrayNo addObject:[NSString stringWithFormat:@" Español"]];
        [arrayNo addObject:[NSString stringWithFormat:@" Français"]];
        
        NSSortDescriptor *sortLang = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        [arrayNo sortUsingDescriptors:[NSArray arrayWithObject:sortLang]];
        
        NSString *lang = [NSString stringWithFormat:@"%@",language];
       
        Value=[arrayNo indexOfObject:lang];
        [picker selectRow:Value inComponent:0 animated:NO];
        lblselectedplayer.text=[arrayNo objectAtIndex:[picker selectedRowInComponent:0]];
    
    }
    else
    {
        arrayNo = [[NSMutableArray alloc] init] ;
        [arrayNo addObject:@" 1"];
        [arrayNo addObject:@" 2"];
        [arrayNo addObject:@" 3"];
        [arrayNo addObject:@" 4"];
        [arrayNo addObject:@" 5"];
        [arrayNo addObject:@" 6"];
        [arrayNo addObject:@" 7"];
        [arrayNo addObject:@" 8"];
        [arrayNo addObject:@" 9"];
        [arrayNo addObject:@" 10"];
        
        NSString *strplayer=[NSString stringWithFormat:@"%d",player];
        Value=[arrayNo indexOfObject:strplayer];
        [picker selectRow:player-1 inComponent:0 animated:NO];
        lblselectedplayer.text= [arrayNo objectAtIndex:[picker selectedRowInComponent:0]];
    }
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
    {
        picker.transform = CGAffineTransformMakeScale(1.00f, 1.30f);
    }
    else
    {
        picker.frame = CGRectMake(0, 170, 320, 216);
    }
    [super viewDidLoad];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *pickerLabel = (UILabel *)view;
    
    // Reuse the label if possible, otherwise create and configure a new one
    if(!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] initWithFrame:CGRectMake(1.20f, 1.80f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
        pickerLabel.backgroundColor = [UIColor clearColor];
    }
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        //pickerLabel.textAlignment = UITextAlignmentCenter;
        pickerLabel.font = [UIFont boldSystemFontOfSize:30];//25
    }
    else
    {
        pickerLabel.font = [UIFont boldSystemFontOfSize:20];
    }
    pickerLabel.text = [arrayNo objectAtIndex:row];
    return pickerLabel;
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
//        //picker = [UIPickerView alloc];// initWithFrame:CGRectMake(0, 590, 768, 280)];
//        //[picker setFrame: CGRectMake(0, 590, 768, 300)];
//        
//        picker.frame = CGRectMake(0, 590, 768, 280);
//    }
//}
// Picker View Delegate Methods
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",CurrentLang);
    
    lblselectedplayer.text=   [arrayNo objectAtIndex:row];
    
    if([strselection isEqualToString:@"language"])
    {
        NSUserDefaults *prefs1 = [NSUserDefaults standardUserDefaults];
        NSString *strstring;
        
        if ([lblselectedplayer.text isEqualToString:@" Deutsch"]) {
            strstring = @"de";
        }
        else if([lblselectedplayer.text isEqualToString:@" English"])
        {
            strstring = @"en";
        }
        else if([lblselectedplayer.text isEqualToString:@" Español"])
        {
            strstring = @"es";
        }
        else if([lblselectedplayer.text isEqualToString:@" Français"])
        {
            strstring = @"fr";
        }
        [prefs1 setObject:strstring forKey:@"temp"];
        
    }
    // NSLog(@"strTemp = %@",strTemp);
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [arrayNo count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [arrayNo objectAtIndex:row];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
}

//- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
//{
//    return 50;
//}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
