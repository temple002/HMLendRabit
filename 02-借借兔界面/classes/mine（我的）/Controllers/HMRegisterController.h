//
//  HMRegisterController.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/4.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMRegisterController;
//把注册信息传给登录界面代理
@protocol HMRegisterControllerDelegate <NSObject>

@required
- (void)HMRegisterController:(HMRegisterController *)regist stuNum:(NSString *)stuNum psw:(NSString *)psw name:(NSString *)name;

@end

@interface HMRegisterController : UIViewController

@property (nonatomic,weak) id delegate;

@end
