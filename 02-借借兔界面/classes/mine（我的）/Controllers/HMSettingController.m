//
//  HMSettingController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/17.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMSettingController.h"
#import "HMArrowTableViewItem.h"
#import "HMTableCellGroup.h"

@interface HMSettingController ()

@end

@implementation HMSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = bgColor;
    
    [self addobject1];
    [self addobject2];
    [self addobject3];
    [self addobject4];
}

//添加数据
- (void)addobject1{
    
    //创建一个组
    HMTableCellGroup *group1 = [[HMTableCellGroup alloc] init];
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:@"个人资料设置" andIcon:nil destVcClass:nil];
    HMArrowTableViewItem *item2 = [HMArrowTableViewItem itemWithTitle:@"账号密码修改" andIcon:nil destVcClass:nil];
    HMArrowTableViewItem *item3 = [HMArrowTableViewItem itemWithTitle:@"消息推送设置" andIcon:nil destVcClass:nil];
    
    
    group1.items = @[item1,item2,item3];
    
    //添加到父类datalist中
    [self.dataList addObject:group1];
    
}

- (void)addobject2{
    
    //创建一个组
    HMTableCellGroup *group2 = [[HMTableCellGroup alloc] init];
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:@"使用帮助" andIcon:nil destVcClass:nil];
    HMArrowTableViewItem *item2 = [HMArrowTableViewItem itemWithTitle:@"意见反馈" andIcon:nil destVcClass:nil];
    HMArrowTableViewItem *item3 = [HMArrowTableViewItem itemWithTitle:@"分享给好友" andIcon:nil destVcClass:nil];
    
    group2.items = @[item1,item2,item3];
    
    //添加到父类datalist中
    [self.dataList addObject:group2];
    
}

- (void)addobject3{
    
    //创建一个组
    HMTableCellGroup *group3 = [[HMTableCellGroup alloc] init];
    
    HMArrowTableViewItem *item1 = [HMArrowTableViewItem itemWithTitle:@"借物公约" andIcon:nil destVcClass:nil];
    
    group3.items = @[item1];
    
    //添加到父类datalist中
    [self.dataList addObject:group3];
    
}

- (void)addobject4{
    //创建一个组
    HMTableCellGroup *group3 = [[HMTableCellGroup alloc] init];
    
    group3.tag = 4;
    
    //添加到父类datalist中
    [self.dataList addObject:group3];
    
}



@end
