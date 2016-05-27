//
//  CJTabBarViewController.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJTabBarViewController.h"
#import "CJHomeViewController.h"
#import "CJMessageViewController.h"
#import "CJDiscoverViewController.h"
#import "CJMeViewController.h"
#import "CJTabBar.h"


@interface CJTabBarViewController ()<CJTabBarDelegate>



/**
 *  自定义的tabbar
 */
@property (nonatomic, strong) CJTabBar *myTabBar;




@end






@implementation CJTabBarViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // 1.初始化 tabBar
    [self setupTabBar];
    
    // 2.初始化所有的子控制器
    [self setupAllChildViewControllers];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    for (UIView *child in self.tabBar.subviews)
    {
        if ([child isKindOfClass:[UIControl class]])
        {
            [child removeFromSuperview];
        }
    }
}





/**
 *  初始化 tabBar
 */
- (void)setupTabBar
{
    
    CJTabBar *myTabBar = [[CJTabBar alloc] init];
    myTabBar.frame = self.tabBar.bounds;
    myTabBar.delegate = self;
    
    [self.tabBar addSubview:myTabBar];
    self.myTabBar = myTabBar;
}
#pragma mark - 实现CJTabBar的代理方法
- (void)tabBar:(CJTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to
{
    
    self.selectedIndex = to;
    
    // 设置转场动画
    CATransition *anim = [CATransition animation];
    // 水滴💧效果
    anim.type = @"rippleEffect";
    anim.duration = 1.0;
    
    [self.view.layer addAnimation:anim forKey:nil];
}











/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    CJHomeViewController *home = [[CJHomeViewController alloc] init];
    home.tabBarItem.badgeValue = @"1";
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    
    
    // 2.消息
    CJMessageViewController *message = [[CJMessageViewController alloc] init];
    message.tabBarItem.badgeValue = @"17";
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    

    // 3.广场
    CJDiscoverViewController *discover = [[CJDiscoverViewController alloc] init];
    discover.tabBarItem.badgeValue = @"999";

    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    
    
    // 4.我
    CJMeViewController *me = [[CJMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    
    
    
    
}





/**
 *  重构的初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中时的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
//    home.tabBarItem.title = @"首页";
//    home.navigationItem.title = @"首页";
    
    
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithNamed:imageName];
    
    
    // 设置选中的 tabBar 图标
    UIImage *selectedImage = [UIImage imageWithNamed:selectedImageName];
    if (iOS7)
    {
        // iOS7设置不渲染效果
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    else
    {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    
    
    // 2.包装一个导航控制器
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    
    
    // 3.添加tabbar内部的按钮
    [self.myTabBar addTabBarWithItem:childVc.tabBarItem];
}




@end
