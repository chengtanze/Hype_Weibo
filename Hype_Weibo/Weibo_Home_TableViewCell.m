//
//  Weibo_Home_TableViewCell.m
//  Hype_Weibo
//
//  Created by wangsl-iMac on 15/1/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "Weibo_Home_TableViewCell.h"

@implementation Weibo_Home_TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.tableViewHeight = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)UpDataWeiboContext{
    
}

-(CGFloat)GetTableViewHeight{
    self.tableViewHeight = self.headPic.frame.size.height;
    
    
    UIFont * font = self.weiboContenx.font;
    NSDictionary *attributes = @{NSFontAttributeName: font};//[UIFont fontWithName:@"HelveticaNeue" size:14]
    CGRect rect = [self.weiboContenx.text boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:attributes
                                     context:nil];
    NSLog(@"TableViewCell Height :%f", rect.size.height);
    self.tableViewHeight += rect.size.height;
    self.tableViewHeight += 10;
    
    return self.tableViewHeight;
}


@end
