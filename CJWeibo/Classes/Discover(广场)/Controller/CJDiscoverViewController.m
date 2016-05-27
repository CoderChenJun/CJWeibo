//
//  CJDiscoverViewController.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJDiscoverViewController.h"

@interface CJDiscoverViewController ()

@end

@implementation CJDiscoverViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置搜索框
    CJSearchBar *searchBar = [CJSearchBar searchBar];
    // 尺寸
    searchBar.frame = CGRectMake(0, 0, 300, 30);
    
    // 设置导航栏标题内容为搜索框
    self.navigationItem.titleView = searchBar;
    
}









#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 20;
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
    cell.textLabel.text = @"cccccccccc";
    
    
    // 3.返回cell
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor blueColor];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
