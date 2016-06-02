//
//  CJStatusToolbar.m
//  CJWeibo
//
//  Created by app on 16/6/1.
//  Copyright © 2016年 ChenJun. All rights reserved.
//


/** 工具条中文字的字体 */
#define CJStatusToolBarFont [UIFont systemFontOfSize:13]


#import "CJStatusToolbar.h"


@interface CJStatusToolbar()


@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, strong) NSMutableArray *dividers;


@property (nonatomic, strong) UIButton *retweetBtn;
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *attitudeBtn;



@end







@implementation CJStatusToolbar


- (NSMutableArray *)btns
{
    if (_btns == nil)
    {
        _btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (_dividers == nil)
    {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}







/**
 *  initWithFrame方法添加子控件
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        // 1.设置 self 能被点击
        self.userInteractionEnabled = YES;
        
        
        
        // 2.设置工具条的背景图片
        self.image = [UIImage resizedImageWithName:@"timeline_card_bottom_background"];// 设置圆角背景图片
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_bottom_background_highlighted"];// 设置高亮状态下圆角背景图片
        
        
        // 3.添加按钮(3个)
        // 转发按钮
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet" bgImage:@"timeline_card_leftbottom_highlighted"];
        // 评论按钮
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment" bgImage:@"timeline_card_middlebottom_highlighted"];
        // 点赞按钮
        self.attitudeBtn = [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike" bgImage:@"timeline_card_rightbottom_highlighted"];
        
        
        
        // 4.添加分割线(2个)
        [self setupDivider];
        [self setupDivider];
        
        
        
        
    }
    return self;
}

/**
 *  初始化按钮
 *
 *  @param title   按钮 文字
 *  @param image   按钮 图片
 *  @param bgImage 按钮 背景
 */
- ( UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image bgImage:(NSString *)bgImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageWithNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:CJColor(159, 159, 159) forState:UIControlStateNormal];
    btn.titleLabel.font = CJStatusToolBarFont;
    [btn setBackgroundImage:[UIImage resizedImageWithName:bgImage] forState:UIControlStateHighlighted];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);// imageView外部上左下右各有10间距的空隙
    btn.adjustsImageWhenHighlighted = NO;
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
}

/**
 *  初始化分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageWithNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}

/**
 *  设置自控件的frame
 */
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    CGFloat dividerW = 2;// 分割线宽度
    int dividerCount = self.dividers.count;// 分割线个数
    
    
    
    // 1.设置按钮的frame
    int btnCount = self.btns.count;
    CGFloat btnW = (self.frame.size.width -  dividerW * dividerCount) / btnCount;
    CGFloat btnH = self.frame.size.height;
    CGFloat btnY = 0;
    for (int i = 0 ; i < btnCount ; i++)
    {
        UIButton *btn = self.btns[i];
        CGFloat btnX = i * (btnW + dividerW);
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
    }
    
    
    
    
    
    // 2.设置分割线的frame
    CGFloat dividerH = btnH;
    CGFloat dividerY = 0;
    for (int j = 0 ; j < dividerCount ; j++)
    {
        UIButton *btn = self.btns[j];
        
        UIImageView *divider = self.dividers[j];
        CGFloat dividerX = CGRectGetMaxX(btn.frame);
        divider.frame = CGRectMake(dividerX, dividerY, dividerW, dividerH);
    }
    
}





/**
 *  重写set方法,在得到CJStatus模型数据时,将数据拆分赋值给子控件
 */
- (void)setStatus:(CJStatus *)status
{
    _status = status;
    
    /** 当转发数、评论数
     
     为0 -> @"转发"、@"评论"
     
     大于0 小于10000 -> 完整数据
     
     大于10000 -> (10442:1万   42335:4.2万   26905:2.7万)
     
     */
    
//    status.reposts_count = 43990;
//    status.comments_count = 28321;
//    status.attitudes_count = 59500;
    
    // 1.设置转发数
    [self setupBtn:self.retweetBtn originalTitle:@"转发" count:status.reposts_count];
    
    // 2.设置评论数
    [self setupBtn:self.commentBtn originalTitle:@"评论" count:status.comments_count];
    
    // 3.设置点赞数
    [self setupBtn:self.attitudeBtn originalTitle:@"赞" count:status.attitudes_count];
}





/**
 *  设置工具条三个按钮的显示标题
 *
 *  @param btn           哪个按钮需要设置标题
 *  @param originalTitle 按钮的原始标题(如果显示的数字为0的时候,显示这个原始标题 : 转发、评论、赞)
 *  @param count         按钮需要显示的数字
 */
- (void)setupBtn:(UIButton *)btn originalTitle:(NSString *)originalTitle count:(int)count
{
    if (count)// 当数字不为0
    {
        
        NSString *title = nil;
        
        if (count < 10000)// 小于1W
        {
            title = [NSString stringWithFormat:@"%d",count];
        }
        else// 大于等于1W
        {
            title = [NSString stringWithFormat:@"%.1f万",count / 10000.0];
            
            // 如果出现.0   就换成空字符
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
    else
    {
        [btn setTitle:originalTitle forState:UIControlStateNormal];
    }
}





@end
