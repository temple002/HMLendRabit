//
//  HMNavController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/18.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMNavController.h"
#import "HMSearchController.h"
@interface HMNavController ()

@end

@implementation HMNavController

- (void)viewDidLoad {
    [super viewDidLoad];
}


+ (void)initialize{
    
    if (self == [HMNavController class]) {
        //设置导航条背景(appearance可以获取所有导航栏bar)
        UINavigationBar *bar = [UINavigationBar appearance];
        
        //填充导航栏
        UIImage *img = nil;
        
        img = [UIImage imageNamed:@"NavBar64"];
        
        
        [bar setBackgroundImage:img forBarMetrics:UIBarMetricsDefault];
        
        //设置导航条的字为白色
        NSDictionary *dic = @{
                              NSForegroundColorAttributeName : [UIColor blackColor]
                              };
        
        [bar setTitleTextAttributes:dic];
        
        //设置导航栏除了title的其他控件为白色
        [bar setTintColor:[UIColor blackColor]];
    }
    
}


@end
