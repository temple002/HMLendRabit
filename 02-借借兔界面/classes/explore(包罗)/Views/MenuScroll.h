//
//  MenuScroll.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/4.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuScroll : UIScrollView

+ (instancetype)menuScroll;

//添加菜单
- (void)addMenus:(NSArray *)menus;

//删除菜单
- (void)deleteMenus;
@end
