//
//  CJStatus.m
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  微博模型(一个 CJStatus对象就代表一条微博)

#import "CJStatus.h"

@implementation CJStatus



/**
 *  重写created_at的GET方法,设置成正确显示的格式
 */
- (NSString *)created_at
{
    
//    _created_at == Wed Jun 01 16:01:03 +0800 2016
//    对应的格式 ==    EEE MMM dd HH:mm:ss Z     yyyy
//    CJLog(@"%@", _created_at);

    
    
    
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    [fmt setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];// 须强行转换日期_美国
    NSDate *createdDate = [fmt dateFromString:_created_at];
//    CJLog(@"%@", createdDate);

    
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday)
    {
        // 今天
        if (createdDate.deltaWithNow.hour >= 1)
        {
            return [NSString stringWithFormat:@"%d小时前", createdDate.deltaWithNow.hour];
        }
        else if (createdDate.deltaWithNow.minute >= 1)
        {
            return [NSString stringWithFormat:@"%d分钟前", createdDate.deltaWithNow.minute];
        }
        else
        {
            return @"刚刚";
        }
    }
    else if (createdDate.isYesterday)
    {
        // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else if (createdDate.isThisYear)
    {
        // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
    else
    {
        // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
 
    
}





/**
 *  GET方法会调用很多次,SET方法只调用一次
 */
- (void)setSource:(NSString *)source
{
//    _source == <a href="http://app.weibo.com/t/feed/3o33sO" rel="nofollow">iPhone 6</a>
//    CJLog(@"%@",source);
    
    
    if (source.length != 0)
    {
        int loc = [source rangeOfString:@">"].location + 1;
        int length = [source rangeOfString:@"</"].location - loc;
        source = [source substringWithRange:NSMakeRange(loc, length)];
        
        _source = [NSString stringWithFormat:@"来自 %@", source];
    }

}






//- (NSString *)source
//{
////    _source == <a href="http://app.weibo.com/t/feed/3o33sO" rel="nofollow">iPhone 6</a>
//    CJLog(@"%@",_source);
//
//    int loc = [_source rangeOfString:@">"].location + 1;
//    int length = [_source rangeOfString:@"</"].location - loc;
//    NSString *newSource = [NSString stringWithFormat:@"来自 %@",[_source substringWithRange:NSMakeRange(loc, length)]];
//
//    return [NSString stringWithFormat:@"来自 %@", newSource];
//}






//+ (instancetype)statusWithDict:(NSDictionary *)dict
//{
//    return [[self alloc] initWithDict:dict];
//}
//
//
//- (instancetype)initWithDict:(NSDictionary *)dict
//{
//    if (self = [super init])
//    {
//        self.idstr = dict[@"idstr"];
//        self.text = dict[@"text"];
//        self.source = dict[@"source"];
//        self.reposts_count = [dict[@"reposts_count"] intValue];
//        self.comments_count = [dict[@"comments_count"] intValue];
//        
//        self.user = [CJUser userWithDict:dict[@"user"]];
//    }
//    return self;
//}

@end

