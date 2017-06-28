//
//  CJPhotosView.h
//  CJWeibo
//
//  Created by app on 16/6/2.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJPhotosView : UIView
/**
 *  需要展示的图片(数组里面装的都是CJPhoto模型)
 */
@property (nonatomic, strong) NSArray *photos;

/**
 *  根据图片的个数返回相册的最终尺寸
 */
+ (CGSize)photosViewSizeWithPhotosCount:(int)count;
@end
