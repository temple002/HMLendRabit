//
//  HMBorrowedController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/26.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMBorrowedController.h"
#import "HMBaoluoCell.h"
#import "HMSkillCell.h"
#import "HMBaoluo.h"
#import "HMSkill.h"
#import "HMThingDetailController.h"
#import "HMSkillDetailController.h"
#import "HMBorrowedCell.h"
#import "HMImagePreview.h"

@interface HMBorrowedController ()

//借物数据
@property (nonatomic,strong) NSMutableArray *borrowList;

@end

@implementation HMBorrowedController

#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMBorrowedController alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (instance == nil) {//防止创建多次
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)shareBorrowedController{
    
    return instance;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return instance;
}

/**********************************************************************************/

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
    //取消表格的线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //添加假数据
    NSMutableArray *arr1 = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"img01"];
    UIImage *image2 = [UIImage imageNamed:@"img02"];
    UIImage *image3 = [UIImage imageNamed:@"img03"];
    [arr1 addObject:image1];
    [arr1 addObject:image2];
    [arr1 addObject:image3];
    HMBaoluo *baoluo1 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"1小时前" price:@"150" images:arr1 title:@"十字绣" detail:@"盆景十字绣，纯手工，无错针，无瑕疵，房间必备品装饰品。" broken:@"200"];
    
    HMSkill *skill1 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"乔阿斗" lastTime:@"1小时前" price:@"20" skillDes:@"打篮球" skillContent:@"本人会打篮球，参加过校级，省级，全国级篮球比赛并获得优异的成绩，我热爱篮球，从小就开始练，觉得篮球是我的生命。如果球赛确认随时可以叫我。"];
    [self.borrowList addObject:baoluo1];
    [self.borrowList addObject:skill1];
    
}

//懒加载
- (NSMutableArray *)borrowList{
    
    if (_borrowList == nil) {
        
        self.borrowList = [NSMutableArray array];
    }
    return _borrowList;
}

//添加借物记录
- (void)addBorrowedThing:(id)borrow{
    
    if (borrow) {
        [self.borrowList addObject:borrow];
        
        [self.tableView reloadData];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.borrowList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id obj = self.borrowList[indexPath.row];
    
    HMBorrowedCell *cell = [HMBorrowedCell borrowedCellWithTableview:tableView];
    
    //弹出提示框
    cell.block = ^(UIAlertController *alert){
        
        [self presentViewController:alert animated:YES completion:nil];
    };
    
    cell.previewBlock = ^(HMImagePreview *preview){
        
        [self.navigationController showViewController:preview sender:nil];
    };
    
    cell.data = obj;
    
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}

@end
