//
//  HomeViewController.h
//  Hype_Weibo
//
//  Created by wangsl-iMac on 15/1/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *Weibo_Home_TableView;

@end
