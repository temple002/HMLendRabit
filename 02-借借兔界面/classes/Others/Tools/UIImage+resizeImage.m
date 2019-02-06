//
//  UIImage+resizeImage.m
//  25-彩票系统
//
//  Created by Temple on 16/3/6.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "UIImage+resizeImage.h"

@implementation UIImage (resizeImage)

+ (instancetype)imageResizeWithName:(NSString *)imgName{
    
    UIImage *img = [UIImage imageNamed:imgName];
    
    img = [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5];
    
    
    return img;
    
}

@end
