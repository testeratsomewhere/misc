

#import "PersonCodeViewController.h"

@implementation PersonCodeViewController
@synthesize delegate;
@synthesize strPassedCode;
@synthesize strRecievedMessage;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    
    tblPersonCode.backgroundColor = [UIColor clearColor];
    
    tblPersonCode.scrollEnabled = NO;
    
    tblSelectCode.backgroundColor = [UIColor clearColor];
    tblSelectCode.scrollEnabled = NO;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        tblPersonCode.rowHeight = 60;
        tblSelectCode.rowHeight = 60;
    }
    else
    {
        tblPersonCode.rowHeight = 30;
        tblSelectCode.rowHeight = 30;
    }
    
    arrCode = [[NSMutableArray alloc] init];
    [arrCode addObject:@"Divine 1"];
    [arrCode addObject:@"Divine 2"];
    [arrCode addObject:@"Divine 3"];
    [arrCode addObject:@"Divine 4"];
    [arrCode addObject:@"Divine 5"];
    [arrCode addObject:@"Divine 6"];
    
    arrCodeCopy = [[NSMutableArray alloc] init];
    [arrCodeCopy addObject:@"Divine 1"];
    [arrCodeCopy addObject:@"Divine 2"];
    [arrCodeCopy addObject:@"Divine 3"];
    [arrCodeCopy addObject:@"Divine 4"];
    [arrCodeCopy addObject:@"Divine 5"];
    [arrCodeCopy addObject:@"Divine 6"];
}

#pragma mark custom methods
// go to Back to Previous screen
-(IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
// Table View Methods
#pragma mark table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == tblPersonCode) 
    {
        return 6;
    }
    else if(tableView == tblSelectCode)  
    {
        return 4;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) 
    {
        if (tableView == tblSelectCode)
        {
            if ([CurrentLang isEqualToString:@"fr"])
            {
                CGSize size = [[NSString stringWithFormat:@"%@ -*%@",[self determineSelectCodeString:selectedPersonCode],[self determineSelectionCode:selectedPersonCode]] sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:12.0]];
                if (indexPath.row == 0)
                {
                    if (size.width > 300)
                    {
                        return 60;
                    }
                }
            }
        }
        return 30;
    }
    else
    {
        if (tableView == tblSelectCode)
        {
            if ([CurrentLang isEqualToString:@"fr"])
            {
                CGSize size = [[NSString stringWithFormat:@"%@ -*%@",[self determineSelectCodeString:selectedPersonCode],[self determineSelectionCode:selectedPersonCode]] sizeWithFont:[UIFont fontWithName:@"SegoePrint" size:30.0]];
                if (indexPath.row == 0)
                {
                    if (size.width > 700)
                    {
                        return 120;
                    }
                }
            }
        }
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(tableView == tblPersonCode)
    {
        if(indexPath.row == 0)
        {
            cell.textLabel.text = NSLocalizedString(@"Anybody of either sex", @"");
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = NSLocalizedString(@"Somebody of opposite sex", @"");
        }  
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = NSLocalizedString(@"Somebody of same sex", @"");
        }
        else if(indexPath.row == 3)
        {
            cell.textLabel.text = NSLocalizedString(@"Anybody else of either sex", @"");
        }
        else if(indexPath.row == 4)
        {
            cell.textLabel.text = NSLocalizedString(@"Somebody else of opposite sex", @"");
        }
        else if(indexPath.row == 5)
        {
            cell.textLabel.text = NSLocalizedString(@"Somebody else of same sex", @"");
        }
    }
    else
    {
        if (indexPath.row == 0)
        {
            
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) 
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ -*%@",[self determineSelectCodeString:selectedPersonCode],[self determineSelectionCode:selectedPersonCode]];
                if ([CurrentLang isEqualToString:@"fr"])
                {
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    cell.textLabel.numberOfLines = 2;
                }
            }
            else
            {
                cell.textLabel.text = [NSString stringWithFormat:@"%@ -*%@",[self determineSelectCodeString:selectedPersonCode],[self determineSelectionCode:selectedPersonCode]];
                if ([CurrentLang isEqualToString:@"fr"])
                {
                    cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
                    cell.textLabel.numberOfLines = 2;
                }
            }
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"He or she -*he", @""),[self determineSelectionCode:selectedPersonCode]];
        }
        else if(indexPath.row == 2)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"He or she -*his", @""),[self determineSelectionCode:selectedPersonCode]];
        }
        else if(indexPath.row == 3)
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"He or she -*him", @""),[self determineSelectionCode:selectedPersonCode]];
        }
        
    }
    
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
    {
        [cell.textLabel setFont:[UIFont fontWithName:@"Segoe Print" size:30.0]];
    }
    else
    {
        [cell.textLabel setFont:[UIFont fontWithName:@"Segoe Print" size:12.0]];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    
    
    UIColor *color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"divider.png"]];
    [tableView setSeparatorColor:color];
    
    return cell;
} 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad){
        return 45;
    }
    else{
        return 20;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	UIView *headerView = [[[UIView alloc] init] autorelease];
    UIImageView *img1;
    UILabel *lbl = [[UILabel alloc] init];
    
    if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        headerView.frame = CGRectMake(0, 0, 768, 52);
        img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"titlebar_iPad.png"]];
        lbl.frame = CGRectMake(10, 3, 400, 45);
        [lbl setFont:[UIFont fontWithName:@"Segoe Print" size:30.0]];
    }
    else
    {
        headerView.frame = CGRectMake(0, 0, 320, 40);
        img1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"settingstripe.png"]];
        lbl.frame = CGRectMake(10, 3, 210, 20);
        [lbl setFont:[UIFont fontWithName:@"Segoe Print" size:15.0]];
    }
	[headerView addSubview:img1];
    [img1 release];
	
	
	
	lbl.backgroundColor = [UIColor clearColor];
	if(tableView == tblPersonCode)
    {
        lbl.text = NSLocalizedString(@"Person Code", @"");
    }
    else
    {
        lbl.text = NSLocalizedString(@"Select Code", @"");
    }
    lbl.textColor =[UIColor whiteColor];
	[headerView addSubview:lbl];
    [lbl release];
	return headerView;
	
}

-(NSString *)determineSelectCodeString:(PersonCodeType)personCode
{
    switch (personCode) {
        case 0:
            return NSLocalizedString(@"Anybody of either sex", @"");
            break;
        case 1:
            return NSLocalizedString(@"Somebody of opposite sex", @"");
            break;
        case 2:
            return NSLocalizedString(@"Somebody of same sex", @"");
            break;
        case 3:
            return NSLocalizedString(@"Anybody else of either sex", @"");
            break;
        case 4:
            return NSLocalizedString(@"Somebody else of opposite sex", @"");
            break;
        case 5:
            return NSLocalizedString(@"Somebody else of same sex", @"");
            break;
            
        default:
            break;
    }
}

-(NSString *)determineSelectionCode:(PersonCodeType)personCode
{
    switch (personCode) {
        case 0:
            return @"X";
            break;
        case 1:
            return @"XY";
            break;
        case 2:
            return @"XX";
            break;
        case 3:
            return @"X2";
            break;
        case 4:
            return @"XY2";
            break;
        case 5:
            return @"XX2";
            break;
            
        default:
            break;
    }
}

-(NSString *)determineMultipleSelectionCode:(MultipleCodeType)multipleType
{
    switch (multipleType) {
        case 11:
            return NSLocalizedString(@"he", @""); 
            break;
        case 12:
            return NSLocalizedString(@"his", @"");
            break;
        case 13:
            return NSLocalizedString(@"him", @"");
            break;
        default:
            break;
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tblPersonCode) {
        selectedPersonCode = indexPath.row;
        
        [tblSelectCode reloadData];
    }
    else if(tableView == tblSelectCode)
    {
        if (indexPath.row == 0) 
        {
            if([self.strRecievedMessage isEqualToString:@""])
            {
                self.strPassedCode = [NSString stringWithFormat:@"*%@",[self determineSelectionCode:selectedPersonCode]];
            }
            else
            {
                self.strPassedCode = [NSString stringWithFormat:@"*%@",[self determineSelectionCode:selectedPersonCode]];
            }
            
        }
        else
        {
            selectedMultipleType = indexPath.row + 10;
            if([self.strRecievedMessage isEqualToString:@""])
            {
                self.strPassedCode = [NSString stringWithFormat:@"*%@%@",[self determineMultipleSelectionCode:selectedMultipleType],[self determineSelectionCode:selectedPersonCode]];
            }
            else
            {
                self.strPassedCode = [NSString stringWithFormat:@"*%@%@",[self determineMultipleSelectionCode:selectedMultipleType],[self determineSelectionCode:selectedPersonCode]];
            }
        }
        
        [self.delegate addPersonCodeAtTheProperRange:self.strPassedCode andPop:self];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    self.strPassedCode = nil;
    self.strRecievedMessage = nil;
    [super dealloc];
}


@end
