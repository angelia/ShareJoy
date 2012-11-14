//
//  SJWBAuthorizeViewController.m
//  Share Joy
//
//  Created by WANGLI on 12-10-19.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJWBAuthorizeViewController.h"
#import "WBAuthorizeWebView.h"

@interface SJWBAuthorizeViewController ()

@end

@implementation SJWBAuthorizeViewController
@synthesize weiboEngine;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBAppKey appSecret:kWBSAppSecret];
        [engine setDelegate:self];
        [engine setRedirectURI:@"http://"];
        self.weiboEngine = engine;
        [engine release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissSelf:) name:@"pupupwbviewcontoller" object:nil];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;

 
}
- (void)viewWillAppear:(BOOL)animated
{
    if (weiboEngine.isLoggedIn == NO||weiboEngine.isAuthorizeExpired == YES) {
        [weiboEngine logIn];
        [self.view addSubview:weiboEngine.authorize.authorizeWebView];
    }
}

-(void) dealloc
{
    [super dealloc];
    [weiboEngine release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark private functions
-(void)dismissSelf:(NSNotification *) notification{
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark weibo engine
- (void)engineAlreadyLoggedIn:(WBEngine *)engine
{
    if ([engine isUserExclusive])
    {
        UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
                                                           message:@"Please log out first！" 
                                                          delegate:nil
                                                 cancelButtonTitle:@"OK" 
                                                 otherButtonTitles:nil];
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
        [alertView setTag:1];
        [alertView show];
        [alertView release];
    }
}

- (void)engineDidLogIn:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"Log in successfully！" 
													  delegate:nil
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
    [alertView setTag:2];
	[alertView show];
	[alertView release];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"weibo--log in successfully");
    
}

- (void)engine:(WBEngine *)engine didFailToLogInWithError:(NSError *)error
{
    NSLog(@"didFailToLogInWithError: %@", error);
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"log in failed！" 
													  delegate:nil
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
    [alertView setTag:3];
	[alertView show];
	[alertView release];
    
}

- (void)engineDidLogOut:(WBEngine *)engine
{
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil 
													   message:@"log out successfully！" 
													  delegate:nil
											 cancelButtonTitle:@"OK" 
											 otherButtonTitles:nil];
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
    [alertView setTag:4];
	[alertView show];
	[alertView release];
//    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"weibo--log out successfully");
}

#pragma mark
-(void)dismissAlert:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo] objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

@end
