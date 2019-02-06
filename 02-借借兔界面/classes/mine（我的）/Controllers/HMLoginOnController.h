//
//  HMLoginOnController.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/24.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMLoginOnControllerDelegate)();

@interface HMLoginOnController : UIViewController

@property (nonatomic,copy) HMLoginOnControllerDelegate dismissBlock;

@end
