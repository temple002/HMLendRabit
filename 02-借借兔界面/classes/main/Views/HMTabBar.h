//
//  HMTabBar.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>


//在tabbarController里用于切换控制器的block
typedef void(^HMTabbarBlock)(int selectIndex);


//跳到登录界面
typedef void(^HMJump2LoginBlock)();

@interface HMTabBar : UIView


+ (instancetype)shareTabBar;

/**
 *  底部菜单栏按钮成员属性
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_home;
@property (weak, nonatomic) IBOutlet UIButton *btn_baoluo;
@property (weak, nonatomic) IBOutlet UIButton *btn_publish;
@property (weak, nonatomic) IBOutlet UIButton *btn_mine;

- (IBAction)homeClick:(id)sender;
- (IBAction)baoluoClick:(id)sender;
- (IBAction)publishClick:(id)sender;
- (IBAction)mineClick:(id)sender;



//block成员属性
@property (nonatomic,copy) HMTabbarBlock block;



@property (nonatomic,copy) HMJump2LoginBlock jump2LoginBlock;


+ (instancetype)tabbar;

@end
