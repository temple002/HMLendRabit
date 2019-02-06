//
//  HMPublishController.h
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPublishController : UITableViewController

+ (instancetype)sharePublish;
/**
 *  publishs
 */
@property (nonatomic,strong) NSMutableArray *publishs;


//添加假数据
- (void)addPublish;

@end
