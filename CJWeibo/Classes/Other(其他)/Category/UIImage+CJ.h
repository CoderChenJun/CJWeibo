//
//  UIImage+CJ.h
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CJ)


/**
 *  加载图片
 *
 *  @param name 图片名
 */
+ (UIImage *)imageWithNamed:(NSString *)name;


/**
 *  返回一张通过最中心点进行拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;


/**
 *  传入百分比,返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;


@end
