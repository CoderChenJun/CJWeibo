//
//  UIBarButtonItem+CJ.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "UIBarButtonItem+CJ.h"

@implementation UIBarButtonItem (CJ)



/**
 *  快读创建一个用来显示图片的 item
 *  @param action    监听方法
 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)Image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setBackgroundImage:[UIImage imageWithNamed:Image] forState:UIControlStateNormal];
    [Button setBackgroundImage:[UIImage imageWithNamed:highImage] forState:UIControlStateHighlighted];
    //    Button.bounds = CGRectMake(0, 0, Button.currentBackgroundImage.size.width, Button.currentBackgroundImage.size.height);
    Button.frame = (CGRect){CGPointZero, Button.currentBackgroundImage.size};
    [Button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:Button];
}



@end
