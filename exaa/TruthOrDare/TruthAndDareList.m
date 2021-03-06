
#import "TruthAndDareList.h"
#import "EditTruthOrDareViewController.h"
#import "FilterViewController.h"
#import "UserDefaultSettings.h"
#define CELL_CONTENT_WIDTH 270.0f
#define CELL_CONTENT_MARGIN 5.0

#define ipadCellPadding 10
#define labelPadding 10


@implementation TruthAndDareList

@synthesize arrDare;
@synthesize arrTruth;
@synthesize contentView = _contentView;
bool cellFlag;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    strTitle = @"Truth";
    thisDevice = [UIDevice currentDevice];
    appDelegate = (TruthOrDareAppDelegate *) [[UIApplication sharedApplication] delegate];
    self.arrTruth = [[[NSMutableArray alloc] init] autorelease];

    self.arrDare = [[[NSMutableArray alloc] init] autorelease];
    
    flgTruth = YES;
    flgDare = NO;
    
    tblTruth.backgroundColor = [UIColor clearColor];
    
    [activity startAnimating];
}

-(void)viewWillAppear:(BOOL)animated
{
    mopubclass=[Mopubclass sharedInstance];
    CGRect frame = mopubclass.mpAdView.frame;
    CGSize size = [mopubclass.mpAdView adContentViewSize];
    frame.origin.y = self.view.bounds.size.height - size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor clearColor];
    mopubclass.mpAdView.frame = frame;
    [self.view addSubview:mopubclass.mpAdView];
    
    
    //  mopubclass.mpAdView.backgroundColor=[UIColor clearColor];
	mopubclass.mpAdView.delegate = self;
	[mopubclass.mpAdView loadAd];
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = mopubclass.mpAdView.frame;
    
    contentFrame.size.height -= mopubclass.mpAdView.frame.size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor blackColor];
    bannerFrame.origin.y = contentFrame.size.height;
    mopubclass.mpAdView.hidden=YES;
    //    } else {
    //        bannerFrame.origin.y = contentFrame.size.height;
    //    }
    
//    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
//        _contentView.frame = contentFrame;
//        
//        [_contentView layoutIfNeeded];
//        mopubclass.mpAdView.frame = bannerFrame;
//    }];
    [self update_UI];
  [activity startAnimating];
}

- (void)adViewDidFailToLoadAd:(MPAdView *)view{
    NSLog(@"ads failed to receive");
}
- (void)adViewDidLoadAd:(MPAdView *)view{
    CGSize size = [view adContentViewSize];
    CGRect newFrame = view.frame;
    newFrame.size = size;
    newFrame.origin.x = (self.view.bounds.size.width - size.width) / 2;
    view.frame = newFrame;
    [self layoutAnimated:YES];
    mopubclass.mpAdView.hidden=NO;
    NSLog(@"ads suceessful to receive");
}
- (UIViewController *)viewControllerForPresentingModalView
{
	return self;
}


-(void)viewDidAppear:(BOOL)animated
{
    if([arrTruth count] == 0 && [arrDare count] == 0 )
    {
        
        [self getTruthList];
        [self getDareList];
        [tblTruth reloadData];
        
    }
    if(appDelegate.flgUpdate == TRUE)
    {
        
        if(flgTruth)
        {
            [arrTruth removeAllObjects];

            [self getTruthList];
        }
        else
        {
            [arrDare removeAllObjects];

            [self getDareList];
        }
        [tblTruth reloadData];
        appDelegate.flgUpdate = FALSE;
         
    }
    if ( appDelegate.flagfilter==TRUE) {
         
        [arrTruth removeAllObjects];
        
        [self getTruthList];
        [self getDareList];
        [tblTruth reloadData];
        
    }
    if (refresh) {
        
        [arrTruth removeAllObjects];
        [arrDare removeAllObjects];
        [arrTruth removeAllObjects];
        
        [self getTruthList];
        [self getDareList];
        [tblTruth reloadData];
        
        refresh=NO;
    }
    [activity stopAnimating];
}

//Back to Settings screen method
-(IBAction)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

//Go to Filter screen method
-(IBAction)filter
{
    FilterViewController *filterObj;
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        filterObj = [[FilterViewController alloc] initWithNibName:@"FilterViewController_iPad" bundle:nil];
    }
    else
    {
        filterObj = [[FilterViewController alloc] initWithNibName:@"FilterViewController" bundle:nil];
    }
        [self.navigationController pushViewController:filterObj animated:YES];
    [filterObj release];
}

//Truth Selection method
-(IBAction)truthList
{
    strTitle = @"Truth";
    NSString *strTemp=nil;
    NSString *strTemp1=nil;
    UIImage *img;
    UIImage *img1;
    
    flgTruth = YES;
    flgDare = NO;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        strTemp = [NSString stringWithFormat:@"segmentright_iPad_%@",CurrentLang];
        img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp ofType:@"png"]];
        [imgTitle setImage:img];
    }
    else
    {
        strTemp = [NSString stringWithFormat:@"truthselected_%@",CurrentLang];
        img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp ofType:@"png"]];
        [btnTruth setImage:img forState:UIControlStateNormal];
        
        strTemp1 =[NSString stringWithFormat:@"darenormal_%@",CurrentLang];
        img1=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp1 ofType:@"png"]];
        [btnDare setImage:img1 forState:UIControlStateNormal];
        
        
    }
    [tblTruth reloadData];
}

//Dare Selection method
-(IBAction)dareList
{
    strTitle =@"Dare";
    NSString *strTemp=nil;
    NSString *strTemp1=nil;
    UIImage *img;
    UIImage *img1;
    flgDare = YES;
    flgTruth = NO;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        strTemp = [NSString stringWithFormat:@"segmentleft_iPad_%@",CurrentLang];
        img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp ofType:@"png"]];
        [imgTitle setImage:img];
    }
    else
    {
        strTemp = [NSString stringWithFormat:@"truthnormal_%@",CurrentLang];
        img=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp ofType:@"png"]];
        [btnTruth setImage:img forState:UIControlStateNormal];
        
        strTemp1 =[NSString stringWithFormat:@"dareselected_%@",CurrentLang];
        img1=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTemp1 ofType:@"png"]];
        [btnDare setImage:img1 forState:UIControlStateNormal];
    }   
    [tblTruth reloadData];
    
}

//Table View  methods
#pragma mark table data source methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(flgTruth)
        return [arrTruth count];
    else
        return [arrDare count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    cellFlag = 0;
    CGFloat height = 0.0;
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d",indexPath.row];
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell = nil;
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (flgTruth)
    {
        UILabel *lbl = [ [UILabel alloc ] initWithFrame:CGRectZero];
        lbl.textColor = [UIColor whiteColor];
        lbl.backgroundColor = [UIColor clearColor];
        lbl.lineBreakMode = UILineBreakModeWordWrap;
        lbl.numberOfLines = 0;
        NSString *text=[[[NSString alloc]init]autorelease];
        
        if ([CurrentLang isEqualToString:@"en"])
        {
            text=[[arrTruth objectAtIndex:[indexPath row]] valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
            text=[[arrTruth objectAtIndex:[indexPath row]] valueForKey:@"ln_ES"];            
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
            text=[[arrTruth objectAtIndex:[indexPath row]] valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
            text=[[arrTruth objectAtIndex:[indexPath row]] valueForKey:@"ln_DE"];
        }

        UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];
        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lbl.font = [UIFont fontWithName:@"SegoePrint" size:30.0];
            [[cell contentView] addSubview:lbl];
            if (!lbl)
                lbl = (UILabel*)[cell viewWithTag:1];
            
            
            float fontHeight = 30;
            float buttonHeight  = 73;
            CGSize constraint = CGSizeMake(768-50-75, 1000.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontHeight] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
            if (size.height <= 30)
            {
                height = buttonHeight + (2*ipadCellPadding);
                btnEdit.frame = CGRectMake(670,20 , 75, buttonHeight);
            }
            else
            {
                height = (size.height - 30) + buttonHeight + (2*ipadCellPadding) + (2*labelPadding)+10;  
                btnEdit.frame = CGRectMake(670,(height/2)-(75.0/2) , 75, buttonHeight); 
            }
            
            [lbl setText:text];
           [lbl setFrame:CGRectMake(10,0,768-50-75, height)];
            [lbl release];
            
            
            [btnEdit setImage:[UIImage imageNamed:@"editbtn_iPad.png"] forState:UIControlStateNormal];
            
                
        }
        else
        {
            lbl.font = [UIFont fontWithName:@"SegoePrint" size:15.0];
            [[cell contentView] addSubview:lbl];
            if (!lbl)
                lbl = (UILabel*)[cell viewWithTag:1];
            
            
            CGSize constraint = CGSizeMake(320-30-39, 500.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            height = size.height + (2*15);
            
            if (height < (30 + 39))
                height = 30+39;
            else
                height+=10;
            
            [lbl setText:text];
            [lbl setFrame:CGRectMake(10, 2,320-30-39, height)];
            [lbl release];
            
            btnEdit.frame = CGRectMake(275,(height/2)-(39.0/2) , 39, 39); 
            [btnEdit setImage:[UIImage imageNamed:@"editbtn.png"] forState:UIControlStateNormal];

        }
        btnEdit.tag = indexPath.row;
        [btnEdit addTarget:self action:@selector(editPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [btnEdit setUserInteractionEnabled:YES];
        [cell addSubview:btnEdit];
    }
    else
    {
        UILabel *lblDare = [ [UILabel alloc ] initWithFrame:CGRectZero];
        
        lblDare.textAlignment =  UITextAlignmentLeft;
        lblDare.textColor = [UIColor whiteColor];
        lblDare.backgroundColor = [UIColor clearColor];
        lblDare.lineBreakMode = UILineBreakModeWordWrap;
        lblDare.numberOfLines = 0;
        NSString *text=[[[NSString alloc]init]autorelease];
        
        if ([CurrentLang isEqualToString:@"en"])
        {
            text=[[arrDare objectAtIndex:[indexPath row]] valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
            text=[[arrDare objectAtIndex:[indexPath row]] valueForKey:@"ln_ES"];            
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
            text=[[arrDare objectAtIndex:[indexPath row]] valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
            text=[[arrDare objectAtIndex:[indexPath row]] valueForKey:@"ln_DE"];
        }

        UIButton *btnEdit = [UIButton buttonWithType:UIButtonTypeCustom];

        
        if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
        {
            lblDare.font = [UIFont fontWithName:@"SegoePrint" size:30.0];
            [[cell contentView] addSubview:lblDare];
            if (!lblDare)
                lblDare = (UILabel*)[cell viewWithTag:1];
            
            float fontHeight = 30;
            float buttonHeight  = 73;
            CGSize constraint = CGSizeMake(768-50-75,1000.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontHeight] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            
             NSLog(@"%f",size.height);
            if (size.height <= 30)
            {
                height = buttonHeight + (2*ipadCellPadding);
                btnEdit.frame = CGRectMake(670, 20, 75, buttonHeight);
            }
            else
            {
                height = (size.height - 30) + buttonHeight + (2*ipadCellPadding) + (2*labelPadding)+10;  
                btnEdit.frame = CGRectMake(670,(height/2)-(75.0/2) , 75, buttonHeight); 
            }

            [lblDare setText:text];
            [lblDare setFrame:CGRectMake(10, 0,768-50-70, height)];
            [lblDare release];
            
            
            [btnEdit setImage:[UIImage imageNamed:@"editbtn_iPad.png"] forState:UIControlStateNormal];
            
        }
        else
        {
            lblDare.font = [UIFont fontWithName:@"SegoePrint" size:15.0];
            [[cell contentView] addSubview:lblDare];
            if (!lblDare)
                lblDare = (UILabel*)[cell viewWithTag:1];
            
            
            CGSize constraint = CGSizeMake(320-30-39, 500.0f);
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
            height = size.height + (2*15);
            
            if (height < (30 + 39))
                height = 30+39;
            else
                height+=10;
            
            [lblDare setText:text];
            [lblDare setFrame:CGRectMake(10, 2,320-30-39, height)];
            [lblDare release];
            
            btnEdit.frame = CGRectMake(275,(height/2)-(39.0/2) , 39, 39); 
            [btnEdit setImage:[UIImage imageNamed:@"editbtn.png"] forState:UIControlStateNormal];
            

        }
        btnEdit.tag = indexPath.row;
        [btnEdit addTarget:self action:@selector(editPlayer:) forControlEvents:UIControlEventTouchUpInside];
        [btnEdit setUserInteractionEnabled:YES];
        [cell addSubview:btnEdit];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell; 
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text=[[[NSString alloc]init]autorelease];
    CGFloat height = 0.0;
    
    if(flgTruth)
    {
        if ([CurrentLang isEqualToString:@"en"])
        {
            text = [[arrTruth objectAtIndex:[indexPath row]]valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
            text = [[arrTruth objectAtIndex:[indexPath row]]valueForKey:@"ln_ES"];
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
            text = [[arrTruth objectAtIndex:[indexPath row]]valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
            text = [[arrTruth objectAtIndex:[indexPath row]]valueForKey:@"ln_DE"];
        }
    }
    else
    {
        if ([CurrentLang isEqualToString:@"en"])
        {
            text = [[arrDare objectAtIndex:[indexPath row]]valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
            text = [[arrDare objectAtIndex:[indexPath row]]valueForKey:@"ln_ES"];
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
            text = [[arrDare objectAtIndex:[indexPath row]]valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
            text = [[arrDare objectAtIndex:[indexPath row]]valueForKey:@"ln_DE"];
        }
    }
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        float fontHeight = 30;
        float buttonHeight  = 73;
        
        CGSize constraint = CGSizeMake(768-50-75, 1000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontHeight] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
       
        
        if (size.height <= 30) 
        {
            height = buttonHeight + (2*ipadCellPadding);
        }
        else
            height = (size.height - 30) + buttonHeight + (2*ipadCellPadding) + (2*labelPadding)+10;
        
        if (size.height>=60) 
        {
            height+=10;
        }
    }
    else
    {
        CGSize constraint = CGSizeMake(320-30-39, 1000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:17.0f] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        height = size.height + (2*15);
        
        if (height < (30 + 39))
            height = 30+39;
        else
            height+=10;
        
        if (height>80) {
            height+=10;
        }
    }
    return height;
}



#pragma mark custom methods'

//Update Images method
-(void)update_UI
{
    UIImage *imgBtnAdd = nil;
    UIImage *imgBtnFilter = nil;
    UIImage *imgBtnDare = nil;
    UIImage *imgBtnTruth = nil;
    NSString *strAdd =nil;
    NSString *strFilter = nil;
    NSString *strDare =nil;
    NSString *strTruth=nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        strAdd =[NSString stringWithFormat:@"add_iPad_%@",CurrentLang];
        strFilter=[NSString stringWithFormat:@"filter_iPad_%@",CurrentLang];
        
        imgBtnAdd=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strAdd ofType:@"png"]];
        imgBtnFilter=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strFilter ofType:@"png"]];
        
        [btnAdd setImage:imgBtnAdd forState:UIControlStateNormal];
        [btnFilter setImage:imgBtnFilter forState:UIControlStateNormal];
        
        if ([strTitle isEqualToString:@"Truth"])
        {
            strDare=[NSString stringWithFormat:@"segmentright_iPad_%@",CurrentLang];
            imgBtnDare=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strDare ofType:@"png"]];
            imgTitle.image = imgBtnDare;
        }
        else
        {
            strDare = [NSString stringWithFormat:@"segmentleft_iPad_%@",CurrentLang];
            imgBtnDare=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strDare ofType:@"png"]];
            imgTitle.image = imgBtnDare;

        }
        imgTitle.image = imgBtnDare;
        
    }
    else
    {
        strAdd =[NSString stringWithFormat:@"add_%@",CurrentLang];
        strFilter=[NSString stringWithFormat:@"filter_%@",CurrentLang];

        
        imgBtnAdd=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strAdd ofType:@"png"]];
        imgBtnFilter=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strFilter ofType:@"png"]];
        
        [btnAdd setImage:imgBtnAdd forState:UIControlStateNormal];
        [btnFilter setImage:imgBtnFilter forState:UIControlStateNormal];

        if ([strTitle isEqualToString:@"Truth"])
        {
            
            strTruth=[NSString stringWithFormat:@"truthselected_%@",CurrentLang];
            strDare=[NSString stringWithFormat:@"darenormal_%@",CurrentLang];
            imgBtnTruth=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTruth ofType:@"png"]];
            imgBtnDare=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strDare ofType:@"png"]];
            [btnTruth setImage:imgBtnTruth forState:UIControlStateNormal];
            [btnDare setImage:imgBtnDare forState:UIControlStateNormal];
        }
        else
        {
            strTruth=[NSString stringWithFormat:@"truthnormal_%@",CurrentLang];
            strDare=[NSString stringWithFormat:@"dareselected_%@",CurrentLang];
            imgBtnTruth=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strTruth ofType:@"png"]];
            imgBtnDare=[UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strDare ofType:@"png"]];
            [btnTruth setImage:imgBtnTruth forState:UIControlStateNormal];
            [btnDare setImage:imgBtnDare forState:UIControlStateNormal];

        }
    }
}
- (void)layoutAnimated:(BOOL)animated
{
    CGRect contentFrame = self.view.bounds;
    CGRect bannerFrame = mopubclass.mpAdView.frame;
    
    contentFrame.size.height -= mopubclass.mpAdView.frame.size.height;
    mopubclass.mpAdView.backgroundColor=[UIColor blackColor];
    bannerFrame.origin.y = contentFrame.size.height;
    
    [UIView animateWithDuration:animated ? 0.25 : 0.0 animations:^{
        _contentView.frame = contentFrame;
        
        [_contentView layoutIfNeeded];
        mopubclass.mpAdView.frame = bannerFrame;
    }];
}

//Edit Button method
-(void)editPlayer:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    EditTruthOrDareViewController *editObj;
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        editObj= [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController_iPad" bundle:nil];
    }
    else
    {
        editObj= [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController" bundle:nil];
    }
    
       refresh=YES;
    if(flgTruth)
    {
        editObj.strTitle = NSLocalizedString(@"Truth", @"");
        
        if ([CurrentLang isEqualToString:@"en"])
        {
             editObj.strValue = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
             editObj.strValue = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"ln_ES"];
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
             editObj.strValue = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
             editObj.strValue = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"ln_DE"];
        }

//        editObj.strValue = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"ln_EN"];
        editObj.strPrimaryKey = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"pkTruthChallengeID"];
        editObj.strGender = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"gender"];
        editObj.strPlayers = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"minplayers"];
        editObj.strDirtiness = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"dirty"];
         editObj.strActive = [[arrTruth objectAtIndex:btn.tag]valueForKey:@"active"];
        editObj.custom=[[[arrTruth objectAtIndex:btn.tag]valueForKey:@"source"] intValue];
         editObj.pktruthordare=[[[arrTruth objectAtIndex:btn.tag]valueForKey:@"pkTruthChallengeID"] intValue];
        editObj.strLastId = [[arrTruth lastObject]valueForKey:@"pkTruthChallengeID"];
       
    }
    else
    {
        editObj.strTitle = NSLocalizedString(@"Dare", @"");
        
        if ([CurrentLang isEqualToString:@"en"])
        {
            editObj.strValue = [[arrDare objectAtIndex:btn.tag]valueForKey:@"ln_EN"];
        }
        else if([CurrentLang isEqualToString:@"es"])
        {
            editObj.strValue = [[arrDare objectAtIndex:btn.tag]valueForKey:@"ln_ES"];
        }
        else if([CurrentLang isEqualToString:@"fr"])
        {
            editObj.strValue = [[arrDare objectAtIndex:btn.tag]valueForKey:@"ln_FR"];
        }
        else if([CurrentLang isEqualToString:@"de"])
        {
            editObj.strValue = [[arrDare objectAtIndex:btn.tag]valueForKey:@"ln_DE"];
        }
        editObj.strPrimaryKey = [[arrDare objectAtIndex:btn.tag]valueForKey:@"pkDaresChallengeID"];
        editObj.pktruthordare=[[[arrDare objectAtIndex:btn.tag]valueForKey:@"pkDaresChallengeID"] intValue];
        editObj.strGender = [[arrDare objectAtIndex:btn.tag]valueForKey:@"gender"];
        editObj.strPlayers = [[arrDare objectAtIndex:btn.tag]valueForKey:@"minplayers"];
        editObj.strDirtiness = [[arrDare objectAtIndex:btn.tag]valueForKey:@"dirty"];
        editObj.custom=[[[arrDare objectAtIndex:btn.tag]valueForKey:@"source"] intValue];
        editObj.strActive = [[arrDare objectAtIndex:btn.tag]valueForKey:@"active"];
        
        editObj.strLastId = [[arrDare lastObject]valueForKey:@"pkDaresChallengeID"];
     }
    
         editObj.strOrigin = @"Edit";
        
    [self.navigationController pushViewController:editObj animated:YES];
    [editObj release];
}
//Add Button method
-(IBAction)add
{
    EditTruthOrDareViewController *editObj;
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        editObj= [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController_iPad" bundle:nil];
    }
    else
    {
        editObj= [[EditTruthOrDareViewController alloc] initWithNibName:@"EditTruthOrDareViewController" bundle:nil];
    }
    if(flgTruth)
    {    
        editObj.strTitle = NSLocalizedString(@"Truth", @"");
    }
    else
    {
        editObj.strTitle = NSLocalizedString(@"Dare", @"");
    }
    editObj.strOrigin = @"Add";
    [self.navigationController pushViewController:editObj animated:YES];
    [editObj release];
}
//get Truth list as per Filter settings
-(void)getTruthList
{
    NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Filter"];
    NSString *strMin;
    NSString *strMax;
    NSString *strbuildin;
    NSString *strmine;
    NSString *stractive;
    NSString *strinactive;
    NSString *strbothsexes;
    NSString *strformales;
    NSString *strforfemales;
    if([dictFilter count] == 0)
    {
        strMin = @"1";
        strMax = @"6";
        strbuildin = @"1";
        strmine=@"1";
        stractive = @"1";
        strinactive = @"1";
        strbothsexes=@"1";
        strformales=@"1";
        strforfemales=@"1";
        
    }
    else
    {
        
        strMin = [dictFilter valueForKey:@"Min"];
        strMax = [dictFilter valueForKey:@"Max"];
        strbuildin = [dictFilter valueForKey:@"Buid in"];
        strmine = [dictFilter valueForKey:@"Mine"];
        stractive = [dictFilter valueForKey:@"Active"];
        strinactive =[dictFilter valueForKey:@"InActive"];
        strbothsexes=[dictFilter valueForKey:@"For both sexes"];
        strformales=[dictFilter valueForKey:@"For Males"];
        strforfemales=[dictFilter valueForKey:@"For Females"];
    }

    if ([strbuildin isEqualToString:@"1"]) 
    {
        strbuildin=@"0";
    }
    else
    {
        strbuildin=@"3";
    }
    if ([strmine isEqualToString:@"1"]) 
    {
        strmine=@"1";
    }
    else
    {
        strmine=@"5";
    }
    if ([stractive isEqualToString:@"1"])
    {
        stractive=@"1";
    }
    else
    {
        stractive=@"5"; 
    }
    if ([strinactive isEqualToString:@"1"])
    {
        strinactive=@"0";
    }
    else
    {
       strinactive=@"4";
    }
    if ([strbothsexes isEqualToString:@"1"])
    {
        strbothsexes=@"0";
    }
    else
    {
         strbothsexes=@"3";
    }
    if ([strformales isEqualToString:@"1"])
    {
        strformales=@"1";
    }
    else
    {
        strformales=@"7";
    }
    if ([strforfemales isEqualToString:@"1"])
    {
        strforfemales=@"2";
    }
    else
    {
        strforfemales=@"4";
    }
    NSString *stdirty=[self getDirtinessString:strMax:strMin];

    NSString *strQuery=[[[NSString alloc]init]autorelease];
    if ([CurrentLang isEqualToString:@"en"])
    {
            strQuery=[NSString stringWithFormat:@"select * from tblTruth where length(ln_EN)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@')And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblTruth where length(ln_ES)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@')And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblTruth where length(ln_FR)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@')And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblTruth where length(ln_DE)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@')And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];
    }
    self.arrTruth=[self executeQuery:strQuery];
}
-(NSMutableArray *)executeQuery:(NSString*)str
{
	sqlite3_stmt *statement= nil;
	sqlite3 *database1;
	NSString *strPath = [self getDatabasePath];
	NSMutableArray *allDataArray = [[NSMutableArray alloc] init];
	if (sqlite3_open([strPath UTF8String],&database1) == SQLITE_OK)
    {
		if (sqlite3_prepare_v2(database1, [str UTF8String], -1, &statement, NULL) == SQLITE_OK)
        {
			while (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSInteger i = 0;
				NSInteger iColumnCount = sqlite3_column_count(statement);
				NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
				while (i< iColumnCount) 
                {
					NSString *str = [self encodedString:(const unsigned char*)sqlite3_column_text(statement, i)];
                    NSString *strFieldName = [self encodedString:(const unsigned char*)sqlite3_column_name(statement, i)];
					
					[dict setObject:str forKey:strFieldName];
					i++;
				}
				
				[allDataArray addObject:dict];
				[dict release];
			}
		}
		sqlite3_finalize(statement);
	} 
	sqlite3_close(database1);
	return [allDataArray autorelease];
}
-(NSString* )getDatabasePath
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"TruthOrDare.sqlite"];
	return writableDBPath;
}
-(NSString*)encodedString:(const unsigned char *)ch
{
	NSString *retStr;
	if(ch == nil)
		retStr = @"";
	else
		retStr = [NSString stringWithCString:(char*)ch encoding:NSUTF8StringEncoding];
	return retStr;
}
//get Dare list as per Filter settings
-(void)getDareList
{
    NSDictionary *dictFilter = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Filter"];
    NSString *strMin;
    NSString *strMax;
    NSString *strbuildin;
    NSString *strmine;
    NSString *stractive;
    NSString *strinactive;
    NSString *strbothsexes;
    NSString *strformales;
    NSString *strforfemales;
    if([dictFilter count] == 0)
    {
        strMin = @"1";
        strMax = @"6";
        strbuildin = @"1";
        strmine=@"1";
        stractive = @"1";
        strinactive = @"1";
        strbothsexes=@"1";
        strformales=@"1";
        strforfemales=@"1";
    }
   else
   {

    strMin = [dictFilter valueForKey:@"Min"];
    strMax = [dictFilter valueForKey:@"Max"];
    strbuildin = [dictFilter valueForKey:@"Buid in"];
    strmine = [dictFilter valueForKey:@"Mine"];
    stractive = [dictFilter valueForKey:@"Active"];
    strinactive =[dictFilter valueForKey:@"InActive"];
    strbothsexes=[dictFilter valueForKey:@"For both sexes"];
    strformales=[dictFilter valueForKey:@"For Males"];
    strforfemales=[dictFilter valueForKey:@"For Females"];
   }
    if ([strbuildin isEqualToString:@"1"]) {
        strbuildin=@"0";
    }
    else
    {
        strbuildin=@"3";
    }
    if ([strmine isEqualToString:@"1"]) {
        strmine=@"1";
    }
    else
    {
        strmine=@"5";
    }
    if ([stractive isEqualToString:@"1"]) {
        stractive=@"1";
    }
    else
    {
        stractive=@"5"; 
    }
    if ([strinactive isEqualToString:@"1"]) {
        strinactive=@"0";
    }
    else
    {
        strinactive=@"4"; 
    }
    if ([strbothsexes isEqualToString:@"1"]) {
        strbothsexes=@"0";
    }
    else
    {
        strbothsexes=@"3";
    }
    if ([strformales isEqualToString:@"1"]) {
        strformales=@"1";
    }
    else
    {
        strformales=@"7"; 
    }
    if ([strforfemales isEqualToString:@"1"]) {
        strforfemales=@"2";
    }
    else
    {
        strforfemales=@"4";
    }
    NSString *stdirty=[self getDirtinessString:strMax:strMin];

    
    NSString *strQuery=[[[NSString alloc]init]autorelease];
    
    if ([CurrentLang isEqualToString:@"en"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblDare where length(ln_EN)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@') And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];    
    }
    else if([CurrentLang isEqualToString:@"es"])
    {
       strQuery=[NSString stringWithFormat:@"select * from tblDare where length(ln_ES)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@') And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];    
    }
    else if([CurrentLang isEqualToString:@"fr"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblDare where length(ln_FR)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@') And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];
    }
    else if([CurrentLang isEqualToString:@"de"])
    {
        strQuery=[NSString stringWithFormat:@"select * from tblDare where length(ln_DE)>0 And (source='%@'or source='%@') And (active='%@'or active='%@') And (gender='%@'or gender='%@'or gender='%@') And (%@) order by source ASC",strbuildin,strmine,stractive,strinactive,strbothsexes,strformales,strforfemales,stdirty];    
    }
    self.arrDare=[self executeQuery:strQuery];
}
-(NSString *)getDirtinessString:(NSString *)stingmax:(NSString *)stringmin
{
    NSMutableArray *arrDirtinesNumber=[[[NSMutableArray alloc]init] autorelease];
    int max = stingmax.integerValue;
    int min=stringmin.integerValue;
    
    for (int i=min; i<=max; i++) 
    {
        NSString *str=[[NSString alloc ]initWithFormat:@"%d",i];
        [arrDirtinesNumber addObject:str];
        [str release];
    }

    NSString *str;
    str = @"";
    for(int i=0; i<[arrDirtinesNumber count]; i++)
    {
        NSString *str1 = [NSString stringWithFormat:@"dirty='%@'", [arrDirtinesNumber objectAtIndex:i]];
        str = [str stringByAppendingString:str1];
        if(i != [arrDirtinesNumber count] - 1)
            str = [str stringByAppendingString:@" or "];
    }
    return str;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{
    mopubclass.mpAdView.delegate=nil;
    [tblTruth release];
    [activity release];
    [btnBack release];
    [btnTruth release];
    [btnDare release];
    
    self.arrTruth = nil;
    self.arrDare = nil;
    [super dealloc];
}
@end
