//
//  CJAccountTool.h
//  CJWeibo
//
//  Created by app on 16/5/25.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  账号管理工具类



#import <Foundation/Foundation.h>

@class CJAccount;



@interface CJAccountTool : NSObject



/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+ (void)saveAccount:(CJAccount *)account;



/**
 *  读取账号信息
 *
 *  @return 返回需要读取的账号
 */
+ (CJAccount *)account;


@end
