//
//  HMBaoLuoController.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/21.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HMBaoLuoController : UITableViewController

- (void)addBaoluo;
- (void)addSkill;

/**
 *  包罗模型
 */
@property (nonatomic,strong) NSMutableArray *baoluos;


/**
 *  技能模型
 */
@property (nonatomic,strong) NSMutableArray *skills;

+ (instancetype)shareBaoluo;



@end
