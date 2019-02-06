//
//  HMSearchNavController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/5.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMSearchNavController.h"

@interface HMSearchNavController ()

@end

@implementation HMSearchNavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBackgroundImage:[HMSearchNavController imageWithColor:[UIColor whiteColor] size:CGSizeMake(320, 64)] forBarMetrics:UIBarMetricsDefault];
    
    //设置导航栏除了title的其他控件为白色
    [self.navigationBar setTintColor:themeColor];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
