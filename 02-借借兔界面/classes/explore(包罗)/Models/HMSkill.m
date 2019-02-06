//
//  HMSkill.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/7.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMSkill.h"

@implementation HMSkill


+ (instancetype)skillWithIcon:(UIImage *)icon username:(NSString *)name lastTime:(NSString *)time price:(NSString *)price skillDes:(NSString *)skillDes skillContent:(NSString *)skillContent {
    
    
    HMSkill *skill = [[HMSkill alloc] init];
    skill.icon = icon;
    skill.username = name;
    skill.lastTime = time;
    skill.price = price;
    skill.skillDes = skillDes;
    skill.skillContent = skillContent;
    
    return skill;
}

@end
