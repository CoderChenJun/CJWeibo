//
//  UIBarButtonItem+CJ.h
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CJ)

/**
 *  快读创建一个用来显示图片的 item
 *  @param action    监听方法
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)Image highImage:(NSString *)highImage target:(id)target action:(SEL)action;


@end
