//
//  HMSwitchTableVIewItem.m
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMSwitchTableVIewItem.h"
#import "HMSaveTool.h"
@implementation HMSwitchTableVIewItem

- (void)setOff:(BOOL)off{
    
    _off = off;
    [HMSaveTool setBool:off forKey:self.title];
    
}


//在设置title的时候为off属性赋值
- (void)setTitle:(NSString *)title{
    [super setTitle:title];
    
    _off = [HMSaveTool boolForKey:self.title];
    
}

@end
