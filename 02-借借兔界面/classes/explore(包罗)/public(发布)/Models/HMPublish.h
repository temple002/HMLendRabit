//
//  HMPublish.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMPublish : NSObject

/**
 *  头像
 */
@property (nonatomic,copy) NSString *icon;

/**
 *  用户名
 */
@property (nonatomic,copy) NSString *name;

/**
 *  详细内容
 */
@property (nonatomic,copy) NSString *detail;

/**
 *  快捷返回对象
*/
+ (instancetype)publishWithIcon:(NSString *)icon name:(NSString *)name detail:(NSString *)detail;

@end
