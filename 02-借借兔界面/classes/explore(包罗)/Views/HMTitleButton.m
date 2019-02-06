//
//  HMTitleButton.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/2.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMTitleButton.h"
#import "PopoverView.h"
@implementation HMTitleButton

//图片不要填充,要居中
- (void)awakeFromNib{
    self.imageView.contentMode = UIViewContentModeCenter;
    
    [self addTarget:self action:@selector(TitleClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

//点击title
- (void)TitleClick:(UIButton *)sender{
    CGPoint point = CGPointMake(sender.frame.origin.x + sender.frame.size.width/2, sender.frame.origin.y + sender.frame.size.height + 20);
    NSArray *titles = @[@"最新发布", @"最热发布"];

    PopoverView *pop = [[PopoverView alloc] initWithPoint:point titles:titles images:nil];
    pop.selectRowAtIndex = ^(NSInteger index){
        
        NSLog(@"select index:%ld", (long)index);
    };
    [pop show];
}

//设置文字位置让它放到按钮的左边
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    CGFloat buttonX = 0;
    CGFloat buttonY = 0;
    
    NSDictionary *dic = @{
                          NSFontAttributeName : [UIFont boldSystemFontOfSize:17]
                          
                          };
    
    //更具文字具体大小来定宽度
    
    CGFloat buttonW = 0;
    
    buttonW = [self.currentTitle boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil].size.width;
    
    CGFloat buttonH = contentRect.size.height;
    
    return CGRectMake(buttonX, buttonY, buttonW, buttonH);
    
    
}
//设置图片位置让它放到按钮的右边
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    CGFloat imgW = 30;
    CGFloat imgH = contentRect.size.height;
    CGFloat imgX = contentRect.size.width - imgW + 10;
    CGFloat imgY = 0;
    
    return CGRectMake(imgX, imgY, imgW, imgH);
    
}

@end
