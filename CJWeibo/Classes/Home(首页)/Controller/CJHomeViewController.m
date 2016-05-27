//
//  CJHomeViewController.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJHomeViewController.h"


@interface CJHomeViewController ()


@property (nonatomic, strong) NSArray *statuses;



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
          self.statuses = [CJStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
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
    
    return self.statuses.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.创建cell
    static NSString *ID = @"cell";
    // 从缓存池中取cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，则重新创建
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    // 2.设置cell的数据
    
    // 取出微博模型
    CJStatus *status = self.statuses[indexPath.row];
    // 微博的文字(内容)
    cell.textLabel.text = status.text;
    // 取出用户模型
    CJUser *user = status.user;
    // 微博作者的昵称
    cell.detailTextLabel.text = user.name;
    // 微博作者的头像
    // SDWebimage 框架(异步下载图片)
    NSString *iconUrl = user.profile_image_url;
//    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:iconUrl]];
//    cell.imageView.image = [UIImage imageWithData:imageData];
    [cell.imageView setImageWithURL:[NSURL URLWithString:iconUrl] placeholderImage:[UIImage imageWithNamed:@"new_feature_share_false"]];
    
    
    
    
    
    // 3.返回cell
    return cell;
}







- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
