//
//  SJWBSettingsViewController.m
//  Share Joy
//
//  Created by WANGLI on 12-10-19.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJWBSettingsViewController.h"

@interface SJWBSettingsViewController ()
@property (nonatomic,retain) IBOutlet UIButton *btn_wbSign;
@property (nonatomic,retain) SJWBAuthorizeViewController *wbAuthorizeViewController;
@property (nonatomic,retain)  WBEngine *engine;
@end

@implementation SJWBSettingsViewController
@synthesize btn_wbSign;
@synthesize wbAuthorizeViewController;
@synthesize engine;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        wbAuthorizeViewController  = [[SJWBAuthorizeViewController alloc]init];
        engine = wbAuthorizeViewController.weiboEngine;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [btn_wbSign addTarget:self action:@selector(wbSignIn) forControlEvents:UIControlEventTouchUpInside];
    self.title = @"Sina Weibo";
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    btn_wbSign.backgroundColor = [UIColor clearColor];
    
}

-(void) viewDidAppear:(BOOL)animated{
    
    if (engine.isLoggedIn == NO ||engine.isAuthorizeExpired == YES) {
        [btn_wbSign setTitle:@"Log in" forState:UIControlStateNormal];
        [btn_wbSign removeTarget:self action:@selector(wbSignOut) forControlEvents:UIControlEventTouchUpInside];
                [btn_wbSign addTarget:self action:@selector(wbSignIn) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (engine.isLoggedIn == YES) {
        [btn_wbSign setTitle:@"Log out" forState:UIControlStateNormal];
        [btn_wbSign removeTarget:self action:@selector(wbSignIn) forControlEvents:UIControlEventTouchUpInside];
        [btn_wbSign addTarget:self action:@selector(wbSignOut) forControlEvents:UIControlEventTouchUpInside];

//        [wbName setText:self.weiBoEngine.userID];
    }
}

-(void)dealloc
{
    [super dealloc];
    [wbAuthorizeViewController release];
//    [engine release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 
#pragma mark private functions
-(void)dismissSelf:(NSNotification *) notification{
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)wbSignIn{
    
    [self.navigationController pushViewController:wbAuthorizeViewController animated:YES];
}

-(void)wbSignOut{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Sign Out" message:@"Are you sure you want to sign out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles: @"Yes",nil];
    
    [alert setTag:6];
    [alert show];
    [alert release];
}


#pragma mark Alert view
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if(alertView.tag == 6 && buttonIndex == 1){
         [engine logOut];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
