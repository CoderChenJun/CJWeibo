//
//  CJStatusCell.h
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  首页展示微博数据的cell

#import <UIKit/UIKit.h>
@class CJStatusFrame;
@interface CJStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) CJStatusFrame *statusFrame;

@end
