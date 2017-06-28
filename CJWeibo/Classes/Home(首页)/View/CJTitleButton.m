//
//  CJTitleButton.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//


// 图标宽度
#define CJTitleButtonImageWidth 20


#import "CJTitleButton.h"







@implementation CJTitleButton


+ (instancetype)titleButton
{
    return [[CJTitleButton alloc] init];
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 点击按钮时，高亮状态下不改变图片样式
        self.adjustsImageWhenHighlighted = NO;
        
        // 设置图片 在 imageView 中居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 设置文字 在 titleLabel 中居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        
        // 背景
        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
        
        // 文字颜色
        [self setTitleColor:CJColor(45, 45, 45) forState: UIControlStateNormal];
        // 文字大小
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];

        
    }
    return self;
}





- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    
    CGFloat imageW = CJTitleButtonImageWidth;
    CGFloat imageH = contentRect.size.height;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = 0;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}


- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleW = contentRect.size.width - CJTitleButtonImageWidth;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}


- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据title计算自己的宽度
    CGFloat titleW = [title sizeWithFont:self.titleLabel.font].width;
    
    CGRect frame = self.frame;
    frame.size.width = titleW + CJTitleButtonImageWidth + 5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}


@end
