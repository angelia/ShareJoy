//
//  SJViewController.m
//  Share Joy
//
//  Created by WANGLI on 12-10-18.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJViewController.h"
#import "SJSettingsViewController.h"
#import "SJPhotoEditViewController.h"


@interface SJViewController ()
@property(nonatomic,retain) IBOutlet UIButton *btn_camera;
@property(nonatomic,retain) IBOutlet UIButton *btn_photoAlbums;
@property(nonatomic,retain) IBOutlet UINavigationItem *nav_MainVC;
@property(nonatomic,retain) UINavigationController * navSettingsViewController;
@property(nonatomic,readwrite) int imgPicker;

@end


@implementation SJViewController
@synthesize btn_camera;
@synthesize btn_photoAlbums;
@synthesize nav_MainVC;
@synthesize navSettingsViewController;
@synthesize imgPicker;

// Settings
- (void)launchSettings{
    SJSettingsViewController *settingsViewController = [[SJSettingsViewController alloc]init];
    
    navSettingsViewController = [[UINavigationController alloc]initWithRootViewController:settingsViewController];
    
    [self presentViewController:navSettingsViewController animated:YES completion:^{}];
    [settingsViewController release];
    
}


//camera
-(void)invokeSystemCamera{
    imgPicker = 1;
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.sourceType = sourceType;
	picker.delegate = self;
    picker.allowsEditing = YES;
    [picker.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    
    [self presentViewController:picker animated:YES completion:^{}];
	[picker release];

}

//photo albums
-(void)loadPhotoAlbums
{
    imgPicker = 2;
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
	picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	picker.delegate = self;
    picker.allowsEditing = YES;
    [picker.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    
    [self presentViewController:picker animated:YES completion:^{}];
	[picker release];

}
//launch flickr
- (IBAction)launchflickr:(id)sender
{
    UIImage *img = [UIImage imageNamed:@"f_logo_homescreen.png"];
    
    SJPhotoEditViewController *editViewController = [[SJPhotoEditViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:editViewController];
    
    [self presentViewController:nav animated:YES completion:^{
        editViewController.imgView.image = img;}];
    [editViewController release];
    [nav release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_default.png"]]];
    
    UIBarButtonItem *btn_Settings = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_settings.png"] style:UIBarButtonItemStylePlain target:self action:@selector(launchSettings)];
    [nav_MainVC setLeftBarButtonItem:btn_Settings animated:YES];
    
    
    //launch camera
    [btn_camera addTarget:self action:@selector(invokeSystemCamera) forControlEvents:UIControlEventTouchUpInside];
    [btn_photoAlbums addTarget:self action:@selector(loadPhotoAlbums) forControlEvents:UIControlEventTouchUpInside];
}


- (void)dealloc
{
    [nav_MainVC release];
    [btn_camera release];
    [navSettingsViewController release];
    
    [super dealloc];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - private functions
-(void)savephoto:(UIImage *)image{
    
    SJPhotoEditViewController *photoEditViewController = [[SJPhotoEditViewController alloc]init];
    UINavigationController *navEdit = [[UINavigationController alloc] initWithRootViewController:photoEditViewController];
    
    [self presentViewController:navEdit animated:YES completion:^{
        [photoEditViewController.imgView setImage:image];
        if(imgPicker ==1)
            UIImageWriteToSavedPhotosAlbum (image,nil,nil,nil);
    }];
    
    [photoEditViewController release];
    [navEdit release];
    
}

#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = [[info objectForKey:UIImagePickerControllerEditedImage] retain];
    [self performSelector:@selector(savephoto:)
               withObject:image 
               afterDelay:0.6];
    [picker dismissViewControllerAnimated:YES completion:^{}];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

@end
