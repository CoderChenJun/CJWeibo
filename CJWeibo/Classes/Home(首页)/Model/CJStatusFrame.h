//
//  CJStatusFrame.h
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//
//  一个cell对应一个CJStatusFrame对象


/** 时间的字体 */
#define CJStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define CJStatusSourceFont CJStatusTimeFont


/** 昵称的字体 */
#define CJStatusNameFont [UIFont systemFontOfSize:15]
/** 正文的字体 */
#define CJStatusContentFont CJStatusNameFont


/** 被转发微博的昵称的字体 */
#define CJRetweetNameFont [UIFont systemFontOfSize:13]
/** 被转发微博的正文的字体 */
#define CJRetweetContentFont CJRetweetNameFont


/** 整个tableView 的宽度 */
#define CJStatusTableBorder 5
/** cell的内边框宽度 */
#define CJStatusCellBorder 10




#import <Foundation/Foundation.h>
@class CJStatus;


@interface CJStatusFrame : NSObject

@property (nonatomic, strong) CJStatus *status;




/** 顶部的View */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;

/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;






/** 被转发微博的View(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;





/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolBarF;




/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;



@end


