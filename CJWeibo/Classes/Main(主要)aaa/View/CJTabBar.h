//
//  CJTabBar.h
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <UIKit/UIKit.h>


@class CJTabBar;

@protocol CJTabBarDelegate <NSObject>

@optional
- (void)tabBar:(CJTabBar *)tabBar didSelectButtonFrom:(int)from to:(int)to;

@end







@interface CJTabBar : UIView

@property (nonatomic, weak) id<CJTabBarDelegate> delegate;

/** 
 *  用来添加一个内部的按钮
 *  imageName 按钮图片
 *  selectedImageName 按钮选中时的图片
 */
- (void)addTabBarWithItem:(UITabBarItem *)item;


@end
