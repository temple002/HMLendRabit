//
//  HMSkillCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/7.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSkill.h"
@interface HMSkillCell : UITableViewCell

/**
 *  获取模型
 */
@property (nonatomic,strong) HMSkill *skill;


//从nib加载
+ (instancetype)skillCell;

/**
 *  快捷创建cell
 */
+ (instancetype)skillCellWithTableview:(UITableView *)tableView;


@end
