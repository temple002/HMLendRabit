//
//  HMBorrowingController.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/28.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMOrderController : UITableViewController

+ (instancetype)shareHMOrderController;

- (void)addOrder:(id)order;

@end
