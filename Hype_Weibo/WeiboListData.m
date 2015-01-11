//
//  WeiboListData.m
//  Hype_Weibo
//
//  Created by cheng on 15/1/11.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "WeiboListData.h"
#import "AFHTTPRequestOperationManager.h"
#import "WBHttpRequest.h"
#import "WeiboSDK.h"

@interface WeiboListData ()<WeiboSDKDelegate>

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

@implementation WeiboListData

-(BOOL)InitWeiboAuth2{
    
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"3965386710"];
    
    self.wbCurrentUserID = @"5462837643";
    self.wbtoken = @"2.00ZcVhxFKO331Eafe2057080SpkIZE";
    
    return YES;
}

-(BOOL)getWeiboList{
    NSString *str=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/friends_timeline.json?access_token=%@&count=10", self.wbtoken];
    
    NSURL *url = [NSURL URLWithString:[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperationManager * opearManager = [AFHTTPRequestOperationManager manager];
    opearManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];//设置相应内容类型
    [opearManager GET:str parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *html  = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        
        //[self ParseDataFromJson:dict];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"发生错误！%@",error);
        
        NSString *html  = operation.responseString;
        NSData* data=[html dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict=[NSJSONSerialization  JSONObjectWithData:data options:0 error:nil];
        NSLog(@"获取到的数据为：%@",dict);
        
    }];
    return YES;
}

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    NSLog(@"didReceiveWeiboResponse");
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"didReceiveWeiboResponse");
    
    if ([response isKindOfClass:WBAuthorizeResponse.class])
    {
        NSString *title = NSLocalizedString(@"认证结果", nil);
        NSString *message = [NSString stringWithFormat:@"%@: %d\nresponse.userId: %@\nresponse.accessToken: %@\n%@: %@\n%@: %@", NSLocalizedString(@"响应状态", nil), (int)response.statusCode,[(WBAuthorizeResponse *)response userID], [(WBAuthorizeResponse *)response accessToken],  NSLocalizedString(@"响应UserInfo数据", nil), response.userInfo, NSLocalizedString(@"原请求UserInfo数据", nil), response.requestUserInfo];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        
        self.wbtoken = [(WBAuthorizeResponse *)response accessToken];
        self.wbCurrentUserID = [(WBAuthorizeResponse *)response userID];
        [alert show];
    }
    
}


@end

