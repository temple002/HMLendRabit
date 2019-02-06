//
//  HMTableViewItem.h
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^HMTableViewItemBlock)();

@interface HMTableViewItem : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *detailTitle;
@property (nonatomic, assign) int tag;


@property (nonatomic, copy) HMTableViewItemBlock block;

+ (instancetype)itemWithTitle:(NSString *)title andIcon:(NSString *)icon;

@end
