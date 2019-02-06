//
//  HMToolBar.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/23.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMToolBar.h"

@interface HMToolBar ()

@property (weak, nonatomic) IBOutlet UIButton *done;


@end

@implementation HMToolBar

/**
 *  从xib加载
 *
 */
+ (instancetype)toolBar{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HMToolBar" owner:nil options:nil] lastObject];
    
}

/**
 *  点击事件让键盘退出
 *
 */
- (IBAction)done_click:(UIButton *)sender {
    
    self.block();
    
}

@end
