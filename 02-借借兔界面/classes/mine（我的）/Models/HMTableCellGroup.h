//
//  HMTableCellGroup.h
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMTableCellGroup : NSObject

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, copy) NSString *header;

@property (nonatomic, copy) NSString *footer;

@property (nonatomic,assign) int tag;

@end
