//
//  CJNavigationController.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJNavigationController.h"

@implementation CJNavigationController







/** 系统在第一次使用这个类的时候调用(一个类只会调用一次)
 */
+ (void)initialize
{
    // 1.设置导航栏的主题
    [self setupNavBarTheme];

    // 2.设置BarButtonItem的主题
    [self setupBarButtonItemTheme];
}



/**
 *  设置导航栏的主题
 */
+ (void)setupNavBarTheme
{
    // 取出 appearance
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    // 设置背景图片
    if(!iOS7) //IOS_7.0以前
    {
        //        // 设置返回箭头字的颜色！！！
        //        navBar.tintColor = [UIColor whiteColor];
        
        [navBar setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_background"] forBarMetrics:UIBarMetricsDefault];
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleBlackOpaque;
    }
    
    // 设置标题文字颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    attrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18];
    [navBar setTitleTextAttributes:attrs];
}


/**
 *  设置BarButtonItem的主题
 */
+ (void)setupBarButtonItemTheme
{
    // 取出 appearance
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    // 设置标题文字颜色
    NSMutableDictionary *itemAttrs = [NSMutableDictionary dictionary];
    itemAttrs[NSForegroundColorAttributeName] = iOS7 ? CJColor(234, 103, 7) : [UIColor grayColor];
    itemAttrs[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    itemAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:iOS7 ? 14 : 12];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:itemAttrs forState:UIControlStateHighlighted];

    
    if(!iOS7)
    {
        // 设置按钮背景
        [item setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background_pushed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [item setBackgroundImage:[UIImage imageWithNamed:@"navigationbar_button_background_disabled"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
        
        
//        [item setBackButtonTitlePositionAdjustment:<#(UIOffset)#> forBarMetrics:<#(UIBarMetrics)#>];
        
        
        // 设置返回按钮背景
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButton"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [item setBackButtonBackgroundImage:[UIImage imageNamed:@"NavBackButtonPressed"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    }
}














/**
 *  重写这个方法，能拦截所有的push操作
 *  将所有的navigation中的tabBar全部隐藏
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0)
    {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}



@end
