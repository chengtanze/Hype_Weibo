//
//  Weibo_Home_TableViewCell.h
//  Hype_Weibo
//
//  Created by wangsl-iMac on 15/1/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Weibo_Home_TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headPic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *weiboTime;
@property (weak, nonatomic) IBOutlet UILabel *weiboFrom;
@property (weak, nonatomic) IBOutlet UILabel *weiboContenx;
@property (nonatomic) CGFloat tableViewHeight;
@property (weak, nonatomic) IBOutlet UIView *imageGroup;
@property (weak, nonatomic) IBOutlet UIView *transmitBtn;
@property (weak, nonatomic) IBOutlet UIView *leaveMSG;
@property (weak, nonatomic) IBOutlet UIView *praiseBTN;
@property (weak, nonatomic) IBOutlet UIImageView *iamgeBack;

-(CGFloat)GetTableViewHeight;
-(void)UpDataWeiboContext;
@end
