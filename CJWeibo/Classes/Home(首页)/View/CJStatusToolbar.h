//
//  CJStatusToolbar.h
//  CJWeibo
//
//  Created by app on 16/6/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  首页展示微博数据的cell中底部的工具条

#import <UIKit/UIKit.h>

@class CJStatus;

@interface CJStatusToolbar : UIImageView

@property (nonatomic, strong) CJStatus *status;

///**
// *  微博的转发数
// */
//@property (nonatomic, assign) int reposts_count;
//
///**
// *  微博的评论数
// */
//@property (nonatomic, assign) int comments_count;
//
///**
// *  微博的表态数(点赞)
// */
//@property (nonatomic, assign) int attitudes_count;



@end
