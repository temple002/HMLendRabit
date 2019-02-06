//
//  HMPublish.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMPublish.h"

@implementation HMPublish


/**
 *  快捷返回一个对象
 *
 *  @param icon   头像
 *  @param name   姓名
 *  @param detail 详情
 *
 *  @return 返回publish对象
 */
+ (instancetype)publishWithIcon:(NSString *)icon name:(NSString *)name detail:(NSString *)detail{
    
    HMPublish *publish = [[HMPublish alloc] init];
    
    publish.icon = icon;
    
    publish.name = name;
    
    publish.detail = detail;
    
    return publish;
    
}

@end
