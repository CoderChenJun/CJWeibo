//
//  CJStatusFrame.m
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//



#import "CJStatusFrame.h"
#import "CJStatus.h"





@implementation CJStatusFrame



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
 *  获得微博模型数据之后,根据微博数据计算所有子控件的frame
 */
- (void)setStatus:(CJStatus *)status
{
    _status = status;
    
    // cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width - CJStatusTableBorder * 2;
    
    // 1.topView
    CGFloat topViewX = 0;
    CGFloat topViewY = 0;
    CGFloat topViewW = cellW;
    CGFloat topViewH = 0;// 先默认0，后面再改
    
    // 2.头像
    CGFloat iconViewX = CJStatusCellBorder;
    CGFloat iconViewY = CJStatusCellBorder;
    CGFloat iconViewW = 35;
    CGFloat iconViewH = 35;
    _iconViewF = CGRectMake(iconViewX, iconViewY, iconViewW, iconViewH);
    
    // 3.昵称
    CGFloat nameLabelX = CGRectGetMaxX(_iconViewF) + CJStatusCellBorder;
    CGFloat nameLabelY = iconViewY;
    CGSize nameLabelSize = [self sizeWithText:self.status.user.name font:CJStatusNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _nameLabelF = CGRectMake(nameLabelX, nameLabelY, nameLabelSize.width, nameLabelSize.height);
    
    // 4.会员图标
    if (status.user.mbtype > 2)
    {
        CGFloat vipViewX = CGRectGetMaxX(_nameLabelF) + CJStatusCellBorder;
        CGFloat vipViewY = nameLabelY;
        CGFloat vipViewW = 14;
        CGFloat vipViewH = nameLabelSize.height;
        _vipViewF = CGRectMake(vipViewX, vipViewY, vipViewW, vipViewH);
    }
    
    
    
    
    // 5.时间
    CGFloat timeLabelX = nameLabelX;
    CGFloat timeLabelY = CGRectGetMaxY(_nameLabelF) + CJStatusCellBorder * 0.5;
    CGSize timeLabelSize = [self sizeWithText:status.created_at font:CJStatusTimeFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _timeLabelF = CGRectMake(timeLabelX, timeLabelY, timeLabelSize.width, timeLabelSize.height);
    
    
    
    
    // 6.来源
    CGFloat sourceLabelX = CGRectGetMaxX(_timeLabelF) + CJStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [self sizeWithText:status.source font:CJStatusSourceFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    _sourceLabelF = CGRectMake(sourceLabelX, sourceLabelY, sourceLabelSize.width, sourceLabelSize.height);
    
    
    
    
    
    
    // 7.微博正文内容
    CGFloat contentLabelX = iconViewX;
    CGFloat contentLabelY = MAX(CGRectGetMaxY(_iconViewF), CGRectGetMaxY(_timeLabelF)) + CJStatusCellBorder * 0.5;
    CGFloat contentLabelMaxW = topViewW - 2 * CJStatusCellBorder;
    CGSize contentLabelSize = [self sizeWithText:status.text font:CJStatusContentFont maxSize:CGSizeMake(contentLabelMaxW, MAXFLOAT)];
    _contentLabelF = CGRectMake(contentLabelX, contentLabelY, contentLabelSize.width, contentLabelSize.height);
    
    
    
#pragma mark - 如果原创微博有图片 - 计算微博图片的frame
    // 8.配图
    if (status.pic_urls.count)
    {
#warning 根据图片个数计算整个相册的尺寸
        CGSize photosViewSize = [CJPhotosView photosViewSizeWithPhotosCount:status.pic_urls.count];
        CGFloat photosViewX = contentLabelX;
        CGFloat photosViewY = CGRectGetMaxY(_contentLabelF) + CJStatusCellBorder;
        _photosViewF = CGRectMake(photosViewX, photosViewY, photosViewSize.width, photosViewSize.height);
    }
    
    
    
    
    
    
#pragma mark - 如果有被转发微博 - 计算被转发微博的frame
    if (status.retweeted_status)
    {
        // 9.被转发微博
        CGFloat retweetViewX = contentLabelX;
        CGFloat retweetViewY = CGRectGetMaxY(_contentLabelF) +CJStatusCellBorder * 0.5;
        CGFloat retweetViewW = contentLabelMaxW;
        CGFloat retweetViewH = 0;// 先默认0，后面再改
        
        // 10.被转发微博的昵称
        CGFloat retweetNameLabelX = CJStatusCellBorder;
        CGFloat retweetNameLabelY = CJStatusCellBorder;
        NSString *name = [NSString stringWithFormat:@"@%@",status.retweeted_status.user.name];// 算长度要加上@重新计算
        CGSize retweetNameLabelSize = [self sizeWithText:name font:CJRetweetNameFont maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        _retweetNameLabelF = CGRectMake(retweetNameLabelX, retweetNameLabelY, retweetNameLabelSize.width, retweetNameLabelSize.height);
        
        // 11.被转发微博的正文
        CGFloat retweetContentLabelX = retweetNameLabelX;
        CGFloat retweetContentLabelY = CGRectGetMaxY(_retweetNameLabelF) + CJStatusCellBorder * 0.5;
        CGFloat retweetContentLabelMaxW = retweetViewW - 2 * CJStatusCellBorder;
        CGSize retweetContentLabelSize = [self sizeWithText:status.retweeted_status.text font:CJRetweetContentFont maxSize:CGSizeMake(retweetContentLabelMaxW, MAXFLOAT)];
        _retweetContentLabelF = CGRectMake(retweetContentLabelX, retweetContentLabelY, retweetContentLabelSize.width, retweetContentLabelSize.height);
        
        
        
#pragma mark - 如果被转发微博有配图 - 计算被转发微博的配图的frame
        // 12.被转发微博的配图
        if (status.retweeted_status.pic_urls.count)
        {
#warning 根据图片个数计算整个相册的尺寸
            CGSize retweetPhotosViewSize = [CJPhotosView photosViewSizeWithPhotosCount:status.retweeted_status.pic_urls.count];
            CGFloat retweetPhotosViewX = retweetContentLabelX;
            CGFloat retweetPhotosViewY = CGRectGetMaxY(_retweetContentLabelF) + CJStatusCellBorder;
            _retweetPhotosViewF = CGRectMake(retweetPhotosViewX, retweetPhotosViewY, retweetPhotosViewSize.width, retweetPhotosViewSize.height);
            
        }
        
        
        // 13.计算retweetView的frame
        if (status.retweeted_status.pic_urls.count)// 被转发微博 有 配图的情况
        {
            retweetViewH = CGRectGetMaxY(_retweetPhotosViewF) +CJStatusCellBorder;
            _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        }
        else// 被转发微博 没 配图的情况
        {
            retweetViewH = CGRectGetMaxY(_retweetContentLabelF) +CJStatusCellBorder;
            _retweetViewF = CGRectMake(retweetViewX, retweetViewY, retweetViewW, retweetViewH);
        }
        
        
    }
    
    
    
    // 14.计算topView的frame
    if (status.retweeted_status)// 有 被转发微博
    {
        topViewH = CGRectGetMaxY(_retweetViewF) +CJStatusCellBorder;
        _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
    }
    else// 没有 被转发微博
    {
        if (status.pic_urls.count)// 有 原创微博配图
        {
            topViewH = CGRectGetMaxY(_photosViewF) +CJStatusCellBorder;
            _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
        }
        else// 没有 原创微博配图
        {
            topViewH = CGRectGetMaxY(_contentLabelF) +CJStatusCellBorder;
            _topViewF = CGRectMake(topViewX, topViewY, topViewW, topViewH);
        }
    }
    
    
    // 15.工具条
    CGFloat statusToolX = topViewX;
    CGFloat statusToolY = CGRectGetMaxY(_topViewF);
    CGFloat statusToolW = topViewW;
    CGFloat statusToolH = 36;// 根据中间两条分割线的高度进行给值
    _statusToolBarF = CGRectMake(statusToolX, statusToolY, statusToolW, statusToolH);
    
    
    
    // 16.计算cell的高度      (预留CJStatusTableBorder是为了cell之间留间距)
    _cellHeight = CGRectGetMaxY(_statusToolBarF) + CJStatusTableBorder;
}



@end



