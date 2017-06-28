//
//  NSDate+CJ.h
//  CJWeibo
//
//  Created by app on 16/6/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CJ)



/**
 *  是否为今天
 */
- (BOOL)isToday;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;

/**
 *  是否为今年
 */
- (BOOL)isThisYear;


/**
 *  返回一个只有 年月日 的时间
 */
- (NSDate *)dateWithYMD;



/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;




@end
