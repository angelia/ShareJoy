//
//  SJPhotoEditViewController.m
//  Share Joy
//
//  Created by WANGLI on 12-10-19.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import "SJPhotoEditViewController.h"

@interface SJPhotoEditViewController (){
    int selectedFilter;
    int photofilter;
    BOOL isStatic;
    BOOL hasBlur;
    BOOL hasAddText;
}
@property (nonatomic,retain) IBOutlet UIBarButtonItem *btn_filter;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *btn_print;

@end

@implementation SJPhotoEditViewController
@synthesize imgView;
@synthesize btn_print;
@synthesize btn_filter;
@synthesize filterScrollView;


- (id)initWithAppKey:(NSString *)theAppKey appSecret:(NSString *)theAppSecret
{
    if (self = [super init])
    {
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        photofilter = 1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor blackColor]];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dismissSelf)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    [self setTitle:@"Edit Photo"];
    
    hasAddText = NO;

}

- (void)dealloc
{
    [super dealloc];
    [imgView release];

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
- (void)createWeibo:(UIImage *)image
{
    NSString *textInput =[[NSString alloc]initWithString:@"#ShareJoy#"];
    WBSendView *sendView = [[WBSendView alloc] initWithAppKey:kWBAppKey appSecret:kWBSAppSecret text:textInput image:image];
    
    [sendView setDelegate:self];
    [sendView show:YES];
    
    [sendView release];
}

- (void)alertWeibo{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Please log in Weibo first!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    
    [alert setTag:7];
    [alert show];
    [alert release];
}

- (void)shareToWeibo{
    WBEngine *engine = [[WBEngine alloc] initWithAppKey:kWBAppKey appSecret:kWBSAppSecret];
    
    if(engine.isLoggedIn == YES){
        
        if(imgView.image){
            NSLog(@"share photo");
            [self createWeibo:imgView.image];
        }
    }
    else{
        [self alertWeibo];
    }
}

-(void)shareToFacebook{
    
}
    
    
- (void)dismissSelf{
    [self  dismissViewControllerAnimated:YES completion:^{}];
}

- (IBAction)shareBtnAction:(id)sender{
    
    NSDictionary *item1 = [NSDictionary dictionaryWithObjectsAndKeys:@"Facebook",@"text",[UIImage imageNamed:@"f_logo.png"],@"img", nil];
    NSDictionary *item2 = [NSDictionary dictionaryWithObjectsAndKeys:@"Sina Weibo",@"text",[UIImage imageNamed:@"weibo_logo.png"],@"img", nil];
    NSDictionary *item3 =[NSDictionary dictionaryWithObjectsAndKeys:@"Save to Camera Roll",@"text",[UIImage imageNamed:@"btn_cameraroll.png"],@"img", nil];
    
    NSArray *items = [[NSArray alloc]initWithObjects:item1,item2,item3,nil];
    
    LeveyPopListView *poplistv = [[LeveyPopListView alloc]initWithTitle:@"Share To" options:items];
    poplistv.delegate = self;
    [self.view addSubview:poplistv];
    [poplistv release];
    [items release];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(NSString *)string {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"Saved to Camera Roll Successfully!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", nil] repeats:YES];
    
    [alert show];
    [alert release];
}

    
#pragma mark LeveyPopListViewDelegate
- (void)leveyPopListView:(LeveyPopListView *)popListView didSelectedIndex:(NSInteger)anIndex{
    
    NSLog(@"pop list view....");
    if(anIndex == 0){
        
    }
    else if (anIndex == 1){

        [self shareToWeibo];
    }
    else if (anIndex == 2){
        
        UIImageWriteToSavedPhotosAlbum (self.imgView.image,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }
}

- (void)leveyPopListViewDidCancel{
    
}

#pragma mark - alert actions

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 7 && buttonIndex == 1){
        
        SJWBAuthorizeViewController *wbViewController = [[SJWBAuthorizeViewController alloc]initWithNibName:@"SJWBAuthorizeViewController" bundle:nil];
        
        [self.navigationController pushViewController:wbViewController animated:YES];
        [wbViewController release];
    }
}
-(void)dismissAlert:(NSTimer *)timer
{
    UIAlertView *alert = [[timer userInfo] objectForKey:@"alert"];
    [alert dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark - WBSendViewDelegate Methods

- (void)sendViewDidFinishSending:(WBSendView *)view
{
    [view hide:YES];
    NSLog(@"send successfully");
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"Weibo is sent successfully！"
													  delegate:nil
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil];
	
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
    [alertView show];
	[alertView release];
}

- (void)sendView:(WBSendView *)view didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    [view hide:YES];
    UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:nil
													   message:@"Failed to send weibo！"
													  delegate:nil
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alertView, @"alert", nil] repeats:YES];
    
	[alertView show];
	[alertView release];
}

- (void)sendViewNotAuthorized:(WBSendView *)view
{
    [view hide:YES];
    NSLog(@"not authorized");
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)sendViewAuthorizeExpired:(WBSendView *)view
{
    [view hide:YES];
    NSLog(@"authorized expired");
    
    [self dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark print photos
- (IBAction)printImage:(id)sender {
    // Obtain the shared UIPrintInteractionController
    UIPrintInteractionController *controller = [UIPrintInteractionController sharedPrintController];
    if(!controller) return;
    
    // We need a completion handler block for printing.
    UIPrintInteractionCompletionHandler completionHandler = ^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
        if(completed && error)
            NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
    };
    
    UIPrintInfo *printInfo = [UIPrintInfo printInfo];
    UIImage *image = imgView.image;
    
    printInfo.outputType = UIPrintInfoOutputPhoto;

    if(!controller.printingItem && image.size.width > image.size.height)
        printInfo.orientation = UIPrintInfoOrientationLandscape;
    
    controller.printInfo = printInfo;
    controller.printingItem = image;
    
    [controller presentAnimated:YES completionHandler:completionHandler];
}

- (void)printInteractionControllerWillPresentPrinterOptions:(UIPrintInteractionController *)printInteractionController{
    
}

#pragma mark - filter images
-(IBAction)toggleFilters:(UIButton *)sender {
    if (photofilter == 2){
        [self hideFilters];
    } else if(photofilter == 1){
        [self showFilters];
    }
    
}
-(void) showFilters {
    NSLog(@"show filters");
    photofilter = 1;
    self.btn_filter.enabled = NO;
    
    CGRect imageRect = self.imgView.frame; //0,50,320,320
    imageRect.origin.y -= 34;//0,50-32,320,320
    
    CGRect sliderScrollFrame = self.filterScrollView.frame;//0,350,320,66
    sliderScrollFrame.origin.y -= self.filterScrollView.frame.size.height; //0,350-66,320,66
    
//    CGRect sliderScrollFrameBackground = self.view.frame;
//    sliderScrollFrameBackground.origin.y -= self.view.frame.size.height-3;
//    
    self.filterScrollView.hidden = NO;
    self.view.hidden = NO;
    [UIView animateWithDuration:0.10
                          delay:0.05
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.imgView.frame = imageRect;
                         self.filterScrollView.frame = sliderScrollFrame;
//                         self.view.frame = sliderScrollFrameBackground;
                     }
                     completion:^(BOOL finished){
                         self.btn_filter.enabled = YES;
                         photofilter = 2;
                     }];
    [self loadFilters];
}

-(void) hideFilters {
    NSLog(@"hide filters");
    photofilter = 2;
    CGRect imageRect = self.imgView.frame;//0,50,320,320
    imageRect.origin.y += 34;//0,50+32,320,320
    
    CGRect sliderScrollFrame = self.filterScrollView.frame;//0,350,320,66
    sliderScrollFrame.origin.y += self.filterScrollView.frame.size.height;//0,350-66,320,66
    
//    CGRect sliderScrollFrameBackground = self.view.frame;
//    sliderScrollFrameBackground.origin.y += self.view.frame.size.height-3;
//    
    [UIView animateWithDuration:0.10
                          delay:0.05
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         self.imgView.frame = imageRect;
                         self.filterScrollView.frame = sliderScrollFrame;
//                         self.view.frame = sliderScrollFrameBackground;
                     }
                     completion:^(BOOL finished){
                         
                         self.btn_filter.enabled = YES;
                         self.filterScrollView.hidden = YES;
                         photofilter = 1;
                     }];
}

-(void) loadFilters {
    for(int i = 0; i < 10; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i + 1]] forState:UIControlStateNormal];
        button.frame = CGRectMake(10+i*(60+10), 5.0f, 60.0f, 60.0f);
        button.layer.cornerRadius = 7.0f;
        
        //use bezier path instead of maskToBounds on button.layer
        UIBezierPath *bi = [UIBezierPath bezierPathWithRoundedRect:button.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(7.0,7.0)];
        
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = button.bounds;
        maskLayer.path = bi.CGPath;
        button.layer.mask = maskLayer;
        
        button.layer.borderWidth = 1;
        button.layer.borderColor = [[UIColor blackColor] CGColor];
        
        [button addTarget:self
                   action:@selector(filterClicked:)
         forControlEvents:UIControlEventTouchUpInside];
        button.tag = i;
        [button setTitle:@"*" forState:UIControlStateSelected];
        if(i == 0){
            [button setSelected:YES];
        }
		[self.filterScrollView addSubview:button];
	}
	[self.filterScrollView setContentSize:CGSizeMake(10 + 10*(60+10), 75.0)];
}

-(void) filterClicked:(UIButton *) sender {
    
    selectedFilter = sender.tag;
//    [self setFilter:sender.tag];
//    [self prepareFilter];
}


#pragma mark - add texts to image
- (IBAction)addTexts:(id)sender
{
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(60, 300, 200, 120)];
//    [textView setEditable:YES];
//    [textView setBackgroundColor:[UIColor redColor]];
//    [textView setTextColor:[UIColor whiteColor]];
//    [self.view addSubview:textView];
//    [textView release];
    
    NSLog(@"add texts...");
    if(!hasAddText){
    CGPoint tp = self.imgView.accessibilityActivationPoint;
    int w = imgView.image.size.width;
    int h = imgView.image.size.height;
    
        HPGrowingTextView *textView = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(tp.x - w/2, tp.y - h/2, w, h)];
        textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        textView.editable = YES;
        
        textView.minNumberOfLines = 1;
        textView.maxNumberOfLines = 6;
        textView.returnKeyType = UIReturnKeyDone; 
        textView.font = [UIFont systemFontOfSize:15.0f];
        textView.delegate = self;
        textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        textView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:textView];
        [textView release];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"You have added Text!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(dismissAlert:) userInfo:[NSDictionary dictionaryWithObjectsAndKeys:alert, @"alert", nil] repeats:YES];

        [alert show];
        [alert release];
    }
}


- (BOOL)growingTextViewShouldReturn:(HPGrowingTextView *)growingTextView{
    if(!hasAddText)
    {
        self.imgView.image = [self addText:self.imgView.image text:growingTextView.text];
        hasAddText = YES;
    }
    
    [growingTextView setHidden:YES];
    return YES;
}

- (UIImage *)addText:(UIImage *)image text:(NSString *)textString{
    int w = image.size.width;
    int h = image.size.height;
    CGPoint p = self.imgView.image.accessibilityFrame.origin;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);

    char* text = (char *)[textString cStringUsingEncoding:NSASCIIStringEncoding];
    CGContextSelectFont(context, "Georgia", 22, kCGEncodingMacRoman);
    CGContextSetTextDrawingMode(context, kCGTextFill);
    CGContextSetRGBFillColor(context, 255, 1, 1, 1);
//    CGContextSetTextMatrix(context, CGAffineTransformMakeRotation( -M_PI/4 ));
    CGContextShowTextAtPoint(context, p.x+10, p.y+10, text, strlen(text));

    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];
    
}


@end
