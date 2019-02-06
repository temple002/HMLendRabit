//
//  HMArrowTableViewItem.h
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMTableViewItem.h"

@interface HMArrowTableViewItem : HMTableViewItem

//设置目的控制器
@property (nonatomic, assign) Class destVcClass;

+ (instancetype)itemWithTitle:(NSString *)title andIcon:(NSString *)icon destVcClass:(Class)destVcClass;

@end
