//
//  HMBaoluoCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/22.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMBaoluo.h"

@interface HMBaoluoCell : UITableViewCell

/**
 *  获取模型
 */
@property (nonatomic,strong) HMBaoluo *baoluo;


//从nib加载
+ (instancetype)baoluoCell;

/**
 *  快捷创建cell
 */
+ (instancetype)baoluoCellWithTableview:(UITableView *)tableView;


- (void)sizeOftextLength:(HMBaoluo *)baoluo;

@end
