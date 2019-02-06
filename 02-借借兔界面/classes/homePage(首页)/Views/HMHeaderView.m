//
//  HMHeaderView.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/24.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMHeaderView.h"

@implementation HMHeaderView

+ (instancetype)headerView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HMHeaderView" owner:nil options:nil] lastObject];
}

@end
