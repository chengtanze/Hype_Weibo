//
//  HomeViewController.m
//  Hype_Weibo
//
//  Created by wangsl-iMac on 15/1/9.
//  Copyright (c) 2015年 cheng. All rights reserved.
//

#import "HomeViewController.h"
#import "Weibo_Home_TableViewCell.h"
@interface HomeViewController ()


@property (strong, nonatomic) IBOutlet NSMutableArray * weiboArray;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.Weibo_Home_TableView.delegate = self;
    self.Weibo_Home_TableView.dataSource = self;
    self.Weibo_Home_TableView.rowHeight = 50;
    
    self.weiboArray = [[NSMutableArray alloc]init];
    
    NSDictionary * dicName = @{@"name":@"十万个冷笑话"};
    NSDictionary * dicContext = @{@"Context":@"【Dunkin' Donuts将在中国开设1400家新店面】- 这家咖啡连锁店周四宣布了这一计划，在美国销量下滑之际，该公司正在寻求扩张全球业务。Dunkin' Donuts表示，将与Golden Cup Pte.Ltd.合作，由后者负责于未来20年内在中国开设和运营Dunkin' Donuts连锁店。即将在中国开设的新店面将于今年第四季度开张。"};
    NSDictionary * dicTime = @{@"time":@"4小时前"};
    NSDictionary * dicFrom = @{@"from":@"新浪微博"};
//    NSDictionary * dicHeight = @{@"height":@"0"};
    
    NSMutableDictionary * dicHeight = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0", @"height",nil];
    
    NSMutableArray * user = [[NSMutableArray alloc]initWithObjects: dicName, dicContext, dicFrom, dicTime, dicHeight,nil];
//NSDictionary * dic = @{@"Key":@"123456", @"data":user};
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"123456",@"Key", user, @"data",nil];
//    NSMutableDictionary * key = @{@"Key":@"123456"};
//    NSMutableDictionary * data = [[NSMutableDictionary alloc]initWithObjectsAndKeys:user, @"data", nil];
//    NSMutableArray * dic =  [[NSMutableArray alloc]initWithObjects:key,data, nil];
    
    [self.weiboArray addObject:dic];
    
    NSDictionary * dicName1 = @{@"name":@"企业微助理"};
    NSDictionary * dicContext1 = @{@"Context":@"#网事早知道#微博在成为品牌营销沟通重要平台的同时，也已在各类危机的爆发、传播和升级中扮演起愈加重要的角色，越来越多的企业将微博作为品牌公关的主战场。"};
    NSDictionary * dicTime1 = @{@"time":@"2小时前"};
    NSDictionary * dicFrom1 = @{@"from":@"新浪微博"};
    //    NSDictionary * dicHeight = @{@"height":@"0"};
    
    NSMutableDictionary * dicHeight1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0", @"height",nil];
    
    NSMutableArray * user1 = [[NSMutableArray alloc]initWithObjects: dicName1, dicContext1, dicFrom1, dicTime1, dicHeight1,nil];
    //NSDictionary * dic = @{@"Key":@"123456", @"data":user};
    NSMutableDictionary * dic1 = [[NSMutableDictionary alloc]initWithObjectsAndKeys:@"78910",@"Key", user1, @"data",nil];

    [self.weiboArray addObject:dic1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat height = 0;
    NSDictionary * dic = self.weiboArray[indexPath.row];
    NSString *strHeigth = [[dic objectForKey:@"data"][4] objectForKey:@"height"];
    height = [strHeigth floatValue];
    
    return height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Weibo_Home_TableViewCell"];
    
    Weibo_Home_TableViewCell * cell ;
    cell = [[[NSBundle mainBundle] loadNibNamed:@"Weibo_Home_TableViewCell" owner:self options:nil] objectAtIndex:0];
    NSLog(@"cellForRowAtIndexPath %ld", indexPath.row);
    NSDictionary * dic = self.weiboArray[indexPath.row];

    cell.userName.text = [[dic objectForKey:@"data"][0] objectForKey:@"name"];
    cell.weiboContenx.text = [[dic objectForKey:@"data"][1] objectForKey:@"Context"];
    cell.weiboFrom.text = [[dic objectForKey:@"data"][2] objectForKey:@"from"];
    cell.weiboTime.text = [[dic objectForKey:@"data"][3] objectForKey:@"time"];

    [cell GetTableViewHeight];
    //NSString *strHeigth = [[dic objectForKey:@"data"][4] objectForKey:@"height"];
    NSString *strHeigth = [NSString stringWithFormat:@"%f", cell.tableViewHeight];
    NSMutableDictionary * dicHei = [[NSMutableDictionary alloc]initWithDictionary:[dic objectForKey:@"data"][4] ];
    [dicHei setObject:strHeigth forKey:@"height"];

    [[dic objectForKey:@"data"] setObject:dicHei atIndexedSubscript:4];
    //cell.tableViewHeight = [strHeigth floatValue];
    
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
