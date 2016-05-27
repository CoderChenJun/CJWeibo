//
//  CJBadgeButton.m
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJBadgeButton.h"

@implementation CJBadgeButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.hidden = YES;
        self.userInteractionEnabled = NO;
        [self setBackgroundImage:[UIImage resizedImageWithName:@"main_badge"] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:11];
        
    }
    return self;
}


/**
 *  重写 badgeValue 的 set 方法,将传递过来的 badgeValue 的值进行设置
 */
- (void)setBadgeValue:(NSString *)badgeValue
{
    
#warning set 方法中需要另外书写 copy
    _badgeValue = [badgeValue copy];
    
    if(badgeValue)
    {
        self.hidden = NO;
        // 设置文字
        [self setTitle:badgeValue forState:UIControlStateNormal];
        
//        // 设置 frame
//        CGFloat badgeW = self.currentBackgroundImage.size.width;
//        if (badgeValue.length > 1)
//        {
//            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
//            badgeW = badgeSize.width + 10;
//        }
//        CGFloat badgeH = self.currentBackgroundImage.size.height;
//        CGFloat badgeX = self.frame.size.width - badgeW;
//        CGFloat badgeY = 0;
//        self.frame = CGRectMake(badgeX, badgeY, badgeW, badgeH);
        
        
        
        
        
        // 设置 frame
        CGRect frame = self.frame;
        CGFloat badgeH = self.currentBackgroundImage.size.height;
        CGFloat badgeW = self.currentBackgroundImage.size.width;
        if (badgeValue.length > 1)
        {
            CGSize badgeSize = [badgeValue sizeWithFont:self.titleLabel.font];
            badgeW = badgeSize.width + 10;
        }
        frame.size.width = badgeW;
        frame.size.height = badgeH;
        self.frame = frame;
        
    }
    else
    {
        self.hidden = YES;
    }

    
}


@end
