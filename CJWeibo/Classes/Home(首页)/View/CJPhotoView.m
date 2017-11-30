//
//  CJPhotoView.m
//  CJWeibo
//
//  Created by app on 16/6/2.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJPhotoView.h"

@interface CJPhotoView()
@property (nonatomic, weak) UIImageView *gifView;
@end


@implementation CJPhotoView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 添加一个GIF小图片
        UIImage *image = [UIImage imageWithNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(CJPhoto *)photo
{
    _photo = photo;
    
    // 控制gifView的可见性
    //self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    photo = [CJPhoto mj_objectWithKeyValues:photo];
    self.gifView.hidden = ![photo.thumbnail_pic hasSuffix:@"gif"];
    
    
    
    // 下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageWithNamed:@"timeline_image_placeholder"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.layer.anchorPoint = CGPointMake(1, 1);
    self.gifView.layer.position = CGPointMake(self.frame.size.width, self.frame.size.height);
}



@end
