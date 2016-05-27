//
//  CJNewfeatureViewController.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//


#define CJNewfeatureImageCount 3



#import "CJNewfeatureViewController.h"
#import "CJTabBarViewController.h"




@interface CJNewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;

@end




@implementation CJNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 0.给 view 添加一个背景图片
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageWithNamed:@"new_feature_background"]];
    self.view.backgroundColor = CJColor(246, 246, 246);
    
    // 1.添加UIScrollView
    [self setupScrollView];
    
    // 2.添加pageControl
    [self setuppageControl];

}



/**
 *  添加UIScrollView
 */
- (void)setupScrollView
{
    // 1.添加一个 UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    
    scrollView.delegate = self;
    
    [self.view addSubview:scrollView];
    
    
    // 2.添加新特性图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0 ; index < CJNewfeatureImageCount; index++)
    {
        // 设置图片
        UIImageView *imageView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",index+1];
        imageView.image = [UIImage imageWithNamed:name];
        
        // 设置 frame
        CGFloat imageX = index * imageW;
        CGFloat imageY = 0;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        [scrollView addSubview:imageView];
        
        
        
        
        // 在最后一个图片上添加按钮
        if (index == CJNewfeatureImageCount - 1)
        {
            [self setupLastImageView:imageView];
        }
        
        
        
    }
    
    // 3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW * CJNewfeatureImageCount, 0);
    // 隐藏滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    // 分页
    scrollView.pagingEnabled = YES;
    // 不允许弹簧效果
    scrollView.bounces = NO;
}



/**
 *  添加pageControl
 */
- (void)setuppageControl
{
    // 1.添加pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = CJNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    
    [self.view addSubview:pageControl];
    
    // 2.设置圆点颜色
    pageControl.currentPageIndicatorTintColor = CJColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = CJColor(189, 189, 189);
    
    

    
}





#pragma mark - UIScrollViewDelegate
/**
 *  只要 scrollView 滚动就会调用
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    int page = (int)(offsetX / scrollView.frame.size.width + 0.5);
    
    CJLog(@"%d",page);
    
    
    self.pageControl.currentPage = page;
    
    
}



/**
 *  在最后一个图片上添加按钮
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
    // 0.让该 imageView 能跟用户交互
    imageView.userInteractionEnabled = YES;
    
    
    // 1.添加开始微博按钮
    UIButton *startButton = [[UIButton alloc] init];
    
    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];

    // 设置 frame
    CGFloat startButtonCenterX = imageView.frame.size.width * 0.5;
    CGFloat startButtonCenterY = imageView.frame.size.height * 0.6;
    startButton.center = CGPointMake(startButtonCenterX, startButtonCenterY);
    startButton.bounds = (CGRect){CGPointZero, startButton.currentBackgroundImage.size};
    
    // 设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [startButton addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];

    
    [imageView addSubview:startButton];
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 2.添加checkboxButton
    UIButton *checkboxButton = [[UIButton alloc] init];
    
    // 设置图片
    [checkboxButton setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [checkboxButton setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    checkboxButton.selected = YES;
    
    // 设置 frame
    CGFloat checkboxButtonCenterX = startButtonCenterX;
    CGFloat checkboxButtonCenterY = imageView.frame.size.height * 0.5;
    checkboxButton.center = CGPointMake(checkboxButtonCenterX, checkboxButtonCenterY);
    checkboxButton.bounds = CGRectMake(0, 0, 200, 36);
    
    // 设置文字
    [checkboxButton setTitle:@" 分享新特性" forState:UIControlStateNormal];
    checkboxButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [checkboxButton setTitleColor:CJColor(98, 104, 109) forState:UIControlStateNormal];
    
    [checkboxButton addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置间距
    checkboxButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);// imageView外部上左下右各有10间距的空隙
    checkboxButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);// title外部上左下右各有10间距的空隙
//    checkboxButton.contentEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);// 按钮内部上左下右各有10 不能显示 label 与 image
    
    [imageView addSubview:checkboxButton];
    
}

/**
 *  点击开始微博按钮
 */
- (void)startClick
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    // 切换窗口的跟控制器
    self.view.window.rootViewController = [[CJTabBarViewController alloc] init];
}



/**
 *  点击checkboxButton
 */
- (void)checkboxClick:(UIButton *)checkboxButton
{
    checkboxButton.selected = !checkboxButton.isSelected;
//    if(checkboxButton.selected == NO)
//    {
//        [checkboxButton setImage:[UIImage imageWithNamed:@"new_feature_share_true"] forState:UIControlStateNormal];
//        checkboxButton.selected = YES;
//    }
//    else
//    {
//        [checkboxButton setImage:[UIImage imageWithNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
//        checkboxButton.selected = NO;
//    }
}





@end
