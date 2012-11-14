//
//  SJCloudViewController.m
//  ShareJoy
//
//  Created by WANGLI on 12-10-21.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJCloudViewController.h"
#import "SJPhotoEditViewController.h"

@interface SJCloudViewController ()
@property (nonatomic, retain) IBOutlet UINavigationItem *navItem;
@property (nonatomic, retain) IBOutlet UINavigationBar *navBar;

@end

@implementation SJCloudViewController
@synthesize navItem;
@synthesize navBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];

    UIBarButtonItem *btn_left = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleBordered target:self action:@selector(returnToHomePage)];
    [self.navItem setLeftBarButtonItem:btn_left animated:YES];
    self.navBar.barStyle = UIBarStyleBlackTranslucent;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)returnToHomePage{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
