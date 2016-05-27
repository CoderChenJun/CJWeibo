//
//  CJTabBarButton.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//




// 图标的比例
#define CJTabBarButtonImageRatio 0.6

// 按钮的默认状态下文字的颜色
#define CJTabBarButtonTitleColor (iOS7 ? [UIColor grayColor] : [UIColor whiteColor])
// 按钮的选中状态下文字的颜色
#define CJTabBarButtonTitleSelectedColor (iOS7 ? CJColor(234, 103, 7) : CJColor(248, 139, 0))





#import "CJTabBarButton.h"
#import "CJBadgeButton.h"


@interface CJTabBarButton()


/**
 *  提醒数字
 */
@property (nonatomic, strong) CJBadgeButton *badgeButton;




@end









@implementation CJTabBarButton


/** 只要覆盖了这个方法，按钮就不存在高亮状态 */
- (void)setHighlighted:(BOOL)highlighted
{
    // 将父类的方法清空
//    [super setHighlighted:highlighted];
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        // 设置按钮图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 设置按钮文字大小 居中 颜色
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self setTitleColor:CJTabBarButtonTitleColor forState:UIControlStateNormal];
        [self setTitleColor:CJTabBarButtonTitleSelectedColor forState:UIControlStateSelected];
        
        
        // 设置选中按钮的背景图片
        if(!iOS7)
        {
            [self setBackgroundImage:[UIImage imageWithNamed:@"tabbar_slider"] forState:UIControlStateSelected];
        }
        
        
        // 添加一个提醒数字 按钮
        
        CJBadgeButton *badgeButton = [[CJBadgeButton alloc] init];
        
        // badgeButton 的尺寸跟随 CJTabBarButton 的尺寸变化而变化
        badgeButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self addSubview:badgeButton];
        self.badgeButton = badgeButton;
        
        
    }
    return self;
}








/**
 *  设置 item   重写 set 方法
 */
- (void)setItem:(UITabBarItem *)item
{
    // 这里不能用self.item   因为self.item本身就会调用set方法会无限循环   应该用_item调用get方法
    _item = item;
    // 在这里将设置按钮的数据封装成一个 item，将整个 item 传给调用
    
    
    
    // KVO 监听属性变化
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];

    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    
}

/**
 *  KVO 监听需要手动释放
 */
- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];

}


/**
 *  监听到某个对象的属性改变,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 文字
    [self setTitle:self.item.title forState:UIControlStateNormal];
    [self setTitle:self.item.title forState:UIControlStateSelected];

    // 图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
    // 提醒数字
    self.badgeButton.badgeValue = self.item.badgeValue;

    // 设置提醒数字的位置(大小在 CJBadgeButton init 时通过传递过来的 badgeValue 的值进行设置)
    CGFloat badgeX = self.frame.size.width - self.badgeButton.frame.size.width - 10;
    CGFloat badgeY = 2;
    CGRect badgeFrame = self.badgeButton.frame;
    badgeFrame.origin.x = badgeX;
    badgeFrame.origin.y = badgeY;
    self.badgeButton.frame = badgeFrame;
    
    
}










/**
 *  内部图片的 frame
 */
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height * CJTabBarButtonImageRatio;
    
    return CGRectMake(0, 0, imageW, imageH);
}


/**
 *  内部文字的 frame
 */
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * CJTabBarButtonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height * (1 - CJTabBarButtonImageRatio);
    
    return CGRectMake(0, titleY, titleW, titleH);
}


@end
