//
//  UIImage+CJ.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "UIImage+CJ.h"

@implementation UIImage (CJ)

+ (UIImage *)imageWithNamed:(NSString *)name
{
    if (iOS7)
    {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil)// 没有_os7后缀的图片
        {
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    
    // 非 iOS7
    return [UIImage imageNamed:name];
}


+ (UIImage *)resizedImageWithName:(NSString *)name
{
    // 导入原来图片
    UIImage *normal = [UIImage imageNamed:name];
    // 四边不需要拉伸的边距
    CGFloat normalW = normal.size.width * 0.5;
    CGFloat normalH = normal.size.height * 0.5;
    // 设置图片拉伸的最终图片
    return [normal resizableImageWithCapInsets:UIEdgeInsetsMake(normalH, normalW, normalH, normalW)];
}


@end
