//
//  ViewController.m
//  Hype_Weibo
//
//  Created by cheng on 15/1/7.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "AFHTTPRequestOperationManager.h"
#import "WBHttpRequest.h"
//3965386710
//https://api.weibo.com/oauth2/default.html

//2.00ZcVhxFKO331Eafe2057080SpkIZE
//5462837643

//chengtanze@gmail.com
//Hype@5162291.com
@interface ViewController ()

@property (strong, nonatomic) NSString *wbtoken;
@property (strong, nonatomic) NSString *wbCurrentUserID;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:@"3965386710"];
    
    self.wbCurrentUserID = @"5462837643";
    self.wbtoken = @"2.00ZcVhxFKO331Eafe2057080SpkIZE";

}
//https://api.weibo.com/oauth2/authorize?client_id=3965386710&response_type=code&redirect_uri=https://api.weibo.com/oauth2/default.html

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)Login:(id)sender {
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = @"https://api.weibo.com/oauth2/default.html";
        request.scope = @"all";
        request.userInfo = @{@"SSO_From": @"ViewController",
                             @"Other_Info_1": [NSNumber numberWithInt:123],
                             @"Other_Info_2": @[@"obj1", @"obj2"],
                             @"Other_Info_3": @{@"key1": @"obj1", @"key2": @"obj2"}};
        BOOL sucss = [WeiboSDK sendRequest:request];
    
}

- (IBAction)GetFans:(id)sender {
    
//    [WBHttpRequest requestForRenewAccessTokenWithRefreshToken:@"discussion" queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        DemoRequestHanlder(httpRequest, result, error);
//    }];
    
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WBHttpRequest requestForFollowersListOfUser:self.wbCurrentUserID withAccessToken:self.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        
        DemoRequestHanlder(httpRequest, result, error);
        
    }];
    
//    [WBHttpRequest requestForStatusIDsFromCurrentUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        
//        DemoRequestHanlder(httpRequest, result, error);
//    }];
    
//    [WBHttpRequest requestForFriendsListOfUser:myDelegate.wbCurrentUserID withAccessToken:myDelegate.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
//        DemoRequestHanlder(httpRequest, result, error);
//    }];
    
    //NSString *str=[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?access_token=%@&uid=%@", myDelegate.wbtoken,myDelegate.wbCurrentUserID];
    //NSString *str=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/public_timeline.json?access_token=%@&count=1", self.wbtoken];
    NSString *str=[NSString stringWithFormat:@"https://api.weibo.com/2/statuses/friends_timeline.json?access_token=%@&count=1", self.wbtoken];
    
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
        
    }];
}

void DemoRequestHanlder(WBHttpRequest *httpRequest, id result, NSError *error)
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    if (error)
    {
        title = NSLocalizedString(@"请求异常", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",error]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    else
    {
        title = NSLocalizedString(@"收到网络回调", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",result]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    
    [alert show];

}
@end
