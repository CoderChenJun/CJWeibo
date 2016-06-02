//
//  CJStatusCell.m
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJStatusCell.h"
#import "CJStatusToolbar.h"
#import "CJRetweetStatusView.h"
#import "CJStatusTopView.h"




@interface CJStatusCell()

/** 顶部的View */
@property (nonatomic, strong) CJStatusTopView *topView;

/** 被转发微博的View(父控件) */
@property (nonatomic, strong) CJRetweetStatusView *retweetView;

/** 微博的工具条 */
@property (nonatomic, strong) CJStatusToolbar *statusToolBar;


@end













@implementation CJStatusCell





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




+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    // 从缓存池中取cell
    CJStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    // 如果缓存池中没有，则重新创建
    if(cell == nil)
    {
        cell = [[CJStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        
        
        // 设置 cell 的背景色透明
        cell.backgroundColor = [UIColor clearColor];
        
        
    }
    return cell;
}









- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
        // 1.添加原创微博内部的子控件
        [self setupOriginalSubviews];
        
        // 2.添加被转发微博内部的子控件
        [self setupRetweetSubviews];
        
        // 3.添加微博的工具条
        [self setupStatusToolBar];
        
    }
    return self;
}

/**
 *  添加原创微博内部的子控件
 */
- (void)setupOriginalSubviews
{
    
#warning 设置cell选中时的背景(还未做)
    // 设置cell选中时的背景
//    UIImageView *bgView = [[UIImageView alloc] init];
//    bgView.image = [UIImage resizedImageWithName:@"common_card_background_highlighted"];
//    bgView.backgroundColor = [UIColor redColor];
    self.selectedBackgroundView = [[UIView alloc] init];
    
    
    
    /** 1.顶部的View */
    CJStatusTopView *topView = [[CJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
    
//    /** 2.头像 */
//    UIImageView *iconView = [[UIImageView alloc] init];
//    [self.topView addSubview:iconView];
//    self.iconView = iconView;
//    
//    
//    /** 3.会员图标 */
//    UIImageView *vipView = [[UIImageView alloc] init];
//    vipView.contentMode = UIViewContentModeCenter;// 设置会员图标居中
//    [self.topView addSubview:vipView];
//    self.vipView = vipView;
//    
//    
//    /** 4.配图 */
//    UIImageView *photoView = [[UIImageView alloc] init];
//    [self.topView addSubview:photoView];
//    self.photoView = photoView;
//    
//    
//    
//    
//    /** 5.昵称 */
//    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.font = CJStatusNameFont;// 设置字体
//    nameLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    [self.topView addSubview:nameLabel];
//    self.nameLabel = nameLabel;
//    
//    
//    /** 6.时间 */
//    UILabel *timeLabel = [[UILabel alloc] init];
//    timeLabel.font = CJStatusTimeFont;// 设置字体
//    timeLabel.textColor = CJColor(245, 140, 19);// 设置字体的颜色
//    timeLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    [self.topView addSubview:timeLabel];
//    self.timeLabel = timeLabel;
//    
//    
//    /** 7.来源 */
//    UILabel *sourceLabel = [[UILabel alloc] init];
//    sourceLabel.font = CJStatusSourceFont;// 设置字体
//    sourceLabel.textColor = CJColor(135, 135, 135);// 设置字体的颜色
//    sourceLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    [self.topView addSubview:sourceLabel];
//    self.sourceLabel = sourceLabel;
//    
//    
//    /** 8.正文\内容 */
//    UILabel *contentLabel = [[UILabel alloc] init];
//    contentLabel.numberOfLines = 0;// 设置换行
//    contentLabel.font = CJStatusContentFont;// 设置字体
//    sourceLabel.textColor = CJColor(39, 39, 39);// 设置字体的颜色
//    contentLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    [self.topView addSubview:contentLabel];
//    self.contentLabel = contentLabel;
    
}

/**
 *  添加被转发微博内部的子控件
 */
- (void)setupRetweetSubviews
{
    
    /** 1.被转发微博的View(父控件) */
    CJRetweetStatusView *retweetView = [[CJRetweetStatusView alloc] init];
    [self.topView addSubview:retweetView];
    self.retweetView = retweetView;
    
    
//    /** 2.被转发微博作者的昵称 */
//    UILabel *retweetNameLabel = [[UILabel alloc] init];
//    retweetNameLabel.font = CJRetweetNameFont;// 设置字体
//    retweetNameLabel.textColor = CJColor(67, 107, 163);
//    retweetNameLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    [self.retweetView addSubview:retweetNameLabel];
//    self.retweetNameLabel = retweetNameLabel;
//    
//    
//    /** 3.被转发微博的正文\内容 */
//    UILabel *retweetContentLabel = [[UILabel alloc] init];
//    retweetContentLabel.font = CJRetweetContentFont;// 设置字体
//    retweetContentLabel.backgroundColor = [UIColor clearColor];// Label背景色透明
//    retweetContentLabel.numberOfLines = 0;// 设置换行
//    retweetContentLabel.textColor = CJColor(90, 90, 90);
//    [self.retweetView addSubview:retweetContentLabel];
//    self.retweetContentLabel = retweetContentLabel;
//    
//    
//    /** 4.被转发微博的配图 */
//    UIImageView *retweetPhotoView = [[UIImageView alloc] init];
//    [self.retweetView addSubview:retweetPhotoView];
//    self.retweetPhotoView = retweetPhotoView;
    
    
}

/**
 *  添加微博的工具条
 */
- (void)setupStatusToolBar
{
    
    /** 1.微博的工具条 */
    CJStatusToolbar *statusToolBar = [[CJStatusToolbar alloc] init];
    // 设置背景图片,包装在CJStatusToolbar内部
    [self.contentView addSubview:statusToolBar];
    self.statusToolBar = statusToolBar;

    
}










/**
 *  拦截frame的设置,在这里设置cell的frame
 */
- (void)setFrame:(CGRect)frame
{
    frame.origin.x = CJStatusTableBorder;
    frame.origin.y += CJStatusTableBorder;
    frame.size.height -= CJStatusTableBorder;
    
    frame.size.width -= CJStatusTableBorder * 2;// 注：还要在CJStatusFrame   - (void)setStatus:(CJStatus *)status方法中   设置cell的宽度   CGFloat cellW = [UIScreen mainScreen].bounds.size.width - 10;
    
    [super setFrame:frame];
    
    
    
    
    //    CJLog(@"cell的X值 : %f",frame.origin.x);
    //    CJLog(@"cell的宽度 : %f",frame.size.width);
    
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
    
    // 3.设置微博工具条数据
    [self  setupStatusToolBarData];
}



/**
 *  设置原创微博数据
 */
- (void)setupOriginalData
{
    
//    CJStatus *status = self.statusFrame.status;
//    CJUser *user = status.user;
    
    
    
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
    
    
    
//    
//    // 2.头像
//    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithNamed:@"avatar_default_small"]];
//    self.iconView.frame = self.statusFrame.iconViewF;
//    
//    
//    // 3.昵称
//    self.nameLabel.text = user.name;
//    self.nameLabel.frame = self.statusFrame.nameLabelF;
//    
//    
//    // 4.vip
//    if (user.mbtype)
//    {
//        self.vipView.hidden = NO;
//        self.vipView.image = [UIImage imageWithNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
//        self.vipView.frame = self.statusFrame.vipViewF;
//        
//        self.nameLabel.textColor = CJColor(230, 70, 0);// 如果是会员,设置昵称文字颜色
//    }
//    else
//    {
//        self.vipView.hidden = YES;
//        self.nameLabel.textColor = [UIColor blackColor];// 如果不是会员,昵称文字黑色
//    }
//    
//    
//    
//    
//    
//    // 5.时间
//    self.timeLabel.text = status.created_at;
//    // 因为时间显示的内容随时变化,所以需重新计算frame
//    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
//    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + CJStatusCellBorder * 0.5;
//    CGSize timeLabelSize = [self sizeWithText:status.created_at font:CJStatusTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    self.timeLabel.frame = CGRectMake(timeLabelX, timeLabelY, timeLabelSize.width, timeLabelSize.height);
//    
//    
//    
//    
//    // 6.来源
//    self.sourceLabel.text = status.source;
//    // 因为时间显示的内容随时变化,所以需重新计算frame
//    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + CJStatusCellBorder;
//    CGFloat sourceLabelY = timeLabelY;
//    CGSize sourceLabelSize = [self sizeWithText:status.source font:CJStatusSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
//    self.sourceLabel.frame = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelSize.width, sourceLabelSize.height);
//    
//    
//    
//    
//    
//    // 7.正文
//    self.contentLabel.text = status.text;
//    self.contentLabel.frame = self.statusFrame.contentLabelF;
//    
//    // 8.配图
//    if (status.thumbnail_pic)
//    {
//        self.photoView.hidden = NO;
//        self.photoView.frame = self.statusFrame.photoViewF;
//        [self.photoView setImageWithURL:[NSURL URLWithString:status.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
//    }
//    else
//    {
//        self.photoView.hidden = YES;
//    }
//    
    
    
}



/**
 *  设置被转发微博数据
 */
- (void)setupRetweetData
{
    
    CJStatus *retweetStatus = self.statusFrame.status.retweeted_status;
//    CJUser *user = retweetStatus.user;
    
    // 1.父控件retweetView
    // 如果有转发微博,赋值数据并显示
    if (retweetStatus)
    {
        
        self.retweetView.hidden = NO;
        
        // 2.设置整体的frame
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 3.传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
        
        
        
        
//        // 3.昵称
////        self.retweetNameLabel.text = user.name;
//        self.retweetNameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
//        self.retweetNameLabel.frame = self.statusFrame.retweetNameLabelF;
//        
//        // 4.正文
//        self.retweetContentLabel.text = retweetStatus.text;
//        self.retweetContentLabel.frame = self.statusFrame.retweetContentLabelF;
//        
//        // 5.配图
//        if (retweetStatus.thumbnail_pic)
//        {
//            self.retweetPhotoView.hidden = NO;
//            self.retweetPhotoView.frame = self.statusFrame.retweetPhotoViewF;
//            [self.retweetPhotoView setImageWithURL:[NSURL URLWithString:retweetStatus.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
//        }
//        else
//        {
//            self.retweetPhotoView.hidden = YES;
//        }
    }
    else
    {
        self.retweetView.hidden = YES;
    }
    
}


/**
 *  设置微博工具条数据
 */
- (void)setupStatusToolBarData
{
    self.statusToolBar.frame = self.statusFrame.statusToolBarF;
    
    // 将模型传递给View
    self.statusToolBar.status = self.statusFrame.status;
}





@end
