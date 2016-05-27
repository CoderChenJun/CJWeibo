//
//  CJBadgeButton.h
//  CJWeibo
//
//  Created by app on 16/5/23.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJBadgeButton : UIButton

/**
 *  通过 badgeValue 属性来设置 badgeButton 显示的内容
 */
@property (nonatomic, copy) NSString *badgeValue;

@end
