//
//  SJWBAuthorizeViewController.h
//  Share Joy
//
//  Created by WANGLI on 12-10-19.
//  Copyright (c) 2012年 WANG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBEngine.h"

#define kWBAppKey  @"2715428532"
#define kWBSAppSecret @"7ed370402248a7498b93551be57a42ed"

//Oauth
#define wbOAuthUrl @"https://api.weibo.com/oauth2/authorize?client_id=2715428532"

@interface SJWBAuthorizeViewController : UIViewController<WBEngineDelegate>{
    
}
@property (nonatomic,retain)     WBEngine *weiboEngine;

@end
