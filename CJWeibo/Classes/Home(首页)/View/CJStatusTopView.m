//
//  CJStatusTopView.m
//  CJWeibo
//
//  Created by app on 16/6/2.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJStatusTopView.h"
#import "CJRetweetStatusView.h"


@interface CJStatusTopView()


/** 头像 */
@property (nonatomic, strong) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, strong) UIImageView *vipView;
/** 配图 */
@property (nonatomic, strong) CJPhotosView *photosView;

/** 昵称 */
@property (nonatomic, strong) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, strong) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, strong) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, strong) UILabel *contentLabel;





/** 被转发微博的View(父控件) */
@property (nonatomic, strong) CJRetweetStatusView *retweetView;



@end













@implementation CJStatusTopView




/**
 *  计算文字尺寸
 *
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸
 */
- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}









/**
 *  initWithFrame方法添加子控件
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 0.能够与用户交互
        self.userInteractionEnabled = YES;
        
        
        
        // 1.设置被转发微博的背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];// 设置圆角背景图片
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];// 设置高亮状态下圆角背景图片
        
        
        
        
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;// 设置会员图标居中
        [self addSubview:vipView];
        self.vipView = vipView;
        
        
        
        
        
        
        
        
        
        /** 4.配图 */
        CJPhotosView *photosView = [[CJPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = CJStatusNameFont;// 设置字体
        nameLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = CJStatusTimeFont;// 设置字体
        timeLabel.textColor = CJColor(245, 140, 19);// 设置字体的颜色
        timeLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = CJStatusSourceFont;// 设置字体
        sourceLabel.textColor = CJColor(135, 135, 135);// 设置字体的颜色
        sourceLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;// 设置换行
        contentLabel.font = CJStatusContentFont;// 设置字体
        sourceLabel.textColor = CJColor(39, 39, 39);// 设置字体的颜色
        contentLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        
        
        
        
        
        /** 9.被转发微博的View(父控件) */
        CJRetweetStatusView *retweetView = [[CJRetweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
        
        
    }
    return self;
}








/**
 *  在这个方法中设置子控件的frame数据和显示数据
 */
- (void)setStatusFrame:(CJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1. 设置原创微博数据
    [self setupOriginalData];
    
    // 2.设置被转发微博数据
    [self  setupRetweetData];
    
}

/**
 *  设置原创微博数据
 */
- (void)setupOriginalData
{
    // 1.取出模型数据
    CJStatus *status = self.statusFrame.status;
    CJUser *user = status.user;
    
    // 2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithNamed:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.mbtype > 2)
    {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = CJColor(230, 70, 0);// 如果是会员,设置昵称文字颜色
    }
    else
    {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];// 如果不是会员,昵称文字黑色
    }
    
    // 5.时间
    self.timeLabel.text = status.created_at;
    // 因为时间显示的内容随时变化,所以需重新计算frame
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + CJStatusCellBorder * 0.5;
    CGSize timeLabelSize = [self sizeWithText:status.created_at font:CJStatusTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelSize.width, timeLabelSize.height);
    
    
    
    
    // 6.来源
    self.sourceLabel.text = status.source;
    // 因为时间显示的内容随时变化,所以需重新计算frame
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + CJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [self sizeWithText:status.source font:CJStatusSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.sourceLabel.frame = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelSize.width, sourceLabelSize.height);
    
    
    
    
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.pic_urls.count)
    {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
    }
    else
    {
        self.photosView.hidden = YES;
    }
}


/**
 *  设置被转发微博数据
 */
- (void)setupRetweetData
{
    
    CJStatus *retweetStatus = self.statusFrame.status.retweeted_status;
    
    // 1.父控件retweetView
    // 如果有转发微博,赋值数据并显示
    if (retweetStatus)
    {
        
        self.retweetView.hidden = NO;
        
        // 2.设置整体的frame
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 3.传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    }
    else
    {
        self.retweetView.hidden = YES;
    }
    
}





@end
