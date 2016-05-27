//
//  CJSearchBar.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJSearchBar.h"


@interface CJSearchBar()

//@property (nonatomic, strong) UIImageView *iconView;

@end








@implementation CJSearchBar


+ (instancetype)searchBar
{
    return [[self alloc] init];
}



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 背景
        self.background = [UIImage resizedImageWithName:@"searchbar_textfield_background"];
        // 文字大小
        self.font = [UIFont systemFontOfSize:13];
        
        // 设置搜索框左边的"放大镜"图标
        UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageWithNamed:@"searchbar_textfield_search_icon"]];
        iconView.contentMode = UIViewContentModeCenter;
        iconView.frame = CGRectMake(0, 0, 30, 30);
        self.leftView = iconView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        // 设置搜索框右边的"x"按钮
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        // 设置搜索框的提醒文字
        NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
        attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索" attributes:attrs];
        
        
        // 设置键盘右下角的按钮样式
        self.returnKeyType = UIReturnKeySearch;
        
        // 根据是否输入东西  自动判断键盘上的搜索按钮能否被点击
        self.enablesReturnKeyAutomatically = YES;
        
    }
    return self;
}





- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 设置左边的"放大镜"图标的 frame
    self.leftView.frame = CGRectMake(0, 0, 30, self.frame.size.height);

}



@end
