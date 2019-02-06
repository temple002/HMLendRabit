//
//  HMBaoluo.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/22.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface HMBaoluo : NSObject

@property (nonatomic,copy) UIImage *icon;

@property (nonatomic,copy) NSString *username;

@property (nonatomic,copy) NSString *lastTime;

@property (nonatomic,copy) NSString *price;

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) NSString *brokenPrice;

//正文
@property (nonatomic,copy) NSString *detail;

@property (nonatomic,assign) BOOL isBorrowed;

//凭证
@property (nonatomic,strong) UIImage *certificate;

//距离
@property (nonatomic,strong) NSString *location;


+ (instancetype)baoluoWithIcon:(UIImage *)icon username:(NSString *)name lastTime:(NSString *)time price:(NSString *)price images:(NSArray *)images title:(NSString *)title detail:(NSString *)detail broken:(NSString *)brokenPrice;

@end
