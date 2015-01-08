//
//  ViewController.h
//  Hype_Weibo
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiboSDK.h"
@interface ViewController : UIViewController<WeiboSDKDelegate>
- (IBAction)Login:(id)sender;

- (IBAction)GetFans:(id)sender;

@end

