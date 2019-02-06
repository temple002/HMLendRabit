//
//  HMSaveTool.h
//  25-彩票系统
//
//  Created by Temple on 16/3/13.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMSaveTool : NSObject

+ (void)setObject:(id)value forKey:(NSString *)defaultName;

+ (id)objectForKey:(NSString *)defaultName;

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;

+ (BOOL)boolForKey:(NSString *)defaultName;

@end
