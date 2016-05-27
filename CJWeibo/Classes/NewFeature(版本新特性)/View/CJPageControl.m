//
//  CJPageControl.m
//  CJWeibo
//
//  Created by app on 16/5/24.
//  Copyright © 2016年 ChenJun. All rights reserved.
//

#import "CJPageControl.h"

@implementation CJPageControl


- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    for (int i = 0 ; i < numberOfPages ; i++)
    {
        CJLog(@"aaa");
    }
}


@end
