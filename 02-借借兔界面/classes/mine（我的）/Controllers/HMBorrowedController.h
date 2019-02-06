//
//  HMBorrowedController.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/26.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMBorrowedController : UITableViewController

//添加物品或技能
- (void)addBorrowedThing:(id)borrow;

+ (instancetype)shareBorrowedController;

@end
