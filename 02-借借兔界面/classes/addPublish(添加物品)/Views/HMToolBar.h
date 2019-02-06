//
//  HMToolBar.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/23.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMToolBarBlock)();

@interface HMToolBar : UIView

/**
 *  block
 */
@property (nonatomic,copy) HMToolBarBlock block;


+ (instancetype)toolBar;

@end
