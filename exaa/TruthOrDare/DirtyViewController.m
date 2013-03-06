
#import "DirtyViewController.h"
#import "UserDefaultSettings.h"
@implementation DirtyViewController
@synthesize btnStar1, btnStar2, btnStar3, btnHeart1, btnHeart2, btnLips;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
// when change Dirtiness reset Speed Method
-(void)resetSpeedCountOfPlayer
{
  
    for (int i=0; i<[appDelegate.playerDetailsArray count]; i++) {
        NSMutableDictionary *dict = [appDelegate.playerDetailsArray objectAtIndex:i];
        [dict setObject:@"0" forKey:@"SpeedNo"];
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
//    [self update_UI];
    [super viewWillAppear:YES];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    thisDevice = [UIDevice currentDevice];
     appDelegate = (TruthOrDareAppDelegate *) [UIApplication sharedApplication].delegate;
    dicSettings = [[UserDefaultSettings sharedSetting] retrieveDictionary:@"Settings"];
         
    [self update_UI];
    if([dicSettings count] == 0)
    {
       strClean = @"ON";
       strDirty = @"ON"; 
       strSuperDirty = @"OFF"; 
    }
    else
    {
        strClean = [dicSettings valueForKey:@"Clean"];
        strDirty = [dicSettings valueForKey:@"Dirty"];
        strSuperDirty = [dicSettings valueForKey:@"Super Dirty"];
    }
    strMyDaresOnly=[dicSettings valueForKey:@"My Dares Only"];
    if ([strMyDaresOnly isEqualToString:@"ON"]) {
    
    if(appDelegate.dirtinessLevel == 1)
    {
        if([strClean isEqualToString:@"ON"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                    btnStar2.frame=CGRectMake(frm.origin.x, 55, 45, 45);
                    btnStar1.frame = CGRectMake((frm.origin.x)-55, 55, 45, 45);
                    btnStar3.frame = CGRectMake((frm.origin.x)+55, 55, 45, 45);
//                }
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {

                    CGRect frm = self.view.frame;
                    frm.origin.x=(self.view.frame.size.width/2)-(26/2);
                    btnStar2.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                    btnStar1.frame=CGRectMake((frm.origin.x)-30, 28, 26, 23);
                    btnStar3.frame=CGRectMake((frm.origin.x)+30, 28, 26, 23);


                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                
            }
        
            btnHeart1.hidden = YES;
            btnHeart2.hidden = YES;
            btnLips.hidden = YES;
        }
        else if([strDirty isEqualToString:@"ON"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                    btnHeart1.frame=CGRectMake((frm.origin.x)-30, 55, 45, 45);
                    btnHeart2.frame = CGRectMake((frm.origin.x)+30, 55, 45, 45);                    


                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            }
            else{

                    CGRect frm = self.view.frame;
                    frm.origin.x=(self.view.frame.size.width/2)-(26/2);
                    btnHeart1.frame=CGRectMake((frm.origin.x)-15, 28, 26, 23);
                    btnHeart2.frame=CGRectMake((frm.origin.x)+20, 28, 26, 23);


                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            }
            btnStar1.hidden = YES;
            btnStar2.hidden = YES;
            btnStar3.hidden = YES;
            btnLips.hidden = YES;
        }
        else
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                    btnLips.frame=CGRectMake(frm.origin.x, 55, 45, 45);

                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }else{
                if ([CurrentLang isEqualToString:@"en"]) {
                    btnLips.frame = CGRectMake(109, 28, 26, 23);
                }
                else
                {
                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                    btnLips.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                }

                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            }
            
            btnStar1.hidden = YES;
            btnStar2.hidden = YES;
            btnStar3.hidden = YES;
            btnHeart1.hidden = YES;
            btnHeart2.hidden = YES;
           
        }
    }
    else if(appDelegate.dirtinessLevel == 2)
    {
        if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                    btnStar3.frame=CGRectMake(frm.origin.x, 55, 45, 45);
                    
                    btnStar1.frame = CGRectMake((frm.origin.x)-110, 55, 45, 45);
                    btnStar2.frame = CGRectMake((frm.origin.x)-55, 55, 45, 45);
                    btnHeart1.frame = CGRectMake((frm.origin.x)+55, 59, 45, 45);
                    btnHeart2.frame = CGRectMake((frm.origin.x)+110, 59, 45, 45);
//                }
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];

            }else{

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                    btnStar3.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                    btnStar2.frame=CGRectMake((frm.origin.x)-30, 28, 26, 23);
                    btnStar1.frame=CGRectMake((frm.origin.x)-60, 28, 26, 23);
                    btnHeart1.frame=CGRectMake((frm.origin.x)+30, 28, 26, 23);
                    btnHeart2.frame=CGRectMake((frm.origin.x)+60, 28, 26, 23);

                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                
            }
            
            btnLips.hidden = YES;
        }
        else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                    btnStar2.frame=CGRectMake((frm.origin.x)-10, 55, 45, 45);
                    btnStar1.frame = CGRectMake((frm.origin.x)-65, 55, 45, 45);
                    btnStar3.frame = CGRectMake((frm.origin.x)+45, 55, 45, 45);
                    btnLips.frame = CGRectMake((frm.origin.x)+100, 59, 45, 45);

            
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
            }else{

                    CGRect frm = self.view.frame;
                    frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                    btnStar2.frame=CGRectMake((frm.origin.x)-10, 28, 26, 23);
                    btnStar1.frame = CGRectMake((frm.origin.x)-40,28, 26, 23);
                    btnStar3.frame = CGRectMake((frm.origin.x)+20,28, 26, 23);
                    btnLips.frame = CGRectMake((frm.origin.x)+50, 28, 26, 23);
                    

                
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            }
            btnHeart1.hidden = YES;
            btnHeart2.hidden = YES;

        }
        else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    CGRect frm = self.view.frame;
                    frm.origin.x = (self.view.frame.size.width/2)-(45/2);
                    btnHeart2.frame = CGRectMake(frm.origin.x, 57, 45, 45);
                    btnHeart1.frame = CGRectMake((frm.origin.x)-55, 57, 45, 45);
                    btnLips.frame = CGRectMake((frm.origin.x)+55, 57, 45, 45);

                
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
            }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x = (self.view.frame.size.width/2)-(26/2);
                        btnHeart2.frame = CGRectMake(frm.origin.x, 28, 26, 23);
                        btnHeart1.frame = CGRectMake((frm.origin.x)-30,28, 26, 23);
                        btnLips.frame = CGRectMake((frm.origin.x)+30, 28, 26, 23);


                
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];                
            }
            
            btnStar1.hidden = YES;
            btnStar2.hidden = YES;
            btnStar3.hidden = YES;
        }
            
    }
        else
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) 
            {
                CGRect frm = self.view.frame;
                frm.origin.x = (self.view.frame.size.width/2)-(45/2);
                btnStar3.frame=CGRectMake((frm.origin.x)-30, 57, 45, 45);
                
                btnStar1.frame=CGRectMake((frm.origin.x)-150, 57, 45, 45);
                btnStar2.frame=CGRectMake((frm.origin.x)-90, 57, 45, 45);
                btnHeart1.frame=CGRectMake((frm.origin.x)+33, 60, 45, 45);
                btnHeart2.frame=CGRectMake((frm.origin.x)+95, 60, 45, 45);
                btnLips.frame=CGRectMake((frm.origin.x)+160, 60, 45, 45);

                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];  

            }else{
                
                CGRect frm = self.view.frame;
                frm.origin.x = (self.view.frame.size.width/2)-(26/2);
                btnStar3.frame=CGRectMake((frm.origin.x)-20, 28, 26, 23);
                
                btnStar1.frame=CGRectMake((frm.origin.x)-90, 28, 26, 23);
                btnStar2.frame=CGRectMake((frm.origin.x)-55, 28, 26, 23);
                btnHeart1.frame=CGRectMake((frm.origin.x)+15, 28, 26, 23);
                btnHeart2.frame=CGRectMake((frm.origin.x)+53, 28, 26, 23);
                btnLips.frame=CGRectMake((frm.origin.x)+90, 28, 26, 23);

                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];                  
            }
        }
   
        [self  checkformine];
    }   
    else
    {
        if(appDelegate.dirtinessLevel == 1)
        {
            if([strClean isEqualToString:@"ON"])
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                        btnStar2.frame=CGRectMake(frm.origin.x, 55, 45, 45);
                        btnStar1.frame = CGRectMake((frm.origin.x)-55, 55, 45, 45);
                        btnStar3.frame = CGRectMake((frm.origin.x)+55, 55, 45, 45);
//                    }
                    [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    
                }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x=(self.view.frame.size.width/2)-(26/2);
                        btnStar2.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                        btnStar1.frame=CGRectMake((frm.origin.x)-30, 28, 26, 23);
                        btnStar3.frame=CGRectMake((frm.origin.x)+30, 28, 26, 23);
//                    }
                    
                    [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                }
                btnHeart1.hidden = YES;
                btnHeart2.hidden = YES;
                btnLips.hidden = YES;
            }
            else if([strDirty isEqualToString:@"ON"])
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                        btnHeart1.frame=CGRectMake((frm.origin.x)-30, 55, 45, 45);
                        btnHeart2.frame = CGRectMake((frm.origin.x)+30, 55, 45, 45);
                 
                    [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];                    
                    
                }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x=(self.view.frame.size.width/2)-(26/2);
                        btnHeart1.frame=CGRectMake((frm.origin.x)-15, 28, 26, 23);
                        btnHeart2.frame=CGRectMake((frm.origin.x)+20, 28, 26, 23);
                   
                    
                    [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];                    
                }
                
                btnStar1.hidden = YES;
                btnStar2.hidden = YES;
                btnStar3.hidden = YES;
                btnLips.hidden = YES;
            }
            else
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                        btnLips.frame=CGRectMake(frm.origin.x, 55, 45, 45);
                    
                    [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                }else{
                    if ([CurrentLang isEqualToString:@"en"]) {
                        btnLips.frame = CGRectMake(109, 28, 26, 23);
                    }
                    else
                    {
                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                        btnLips.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                    }
                    
                    [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];                    
                }
                
                btnStar1.hidden = YES;
                btnStar2.hidden = YES;
                btnStar3.hidden = YES;
                btnHeart1.hidden = YES;
                btnHeart2.hidden = YES;
                
            }
        }
        else if(appDelegate.dirtinessLevel == 2)
        {
            if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                        btnStar3.frame=CGRectMake(frm.origin.x, 55, 45, 45);
                        btnStar1.frame = CGRectMake((frm.origin.x)-110, 55, 45, 45);
                        btnStar2.frame = CGRectMake((frm.origin.x)-55, 55, 45, 45);
                        btnHeart1.frame = CGRectMake((frm.origin.x)+55, 59, 45, 45);
                        btnHeart2.frame = CGRectMake((frm.origin.x)+110, 59, 45, 45);


                    
                    [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                    
                }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                        btnStar3.frame=CGRectMake(frm.origin.x, 28, 26, 23);
                        btnStar2.frame=CGRectMake((frm.origin.x)-30, 28, 26, 23);
                        btnStar1.frame=CGRectMake((frm.origin.x)-60, 28, 26, 23);
                        btnHeart1.frame=CGRectMake((frm.origin.x)+30, 28, 26, 23);
                        btnHeart2.frame=CGRectMake((frm.origin.x)+60, 28, 26, 23);
                   
                    [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                    [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                }
                
                btnLips.hidden = YES;
            }
            else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (45/2);
                        btnStar2.frame=CGRectMake((frm.origin.x)-10, 55, 45, 45);
                        btnStar1.frame = CGRectMake((frm.origin.x)-65, 55, 45, 45);
                        btnStar3.frame = CGRectMake((frm.origin.x)+45, 55, 45, 45);
                        btnLips.frame = CGRectMake((frm.origin.x)+100, 59, 45, 45);

                    [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                    [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];                    
                }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x =(self.view.frame.size.width/2) - (26/2);
                        btnStar2.frame=CGRectMake((frm.origin.x)-10, 28, 26, 23);
                        btnStar1.frame = CGRectMake((frm.origin.x)-40,28, 26, 23);
                        btnStar3.frame = CGRectMake((frm.origin.x)+20,28, 26, 23);
                        btnLips.frame = CGRectMake((frm.origin.x)+50, 28, 26, 23);

                   
                    
                    [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                    [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                    [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                    [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];                    
                }
               
                btnHeart1.hidden = YES;
                btnHeart2.hidden = YES;
                
            }
            else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
            {
                if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                        CGRect frm = self.view.frame;
                        frm.origin.x = (self.view.frame.size.width/2)-(45/2);
                        btnHeart2.frame = CGRectMake(frm.origin.x, 57, 45, 45);
                        btnHeart1.frame = CGRectMake((frm.origin.x)-55, 57, 45, 45);
                        btnLips.frame = CGRectMake((frm.origin.x)+55, 57, 45, 45);
                   

                    [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                    [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                }else{

                        CGRect frm = self.view.frame;
                        frm.origin.x = (self.view.frame.size.width/2)-(26/2);
                        btnHeart2.frame = CGRectMake(frm.origin.x, 28, 26, 23);
                        btnHeart1.frame = CGRectMake((frm.origin.x)-30,28, 26, 23);
                        btnLips.frame = CGRectMake((frm.origin.x)+30, 28, 26, 23);
              
                    
                    [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                    [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                    [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                }
                
                btnStar1.hidden = YES;
                btnStar2.hidden = YES;
                btnStar3.hidden = YES;
            }
        }
        else
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {

                    
                    CGRect frm = self.view.frame;
                    frm.origin.x = (self.view.frame.size.width/2)-(45/2);
                    btnStar3.frame=CGRectMake((frm.origin.x)-30, 57, 45, 45);
                    
                    btnStar1.frame=CGRectMake((frm.origin.x)-150, 57, 45, 45);
                    btnStar2.frame=CGRectMake((frm.origin.x)-90, 57, 45, 45);
                    btnHeart1.frame=CGRectMake((frm.origin.x)+33, 60, 45, 45);
                    btnHeart2.frame=CGRectMake((frm.origin.x)+95, 60, 45, 45);
                    btnLips.frame=CGRectMake((frm.origin.x)+160, 60, 45, 45);
                
                
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }else{
//                if ([CurrentLang isEqualToString:@"de"]||[CurrentLang isEqualToString:@"es"]||[CurrentLang isEqualToString:@"fr"]) {
                    
                    CGRect frm = self.view.frame;
                    frm.origin.x = (self.view.frame.size.width/2)-(26/2);
                    btnStar3.frame=CGRectMake((frm.origin.x)-20, 28, 26, 23);
                    
                    btnStar1.frame=CGRectMake((frm.origin.x)-90, 28, 26, 23);
                    btnStar2.frame=CGRectMake((frm.origin.x)-55, 28, 26, 23);
                    btnHeart1.frame=CGRectMake((frm.origin.x)+15, 28, 26, 23);
                    btnHeart2.frame=CGRectMake((frm.origin.x)+53, 28, 26, 23);
                    btnLips.frame=CGRectMake((frm.origin.x)+90, 28, 26, 23);
              //  }
                
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];                
            }
        }
        [self checkdirtiness];
    }
    

}


-(void)checkdirtiness
{
    if (appDelegate.changedirtiness==YES) {
        if (appDelegate.dirtystartValue==1) {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];   
            }
        }
        else if(appDelegate.dirtystartValue==2)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
        }
        else if(appDelegate.dirtystartValue==3)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];        
            }
        }
        else if(appDelegate.dirtystartValue==4)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal]; 
                
            }
        }
        else if(appDelegate.dirtystartValue==5)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal]; 
                
            }
        }
        else if(appDelegate.dirtystartValue==6)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal]; 

            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];                
            }
        }
    }
    else
    {
        if (appDelegate.dirtystartValue==1) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
        }
        else if(appDelegate.dirtystartValue==2)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];

            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];

            }
                   }
        else if(appDelegate.dirtystartValue==3)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
        }
        else if(appDelegate.dirtystartValue==4)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 

            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];         
            }
        }
        else if(appDelegate.dirtystartValue==5)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 
                
            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal]; 
                
            }
        }
        else if(appDelegate.dirtystartValue==6)
        {
            if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal]; 

            }
            else {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];        
            }
        }

    }
         
}
// if My Dare on set Dirtiness
-(void)checkformine
{

    if ( appDelegate.Dirtyvalue==1) {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    else if( appDelegate.Dirtyvalue==2)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            
        }
    }
    else if( appDelegate.Dirtyvalue==3)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
        }
    }
    else if( appDelegate.Dirtyvalue==4)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 
            
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal]; 
        }
    }
    else if( appDelegate.Dirtyvalue==5)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal]; 
            
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal]; 
            
        }
    }
    else if(appDelegate.Dirtyvalue==6)
    {
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal]; 
            
        }
        else {
            [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
            [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal]; 
            [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
            [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
        }
    }
  
}


#pragma mark custom methods

//Update Images method
-(void)update_UI
{
    UIImage *imgDirtiness = nil;
    NSString *strImg = nil;
    
    if(thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        strImg = [NSString stringWithFormat:@"dirtiness_box_iPad_%@",CurrentLang];
        imgDirtiness = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strImg ofType:@"png"]];
        imgViewDirtiness.image=imgDirtiness;
    }
    else
    {
        strImg = [NSString stringWithFormat:@"dirtiness_%@",CurrentLang];
        imgDirtiness = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:strImg ofType:@"png"]];
        
        CGRect fr = self.view.frame;
        fr.size = imgDirtiness.size;
        self.view.frame = fr;
        
        CGRect imgFr = imgViewDirtiness.frame;
        imgFr.size = imgDirtiness.size;
        imgViewDirtiness.frame = imgFr;
        
        imgViewDirtiness.image=imgDirtiness;        
    }
    strImg = nil;
    [strImg release];
}

// Change Dirtiness method
-(IBAction)changeDirtiness:(id)sender
{
    [FlurryAnalytics logEvent:@"DirtinessEdited"];
    if([appDelegate.arrDelegateMaleDare count] > 0)
    {
        [appDelegate.arrDelegateMaleDare removeAllObjects];
        [appDelegate.arrMaleDareChallengeId removeAllObjects];
    }
    if([appDelegate.arrDelegateMaleTruth count] > 0)
    {
        [appDelegate.arrDelegateMaleTruth removeAllObjects];
        [appDelegate.arrMaleTruthChallengeId removeAllObjects];
    }
    if([appDelegate.arrDelegateFemaleDare count] > 0)
    {
        [appDelegate.arrDelegateFemaleDare removeAllObjects];
        [appDelegate.arrFemaleDareChallengeId removeAllObjects];
    }
    if([appDelegate.arrDelegateFemaleTruth count] > 0)
    {
        [appDelegate.arrDelegateFemaleTruth removeAllObjects];
        [appDelegate.arrFemaleTruthChallengeId removeAllObjects];
    }
 appDelegate.changedirtiness=YES;
     UIButton *btn = (UIButton *)sender;
    appDelegate.flagfilter=TRUE;
    if ([strMyDaresOnly isEqualToString:@"ON"]) 
    {
   
    
    if(btn.tag == 1)
    {
        appDelegate.Dirtyvalue=1;
        appDelegate.dirtystartValueformine=1;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnStar1.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
        }
        else{
            if([btnStar1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        }
    }
    if(btn.tag == 2)
    {
           appDelegate.Dirtyvalue=2;
         appDelegate.dirtystartValueformine=2;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnStar2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            
        }
        else{
            if([btnStar2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
        
        }
    }
    if(btn.tag == 3)
    {
          appDelegate.Dirtyvalue=3;
        appDelegate.dirtystartValueformine=3;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnStar3.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }

        }
        else{
            if([btnStar3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            
        }
    }
    if(btn.tag == 4)
    {
        appDelegate.Dirtyvalue=4;
         appDelegate.dirtystartValueformine=4;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            if([btnHeart1.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
        }
        else{
            
            if([btnHeart1.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        }

    }
   if(btn.tag == 5)
    {
           appDelegate.Dirtyvalue=5;
            appDelegate.dirtystartValueformine=5;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnHeart2.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips_iPad.png"] forState:UIControlStateNormal];
                
            }
            
        }
        else{
            if([btnHeart2.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            
        }
    }
    if(btn.tag == 6)
    {
        appDelegate.Dirtyvalue=6;
        appDelegate.dirtystartValueformine=6;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnLips.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
                
            }

        }
        else{
            if([btnLips.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
            }

        }        
    }
   [self checkdirtinessValue];
    }
    else
    {
  
    if(btn.tag == 1){
         appDelegate.dirtystartValue=1;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnStar1.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
        }
        else{
            if([btnStar1.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        }
    }
    if(btn.tag == 2)
    {
         appDelegate.dirtystartValue=2;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            
            if([btnStar2.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
        }
        else{
            
            if([btnStar2.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star2.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }            
        }

    }
    if(btn.tag == 3)
    {
         appDelegate.dirtystartValue=3;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnStar3.currentImage isEqual:[UIImage imageNamed:@"star-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }

        }
        else{
            if([btnStar3.currentImage isEqual:[UIImage imageNamed:@"star1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        
        }

    }
    if(btn.tag == 4)
    {
         appDelegate.dirtystartValue=4;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnHeart1.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
            }
            
        }
        else{
            if([btnHeart1.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart2.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
            }
        
        }

    }
    if(btn.tag == 5)
    {
         appDelegate.dirtystartValue=5;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnHeart2.currentImage isEqual:[UIImage imageNamed:@"heart-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip_iPad.png"] forState:UIControlStateNormal];
                
            }

        }
        else{
            if([btnHeart2.currentImage isEqual:[UIImage imageNamed:@"heart1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips2.png"] forState:UIControlStateNormal];
                
            }
        
        }

    }
    if(btn.tag == 6)
    {
         appDelegate.dirtystartValue=6;
        
        if (thisDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {
            if([btnLips.currentImage isEqual:[UIImage imageNamed:@"lip-hover_iPad.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart-hover_iPad.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lip-hover_iPad.png"] forState:UIControlStateNormal];
                
            }

        }
        else{
            if([btnLips.currentImage isEqual:[UIImage imageNamed:@"lips1.png"]])
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [btnStar1 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar2 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnStar3 setImage:[UIImage imageNamed:@"star1.png"] forState:UIControlStateNormal];
                [btnHeart1 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnHeart2 setImage:[UIImage imageNamed:@"heart1.png"] forState:UIControlStateNormal];
                [btnLips setImage:[UIImage imageNamed:@"lips1.png"] forState:UIControlStateNormal];
                
            }

        }        
    }

    }
    [self resetSpeedCountOfPlayer];
}
// Set Dirtiness Value 
-(void)checkdirtinessValue
{

    appDelegate.dirtinessLevel = 0;
    
    if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        appDelegate.dirtinessLevel = 3;
    else if(([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"]) || ([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]) || ([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"]))
        appDelegate.dirtinessLevel = 2;
    else 
        appDelegate.dirtinessLevel = 1;
    if(appDelegate.dirtinessLevel == 1)
    {
        if([strClean isEqualToString:@"ON"])
        {
            
            appDelegate.dirtystartValue=1;
        }
        else if([strDirty isEqualToString:@"ON"])
        {
            
            appDelegate.dirtystartValue=4;
        }
        else if([strSuperDirty isEqualToString:@"ON"])
        {
            
            appDelegate.dirtystartValue=6;
            
        }
        
        
        
    }
    else if(appDelegate.dirtinessLevel == 2)
    {
        if([strClean isEqualToString:@"ON"]&&[strDirty isEqualToString:@"ON"])
        {
            
            appDelegate.dirtystartValue=1;
        }
        else if([strClean isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
            
            appDelegate.dirtystartValue=1;
            
            
        }
        else if([strDirty isEqualToString:@"ON"]&&[strSuperDirty isEqualToString:@"ON"])
        {
           
            appDelegate.dirtystartValue=4;
            
        }
        
    }
    else if(appDelegate.dirtinessLevel == 3)
    {
        
        appDelegate.dirtystartValue=1;
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
    strDirty=nil;
    [strDirty release];
    strSuperDirty=nil;
    [strSuperDirty release];
    strClean=nil;
    [strClean release];
}

@end
