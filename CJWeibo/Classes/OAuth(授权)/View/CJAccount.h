//
//  CJAccount.h
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  账号模型



#import <Foundation/Foundation.h>

@interface CJAccount : NSObject <NSCoding>



@property (nonatomic, copy) NSString *access_token;

// 如果服务器返回的数字很大,建议用 long long (比如主键,ID)
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;



// 账号的过期时间
@property (nonatomic, strong) NSDate *expiresTime;




+ (instancetype)accountWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;




@end
