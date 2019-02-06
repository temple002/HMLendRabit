//
//  NSString+NSStringExtr.h
//  qq聊天界面
//
//  Created by Temple on 15/10/27.
//  Copyright (c) 2015年 hm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (NSStringExtr)

-(CGSize)sizeOfStringWithMaxsize:(CGSize)maxSize font:(UIFont *)font;

+(CGSize)sizeWithString:(NSString *)string maxSize:(CGSize)maxsize font:(UIFont *)font;

@end
