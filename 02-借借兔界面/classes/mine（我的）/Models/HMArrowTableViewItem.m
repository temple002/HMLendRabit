//
//  HMArrowTableViewItem.m
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMArrowTableViewItem.h"

@implementation HMArrowTableViewItem

+ (instancetype)itemWithTitle:(NSString *)title andIcon:(NSString *)icon destVcClass:(Class)destVcClass{
    
    HMArrowTableViewItem *arrow = [super itemWithTitle:title andIcon:icon];
    
    arrow.destVcClass = destVcClass;
    
    return arrow;
    
}

@end
