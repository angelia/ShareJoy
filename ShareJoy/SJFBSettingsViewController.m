//
//  SJFBSettingsViewController.m
//  ShareJoy
//
//  Created by WANGLI on 12-11-1.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJFBSettingsViewController.h"

@interface SJFBSettingsViewController ()
@property (retain, nonatomic) IBOutlet FBProfilePictureView *profilePic;
@property (retain, nonatomic) IBOutlet FBLoginView *fbLogin;
@property (strong, nonatomic) IBOutlet UILabel *labelFirstName;

@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

@end

@implementation SJFBSettingsViewController

@synthesize profilePic = _profilePic;
@synthesize loggedInUser = _loggedInUser;
@synthesize labelFirstName = _labelFirstName;

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
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Facebook";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - facebook

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    // first get the buttons set for login mode
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    // here we use helper properties of FBGraphUser to dot-through to first_name and
    // id properties of the json response from the server; alternatively we could use
    // NSDictionary methods such as objectForKey to get values from the my json object
    self.labelFirstName.text = [NSString stringWithFormat:@"Hello %@!", user.first_name];
    // setting the profileID property of the FBProfilePictureView instance
    // causes the control to fetch and display the profile picture for the user
    self.profilePic.profileID = user.id;
    self.loggedInUser = user;
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    
    self.profilePic.profileID = nil;
    self.labelFirstName.text = nil;
}

@end
