//
//  HMTableViewItem.m
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMTableViewItem.h"

@implementation HMTableViewItem

+ (instancetype)itemWithTitle:(NSString *)title andIcon:(NSString *)icon{
    
    //可能是子类调用，所以用self。
    HMTableViewItem *item = [[self alloc] init];
    item.title = title;
    item.icon = icon;
    
    return item;
}

@end
