//
//  HMSearchCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/6/14.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMBaoluo;

@interface HMSearchCell : UITableViewCell

@property (nonatomic,strong) HMBaoluo *baoluo;

//从nib加载
+ (instancetype)searchCell;

/**
 *  快捷创建cell
 */
+ (instancetype)searchCellWithTableview:(UITableView *)tableView;


@end
