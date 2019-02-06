//
//  HMCollectController.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/26.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMCollectController : UITableViewController

//添加借物记录
- (void)addCollectThing:(id)collect;
- (void)deleteCollectThing:(id)collect;

+ (instancetype)shareCollectController;

@end
