//
//  CJTabBar.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJTabBar.h"

@interface CJTabBar()


@property (nonatomic, strong) CJTabBarButton *selectedButton;

@property (nonatomic, strong) NSMutableArray *tabBarButtons;



/**
 *  加号按钮
 */
@property (nonatomic, strong) UIButton *plusButton;



@end



@implementation CJTabBar



- (NSMutableArray *)tabBarButtons
{
    if(_tabBarButtons == nil)
    {
        _tabBarButtons = [NSMutableArray array];
    }
    return _tabBarButtons;
}





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        if (!iOS7)// 非 iOS7下，设置 tabbar 的背景图片
        {
            self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"tabbar_background"]];
        }
        
        // 添加一个加号按钮
        UIButton *plusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 背景 background
        [plusButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusButton setBackgroundImage:[UIImage imageWithNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        // 加号 image
        [plusButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusButton setImage:[UIImage imageWithNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        
        // 设置大小
        plusButton.bounds = CGRectMake(0, 0, plusButton.currentBackgroundImage.size.width, plusButton.currentBackgroundImage.size.height);
        
        [self addSubview:plusButton];
        
        self.plusButton = plusButton;
        
    }
    return self;
}




/**
 *  设置按钮的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    
    
    // 调整中间 加号按钮的 frame
    self.plusButton.center = CGPointMake(w * 0.5, h * 0.5);
    
    
    
    // 调整 4 个 按钮的 frame
    CGFloat buttonW = w / self.subviews.count;
    CGFloat buttonH = h;
    CGFloat buttonY = 0;
    for (int index = 0 ; index < self. tabBarButtons.count ; index++)
    {
        // 1.取出 4 个 按钮
        CJTabBarButton *button = self.tabBarButtons[index];
        // 2. 设置 4 个 按钮的 frame
        CGFloat buttonX = index * buttonW;
        if (index > 1)
        {
            buttonX += buttonW;
        }
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        // 3.绑定 4 个 按钮的 tag
        button.tag = index;
    }
}



/**
 *  添加按钮  并且设置数据及监听
 */
- (void)addTabBarWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
    CJTabBarButton *button = [[CJTabBarButton alloc] init];
    [self addSubview:button];
    
    // 2.添加按钮到数组中去
    [self.tabBarButtons addObject:button];
    
    // 3.设置数据
    button.item = item;
    /**
     * 将设置数据封装到 CJTabBarButton 中
     * [button setTitle:item.title forState:UIControlStateNormal];
     * [button setImage:item.image forState:UIControlStateNormal];
     * [button setImage:item.selectedImage forState:UIControlStateSelected];
     * [button setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
     */
    
    // 4.监听按钮点击
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 5.默认选中第0个位置的按钮（点击了这个按钮）
    if(self.tabBarButtons.count == 1)
    {
        [self buttonClick:button];
    }
    
}


/** 监听5个tarBar按钮的点击 */
- (void)buttonClick:(CJTabBarButton *)button
{
    // 0.切换子控制器  通知代理
    if([self.delegate respondsToSelector:@selector(tabBar:didSelectButtonFrom:to:)])
    {
        [self.delegate tabBar:self didSelectButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 1.让当前选中的按钮取消选状态
    self.selectedButton.selected = NO;
    // 让当前选中的按钮取消“不能被点击”
    self.selectedButton.userInteractionEnabled = YES;
    
    // 2.让新点击的按钮选中
    button.selected = YES;
    // 让新点击的按钮“不能被点击”
    button.userInteractionEnabled = NO;
    
    // 3.让新点击的按钮成为“当前选中按钮”
    self.selectedButton = button;

}



@end
