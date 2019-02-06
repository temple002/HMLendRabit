//
//  HMPublishTableCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMPublish.h"
@interface HMPublishTableCell : UITableViewCell

/**
 *  获取publish模型
 */
@property (nonatomic,strong) HMPublish *publish;

/**
 *  快捷创建cell
 */
+ (instancetype)publishCellWithTableview:(UITableView *)tableView;


/**
 * 从nib加载cell
 */
+ (instancetype)publishCell;

@end
