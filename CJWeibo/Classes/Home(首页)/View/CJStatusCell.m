//
//  CJStatusCell.m
//  CJWeibo
//
//  Created by app on 16/5/27.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJStatusCell.h"
#import "CJStatusToolbar.h"
#import "CJStatusTopView.h"




@interface CJStatusCell()

/** 顶部的View */
@property (nonatomic, strong) CJStatusTopView *topView;


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
        // 1.添加微博顶部的View
        [self setupTopView];
        
        // 2.添加微博的工具条
        [self setupStatusToolBar];
        
//        // 1.添加原创微博内部的子控件
//        [self setupOriginalSubviews];
//        // 2.添加被转发微博内部的子控件
//        [self setupRetweetSubviews];
//        // 3.添加微博的工具条
//        [self setupStatusToolBar];
        
    }
    return self;
}

/**
 *  添加微博顶部的View
 */
- (void)setupTopView
{
    self.selectedBackgroundView = [[UIView alloc] init];

    /** 1.顶部的View */
    CJStatusTopView *topView = [[CJStatusTopView alloc] init];
    [self.contentView addSubview:topView];
    self.topView = topView;
    
}


///**
// *  添加被转发微博内部的子控件
// */
//- (void)setupRetweetSubviews
//{
//    
//    /** 1.被转发微博的View(父控件) */
//    CJRetweetStatusView *retweetView = [[CJRetweetStatusView alloc] init];
//    [self.topView addSubview:retweetView];
//    self.retweetView = retweetView;
//    
//}


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
    
    // 1. 设置微博顶部View数据
    [self setupTopViewData];
    
//    // 2.设置被转发微博数据
//    [self  setupRetweetData];
    
    // 3.设置微博工具条数据
    [self  setupStatusToolBarData];
}



/**
 *  设置微博顶部View数据
 */
- (void)setupTopViewData
{
    // 1.topView
    self.topView.frame = self.statusFrame.topViewF;
    
    // 2.传递模型数据
    self.topView.statusFrame = self.statusFrame;
}



///**
// *  设置被转发微博数据
// */
//- (void)setupRetweetData
//{
//    
//    CJStatus *retweetStatus = self.statusFrame.status.retweeted_status;
//    
//    // 1.父控件retweetView
//    // 如果有转发微博,赋值数据并显示
//    if (retweetStatus)
//    {
//        
//        self.retweetView.hidden = NO;
//        
//        // 2.设置整体的frame
//        self.retweetView.frame = self.statusFrame.retweetViewF;
//        
//        // 3.传递模型数据
//        self.retweetView.statusFrame = self.statusFrame;
//    }
//    else
//    {
//        self.retweetView.hidden = YES;
//    }
//    
//}


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
