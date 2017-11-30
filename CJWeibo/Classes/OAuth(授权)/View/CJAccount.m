//
//  CJAccount.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJAccount.h"

@implementation CJAccount


+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}


- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}



/**
 *  从文件中解析对象的时候调用
 */
- (instancetype)initWithCoder:(NSCoder *)decoder
{
    
    NSLog(@"调用了initWithCoder:方法");
    if (self = [super init])
    {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [decoder decodeInt64ForKey:@"remind_in"];
        self.uid = [decoder decodeInt64ForKey:@"uid"];
        
        self.expiresTime = [decoder decodeObjectForKey:@"expiresTime"];
        
        self.name = [decoder decodeObjectForKey:@"name"];
        
        
        
        self.isRealName = [decoder decodeBoolForKey:@"isRealName"];
    }
    return self;
}

/**
 *  将对象写入文件的时候调用
 */
- (void)encodeWithCoder:(NSCoder *)encoder
{
    
    NSLog(@"调用了encodeWithCoder:方法");
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    
    [encoder encodeObject:self.name forKey:@"name"];
    
    [encoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [encoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [encoder encodeInt64:self.uid forKey:@"uid"];
    
    [encoder encodeObject:self.expiresTime forKey:@"expiresTime"];

    
    [encoder encodeBool:self.isRealName forKey:@"isRealName"];
    
}



@end
