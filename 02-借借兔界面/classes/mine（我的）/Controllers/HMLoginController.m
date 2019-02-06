//
//  HMLoginController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMLoginController.h"
#import "HMArrowTableViewItem.h"
#import "HMTableCellGroup.h"
#import "HMBorrowedController.h"
#import "HMCollectController.h"
#import "HMOrderController.h"
#import "HMBorrowOutController.h"
@interface HMLoginController ()

@property (nonatomic,assign) BOOL isLogin;

@property (nonatomic,assign) int borrowedCount;

@end

@implementation HMLoginController


#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMLoginController alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (instance == nil) {//防止创建多次
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)shareLogin{
    
    return instance;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return instance;
}



/************************************************************************************/

//返回是否登录
- (BOOL)ifLoginOn{
    
    return self.isLogin;
}

//设置登录状态
- (void)setLogin:(BOOL)login{
    
    self.isLogin = login;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor;

    [self addobject1];
    [self addobject2];
    [self addobject3];
}

//添加数据
- (void)addobject1{
    //创建一个组
    HMTableCellGroup *group1 = [[HMTableCellGroup alloc] init];
    
    
    if (!self.username.length) {
        self.username = @"吴海斌";
    }
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:self.username andIcon:@"icon" destVcClass:nil];
    item1.detailTitle = @"信用值:100";
    
    item1.tag = 44;
    
    group1.items = @[item1];
    
    //添加到父类datalist中
    [self.dataList addObject:group1];
}

//添加数据
- (void)addobject2{
    //创建一个组
    HMTableCellGroup *group2 = [[HMTableCellGroup alloc] init];
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:@"我发布的" andIcon:@"IDInfo" destVcClass:nil];
    
    HMArrowTableViewItem *item2 = [HMArrowTableViewItem itemWithTitle:@"我借出的" andIcon:@"MoreNetease" destVcClass:[HMBorrowOutController class]];
    
    HMArrowTableViewItem *item3 = [HMArrowTableViewItem itemWithTitle:@"我的借单" andIcon:@"MorePush" destVcClass:[HMOrderController class]];
    
    HMArrowTableViewItem *item4 = [HMArrowTableViewItem itemWithTitle:@"我借到的" andIcon:@"MoreUpdate" destVcClass:[HMBorrowedController class]];
    
    HMArrowTableViewItem *item5 = [HMArrowTableViewItem itemWithTitle:@"我的收藏" andIcon:@"MoreAbout" destVcClass:[HMCollectController class]];
    
    HMArrowTableViewItem *item6 = [HMArrowTableViewItem itemWithTitle:@"我的消息" andIcon:@"MoreMessage" destVcClass:nil];
    
    HMArrowTableViewItem *item7 = [HMArrowTableViewItem itemWithTitle:@"兑换学分" andIcon:@"MoreShare" destVcClass:nil];
    
    group2.items = @[item1,item2,item3,item4,item5,item6,item7];
    
    //添加到父类datalist中
    [self.dataList addObject:group2];
}

//添加数据
- (void)addobject3{
    //创建一个组
    HMTableCellGroup *group3 = [[HMTableCellGroup alloc] init];
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:@"关于我们" andIcon:@"icon_account_selling" destVcClass:nil];
    
    group3.items = @[item1];
    
    //添加到父类datalist中
    [self.dataList addObject:group3];
}

@end
