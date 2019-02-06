//
//  HMLoginController.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBaseTableController.h"

typedef void(^HMLoginOutBlock)();

@interface HMLoginController : HMBaseTableController

+ (instancetype)shareLogin;

- (BOOL)ifLoginOn;

- (void)setLogin:(BOOL)login;


//设置用户名
@property (nonatomic,strong) NSString *username;


@property (nonatomic,copy) HMLoginOutBlock loginOutBlock;


@end
