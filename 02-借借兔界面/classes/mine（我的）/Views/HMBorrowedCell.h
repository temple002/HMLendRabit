//
//  HMBorrowedCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/30.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMImagePreview;

typedef void(^HMBorrowedCellAlertBlock)(UIAlertController *alert);
typedef void(^HMBorrowedCellPreViewBlock)(HMImagePreview *preview);

@interface HMBorrowedCell : UITableViewCell

@property (nonatomic,strong) id data;

@property (nonatomic,copy) NSString *buttonName;
@property (nonatomic,copy) NSString *alertMessage;
@property (nonatomic,copy) NSString *skillFinishMessage;
@property (nonatomic,copy) NSString *user;

//从nib加载
+ (instancetype)borrowedCell;

/**
 *  快捷创建cell
 */
+ (instancetype)borrowedCellWithTableview:(UITableView *)tableView;

@property (nonatomic,copy) HMBorrowedCellAlertBlock block;
@property (nonatomic,copy) HMBorrowedCellPreViewBlock previewBlock;


@end
