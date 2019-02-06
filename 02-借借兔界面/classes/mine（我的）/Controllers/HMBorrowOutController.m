//
//  HMBorrowOutController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/31.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMBorrowOutController.h"
#import "HMBaoluo.h"
#import "HMBorrowedCell.h"


@interface HMBorrowOutController ()
//借物数据
@property (nonatomic,strong) NSMutableArray *borrowList;

@end

@implementation HMBorrowOutController


//懒加载
- (NSMutableArray *)borrowList{
    
    if (_borrowList == nil) {
        
        self.borrowList = [NSMutableArray array];
    }
    return _borrowList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
    //取消表格的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    NSMutableArray *arr2 = [NSMutableArray array];
    UIImage *image4 = [UIImage imageNamed:@"img04"];
    UIImage *image5 = [UIImage imageNamed:@"img05"];
    UIImage *image6 = [UIImage imageNamed:@"img06"];
    UIImage *image7 = [UIImage imageNamed:@"img07"];
    UIImage *image8 = [UIImage imageNamed:@"img08"];
    [arr2 addObject:image4];
    [arr2 addObject:image5];
    [arr2 addObject:image6];
    [arr2 addObject:image7];
    [arr2 addObject:image8];
    HMBaoluo *baoluo3 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"王龙权" lastTime:@"3小时前" price:@"500" images:arr2 title:@"樱桃茶轴机械键盘" detail:@"樱桃MX-Board 3.0黑色茶轴机械键盘，本人学编程，认为机械键盘可以帮助打字速度，但是有了笔记本电脑觉得外接键盘比较多余。才买了一个多月，一直没怎么用，想借的同学尽快联系我。" broken:@"500"];
    baoluo3.isBorrowed = NO;
    
    [self.borrowList addObject:baoluo3];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.borrowList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id obj = self.borrowList[indexPath.row];
    
    HMBorrowedCell *cell = [HMBorrowedCell borrowedCellWithTableview:tableView];
    
    cell.buttonName = @"对方归还了";
    cell.alertMessage = @"恭喜完好收到了您的宝贝，您将得到500信用值奖励";
    cell.skillFinishMessage = @"您的勤劳换来了20信用值的奖励";
    cell.user = @"借物人";
    
    //弹出提示框
    cell.block = ^(UIAlertController *alert){
        
        [self presentViewController:alert animated:YES completion:nil];
    };
    
    cell.data = obj;
    
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}




@end
