//
//  HMSaveTool.m
//  25-彩票系统
//
//  Created by Temple on 16/3/13.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMSaveTool.h"

@implementation HMSaveTool

+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    //存储一下数据，下次直接读
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:value forKey:defaultName];
    [user synchronize];
    
}

+ (BOOL)boolForKey:(NSString *)defaultName
{
    //取数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user boolForKey:defaultName];
}

+ (id)objectForKey:(NSString *)defaultName{
    
    //取数据
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    return [user objectForKey:defaultName];
    
}

+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName{
    //存储一下数据，下次直接读
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:value forKey:defaultName];
    [user synchronize];
}


@end
