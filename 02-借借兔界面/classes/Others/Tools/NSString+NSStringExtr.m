//
//  NSString+NSStringExtr.m
//  qq聊天界面
//
//  Created by Temple on 15/10/27.
//  Copyright (c) 2015年 hm. All rights reserved.
//

#import "NSString+NSStringExtr.h"

@implementation NSString (NSStringExtr)

-(CGSize)sizeOfStringWithMaxsize:(CGSize)maxSize font:(UIFont *)font{
    
    NSDictionary *dic=@{NSFontAttributeName : font};
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
}

+(CGSize)sizeWithString:(NSString *)string maxSize:(CGSize)maxsize font:(UIFont *)font{
    
    return [string sizeOfStringWithMaxsize:maxsize font:font];
}


@end
