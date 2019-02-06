//
//  HMBaseTableController.m
//  25-彩票系统
//
//  Created by Temple on 16/3/13.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMBaseTableController.h"
#import "HMTableViewCell.h"
#import "HMTableViewItem.h"
#import "HMTableCellGroup.h"
#import "HMArrowTableViewItem.h"
#import "HMLabelItem.h"
#import "HMSwitchTableVIewItem.h"
#import "hmSaveTool.h"
#import "MBProgressHUD.h"
#import "HMHomeControllerr.h"
#import "HMLoginController.h"

@interface HMBaseTableController ()

//.h文件声明cellArr数组

@property (nonatomic, strong) HMTableViewCell *SwitchCell;

//组尾视图
@property (nonatomic,strong) UIButton *footButton;

@end

@implementation HMBaseTableController


//懒加载
- (UIButton *)footButton{
    
    if (_footButton == nil) {
        
        self.footButton = [[UIButton alloc] init];
        
        CGFloat footW = 280;
        CGFloat footH = 44;
        CGFloat footX = (self.view.bounds.size.width - footW) * 0.5;
        CGFloat footY = 0;

        self.footButton.frame = CGRectMake(footX, footY, footW, footH);
        
        [self.footButton setTitle:@"退出登录" forState:UIControlStateNormal];
        self.footButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.footButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.footButton setBackgroundColor:themeColor];
        
        //添加监听，注销
        [self.footButton addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footButton;
}


- (void)loginOut{
    
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:@"确定要注销？" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = @"正字注销...";
        
        hud.mode = MBProgressHUDModeIndeterminate;
        
        //设置提示框的frame
        hud.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - hud.bounds.size.width) *0.5, -150, hud.bounds.size.width, hud.bounds.size.height);
        
        //延迟一段时间
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide:YES];
            
            //设置为未登录
            HMLoginController *logon2 = [HMLoginController shareLogin];
            [logon2 setLogin:NO];
            
            if (logon2.loginOutBlock) {
                logon2.loginOutBlock();
            }
            
            //退出
            [self.navigationController popViewControllerAnimated:YES];
            
            
        });
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        
    }];
    
    [sheet addAction:action];
    [sheet addAction:action2];
    
    [self presentViewController:sheet animated:YES completion:nil];
}



//初始化的时候让tableView的style改为grouped
- (instancetype)init{
    

    return [super initWithStyle:UITableViewStyleGrouped];
}



//懒加载datalist
- (NSMutableArray *)dataList{
    
    if (_dataList == nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    HMTableCellGroup *group = _dataList[section];
    return group.items.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMTableViewCell *cell = [HMTableViewCell cellWithTableView:tableView];

    
    HMTableCellGroup *group = _dataList[indexPath.section];
    HMTableViewItem *item = group.items[indexPath.row];
    
    cell.item = item;
    
    
    return cell;
}



//每组开头
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    HMTableCellGroup *group = _dataList[section];
    
    return group.header;
}
//每组结尾
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    
    HMTableCellGroup *group = _dataList[section];
    
    return group.footer;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    HMTableCellGroup *group = _dataList[section];
    
    if (group.tag == 4) {
        
        return self.footButton;
        
    }else{
        return nil;
    }
    
}

//点击cell跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //选中后马上变为未选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HMTableCellGroup *group = _dataList[indexPath.section];
    HMTableViewItem *item = group.items[indexPath.row];
    
    if (item.block) {
        item.block();
    }
    
    if ([item isKindOfClass:[HMArrowTableViewItem class]]) {
        
        HMArrowTableViewItem *ATVI = (HMArrowTableViewItem *)item;
        
        if (ATVI.destVcClass) {
            UIViewController *VC = [[ATVI.destVcClass alloc] init];
            
            //隐藏tabbar
            VC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController showViewController:VC sender:nil];
            
            VC.title = item.title;
        }
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMTableCellGroup *group = _dataList[indexPath.section];
    HMTableViewItem *item = group.items[indexPath.row];
    
    if (indexPath.section == 0 && item.tag == 44) {
        return 66;
    }else{
        return [super tableView:tableView heightForRowAtIndexPath:indexPath];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    HMTableCellGroup *group = _dataList[section];
    
    if (group.tag == 4) {
        
        return 44;
        
    }else{
        return 0;
    }
}




@end
