//
//  CJAccountTool.m
//  CJWeibo
//
//  Created by app on 16/5/25.
//  Copyright © 2016年 ChenJun. All rights reserved.
//


#import "CJAccountTool.h"
#import "CJAccount.h"

#define CJAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingString:@"account.data"]


@implementation CJAccountTool


+ (void)saveAccount:(CJAccount *)account
{
//    // 取出沙盒 Document 的路径
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    // 拼接全路径
//    NSString *file = [doc stringByAppendingString:@"account.data"];
//    // 存储
//    [NSKeyedArchiver archiveRootObject:account toFile:file];
    
    
    
    // 取出当前时间
    NSDate *now = [NSDate date];
    // 计算出账号过期的时间,保存
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    
    
    [NSKeyedArchiver archiveRootObject:account toFile:CJAccountFile];

}




+ (CJAccount *)account
{
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingString:@"account.data"];
//    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    
    
    
    
    
    // 取出账号
    CJAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:CJAccountFile];

    // 判断账号是否过期
    NSDate *now = [NSDate date];
//    NSOrderedAscending = -1L, NSOrderedSame, NSOrderedDescending
    if ([now compare:account.expiresTime] == NSOrderedAscending)
    {
        // 还没有过期
        CJLog(@"account.expiresTime > now");
        return account;
    }
    else
    {
        // 账号已过期过期
        CJLog(@"account.expiresTime < now");
        return nil;
    }
    
}

@end
