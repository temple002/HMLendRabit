//
//  HMSkill.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/7.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMSkill : NSObject

@property (nonatomic,copy) UIImage *icon;

@property (nonatomic,copy) NSString *username;

@property (nonatomic,copy) NSString *lastTime;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,copy) NSString *skillDes;

@property (nonatomic,copy) NSString *skillContent;

@property (nonatomic,assign) BOOL isBorrowed;

+ (instancetype)skillWithIcon:(UIImage *)icon username:(NSString *)name lastTime:(NSString *)time price:(NSString *)price skillDes:(NSString *)skillDes skillContent:(NSString *)skillContent;


@end
