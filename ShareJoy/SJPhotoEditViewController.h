//
//  SJPhotoEditViewController.h
//  Share Joy
//
//  Created by WANGLI on 12-10-19.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeveyPopListView.h"

#import "WBSendView.h"
#import "SJWBAuthorizeViewController.h"

#import "HPGrowingTextView.h"


@interface SJPhotoEditViewController : UIViewController<LeveyPopListViewDelegate,WBSendViewDelegate,WBEngineDelegate,UIPrintInteractionControllerDelegate,HPGrowingTextViewDelegate>{
}

@property (nonatomic,retain) IBOutlet UIImageView *imgView;



@property (nonatomic,assign) IBOutlet UIScrollView *filterScrollView;

@end
