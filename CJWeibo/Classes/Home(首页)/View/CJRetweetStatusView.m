//
//  CJRetweetStatusView.m
//  CJWeibo
//
//  Created by app on 16/6/2.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJRetweetStatusView.h"


@interface CJRetweetStatusView()


/** 被转发微博作者的昵称 */
@property (nonatomic, strong) UILabel *retweetNameLabel;
/** 被转发微博的正文\内容 */
@property (nonatomic, strong) UILabel *retweetContentLabel;
/** 被转发微博的配图 */
@property (nonatomic, strong) UIImageView *retweetPhotoView;


@end






@implementation CJRetweetStatusView



/**
 *  initWithFrame方法添加子控件
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 1.设置被转发微博的背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_retweet_background" left:0.8 top:0.5 ];// 设置被转发微博区域的背景图片
        
        
        
        
        /** 2.被转发微博作者的昵称 */
        UILabel *retweetNameLabel = [[UILabel alloc] init];
        retweetNameLabel.font = CJRetweetNameFont;// 设置字体
        retweetNameLabel.textColor = CJColor(67, 107, 163);
        retweetNameLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        [self addSubview:retweetNameLabel];
        self.retweetNameLabel = retweetNameLabel;
        
        
        /** 3.被转发微博的正文\内容 */
        UILabel *retweetContentLabel = [[UILabel alloc] init];
        retweetContentLabel.font = CJRetweetContentFont;// 设置字体
        retweetContentLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        retweetContentLabel.numberOfLines = 0;// 设置换行
        retweetContentLabel.textColor = CJColor(90, 90, 90);
        [self addSubview:retweetContentLabel];
        self.retweetContentLabel = retweetContentLabel;
        
        
        /** 4.被转发微博的配图 */
        UIImageView *retweetPhotoView = [[UIImageView alloc] init];
        [self addSubview:retweetPhotoView];
        self.retweetPhotoView = retweetPhotoView;
        
    }
    return self;
}










- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    
    
    
    CJStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    CJUser *user = retweetStatus.user;

    // 1.昵称
    //        self.retweetNameLabel.text = user.name;
    self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
    
    // 2.正文
    self.retweetContentLabel.text = retweetStatus.text;
    self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
    
    // 3.配图
    if (retweetStatus.thumbnail_pic)
    {
        self.retweetPhotoView.hidden = NO;
        self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
        [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
    }
    else
    {
        self.retweetPhotoView.hidden = YES;
    }

    
    
}





@end
