//
//  HMImagePreview.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/31.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMImagePreview.h"

@interface HMImagePreview ()

@end

@implementation HMImagePreview

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)previewImage:(UIImage *)image{
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    //拉伸方式
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    //图像裁剪
    imageV.layer.masksToBounds = YES;
    
    
    CGFloat imageVw = 320;
    CGFloat imageVh = 380;
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    CGFloat imageVx = (window.bounds.size.width - imageVw) * 0.5;
    CGFloat imageVy = (window.bounds.size.height - imageVh) * 0.5;
    
    imageV.frame = CGRectMake(imageVx, imageVy, imageVw, imageVh);
    
    [self.view addSubview:imageV];
    
    
    UILabel *label = [[UILabel alloc] init];
    
    NSDate *nowDate=[NSDate date];
    NSDateFormatter *nowDateFormatter=[[NSDateFormatter alloc]init];
    nowDateFormatter.dateFormat=@"yyyy年MM月dd  HH:mm:ss";
    
    label.text = [nowDateFormatter stringFromDate:nowDate];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(imageVx + 5, imageVy + imageVh + 10, 200, 30);
    
    [self.view addSubview:label];
    
    
}

@end
