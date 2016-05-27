//
//  CJWeiboTool.m
//  CJWeibo
//
//  Created by app on 16/5/25.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJWeiboTool.h"

#import "CJTabBarViewController.h"
#import "CJNewfeatureViewController.h"



@implementation CJWeiboTool




+ (void)chooseRootController
{
    
    
    // 取出沙盒中存储的上次使用软件的版本号
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *lastVersion = [defaults stringForKey:@"VersionCode"];
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];
    
    // 比较版本号，判断是否第一次使用新版本！
    if ([currentVersion isEqualToString:lastVersion])
    {
        // 显示状态栏
        [UIApplication sharedApplication].statusBarHidden = NO;
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CJTabBarViewController alloc] init];
    }
    else// 第一次使用新版本  显示新特性
    {
        [UIApplication sharedApplication].keyWindow.rootViewController = [[CJNewfeatureViewController alloc] init];
        
        // 存储新版本
        [defaults setObject:currentVersion forKey:@"VersionCode"];
        [defaults synchronize];
    }

    
}

@end
