//
//  HMTableViewCell.h
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMTableViewItem.h"


@interface HMTableViewCell : UITableViewCell

@property (nonatomic, strong) HMTableViewItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;



@end
