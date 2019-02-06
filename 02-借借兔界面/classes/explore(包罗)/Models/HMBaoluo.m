//
//  HMBaoluo.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/22.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMBaoluo.h"
@implementation HMBaoluo

+ (instancetype)baoluoWithIcon:(UIImage *)icon username:(NSString *)name lastTime:(NSString *)time price:(NSString *)price images:(NSArray *)images title:(NSString *)title detail:(NSString *)detail broken:(NSString *)brokenPrice{
    
    HMBaoluo *baoluo = [[HMBaoluo alloc] init];
    baoluo.icon = icon;
    baoluo.username = name;
    baoluo.lastTime = time;
    baoluo.price = price;
    baoluo.images = images;
    baoluo.title = title;
    baoluo.brokenPrice = brokenPrice;
    baoluo.detail = detail;
    
    return baoluo;
}

@end
