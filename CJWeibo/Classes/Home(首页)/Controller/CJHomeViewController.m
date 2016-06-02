//
//  CJHomeViewController.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJHomeViewController.h"


@interface CJHomeViewController ()


@property (nonatomic, strong) NSArray *statusFrames;



@end






@implementation CJHomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 1.设置导航栏的内容
    [self setupNavBar];
    
    
    // 2.加载微博数据
    [self setupStatusData];
    
    
    
    
    
}


/**
 *  加载微博数据
 */
- (void)setupStatusData
{
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 说明从服务器返回的 JSON 数据
    //    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // 2.封装请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [CJAccountTool account].access_token;
    
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
         //          // 取出所有的微博数据(每一条微博都是一个字典)
         //          NSArray *dictArray = responseObject[@"statuses"];
         //          // 将字典数据转为模型数据
         //          NSMutableArray *statusArray = [NSMutableArray array];
         //          for (NSDictionary *dict in dictArray)
         //          {
         //              // 创建模型
         //              // 使用了MJExtension框架
         //              CJStatus *status = [CJStatus objectWithKeyValues:dict];
         //              // 添加模型
         //              [statusArray addObject:status];
         //          }
         //          self.statuses = statusArray;
         
         
         
         
         
         // 将字典数组转为模型数组(里面放的就是CJStatus模型)
         NSArray *statusArray = [CJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
         
         
         
         // 创建frame模型对象(将微博数据模型转成 frame 模型)
         NSMutableArray *statusFrameArray = [NSMutableArray array];
         for (CJStatus *status in statusArray)
         {
             CJStatusFrame *statusFrame = [[CJStatusFrame alloc] init];
             // 传递微博模型数据
             statusFrame.status = status;
             [statusFrameArray addObject:statusFrame];
         }
         
         
         
         // 赋值
         self.statusFrames = statusFrameArray;
         
         
         
         // 异步网络请求成功可能会延迟，所以要重新刷新表格
         [self.tableView reloadData];
         
         
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
         CJLog(@"微博数据请求失败！！%@",error);
         
     }];
    
}















/**
 *  设置导航栏的内容
 */
- (void)setupNavBar
{
    // 左边按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted" target:self action:@selector(findFriend)];
    
    // 右边按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted" target:self action:@selector(pop)];
    
    
    // 中间按钮
    CJTitleButton *titleButton = [CJTitleButton titleButton];
    // 图标
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageWithNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    // 根据按钮状态的改变  切换图片
    titleButton.selected = NO;
    // 文字
    [titleButton setTitle:@"哈哈哈哈" forState: UIControlStateNormal];
    // 位置和尺寸
    titleButton.frame = CGRectMake(0, 0, 100, 40);
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
    
    
    
    
    // 设置tableView背景颜色
    self.tableView.backgroundColor = CJColor(226, 226, 226);
    
    // 设置tableView额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, CJStatusTableBorder, 0);
    
}

- (void)findFriend
{
    CJLog(@"点击了CJHomeViewController的leftButton");
}

- (void)pop
{
    CJLog(@"点击了CJHomeViewController的rightButton");
}

- (void)titleClick:(CJTitleButton *)titleButton
{
    titleButton.selected = !titleButton.isSelected;
}









#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.statusFrames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    CJStatusCell *cell = [CJStatusCell cellWithTableView:tableView];
    
    
    // 2.传递frame模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    
    //    // 取出微博模型
    //    CJStatus *status = self.statusFrames[indexPath.row];
    //    // 微博的文字(内容)
    //    cell.textLabel.text = status.text;
    //    // 取出用户模型
    //    CJUser *user = status.user;
    //    // 微博作者的昵称
    //    cell.detailTextLabel.text = user.name;
    //    // 微博作者的头像
    //    // SDWebimage 框架(异步下载图片)
    //    NSString *iconUrl = user.profile_image_url;
    ////    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]];
    ////    cell.imageView.image = [UIImage imageWithData:imageData];
    //    [cell.imageView setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageWithNamed:@"avatar_default_small"]];
    
    
    
    
    // 3.返回cell
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJStatusFrame *statusFrame = self.statusFrames[indexPath.row];
    return statusFrame.cellHeight;
}







//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UIViewController *vc = [[UIViewController alloc] init];
//    vc.view.backgroundColor = [UIColor redColor];
//    [self.navigationController pushViewController:vc animated:YES];
//}


@end
