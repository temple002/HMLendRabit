//
//  HMSearchController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/5.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMSearchController.h"
#import "HMBaoluo.h"
#import "HMSearchCell.h"
#import "HMThingDetailController.h"
#import "MBProgressHUD.h"

@interface HMSearchController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchThing;

@property (weak, nonatomic) IBOutlet UIButton *searchSkill;

//输入框
@property (weak, nonatomic) IBOutlet UITextField *textfield;
//添加线
@property (nonatomic,strong) UIView *bottomLine;

//tableView上面的View
@property (weak, nonatomic) IBOutlet UIView *titleView;

@property (nonatomic,strong) NSMutableArray *baoluos;

@end

@implementation HMSearchController


/**
 *  懒加载
 */
- (UIView *)bottomLine{
    
    if (_bottomLine == nil) {
        
        self.bottomLine = [[UIView alloc] init];
        
        [self.bottomLine setBackgroundColor:themeColor];
        
    }
    return _bottomLine;
}

- (NSMutableArray *)baoluos{
    
    if (_baoluos == nil) {
        
        self.baoluos = [NSMutableArray array];
    }
    return _baoluos;
}


- (void)viewDidLoad {
    [super viewDidLoad];
 
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
    //初始化两个按钮
    [self initTwoButton];
    
    self.searchThing.selected = YES;
    [self addLine:self.searchThing];
    
    
    //设置输入框键盘类型
    self.textfield.returnKeyType = UIReturnKeySearch;
    self.textfield.delegate = self;
    
}


#pragma mark - 添加静态数据
- (void)addBaoluo{
    
    /**************************包罗*******************************/
    NSMutableArray *arr1 = [NSMutableArray array];
    UIImage *image14 = [UIImage imageNamed:@"img14"];
    [arr1 addObject:image14];
    
    NSMutableArray *arr2 = [NSMutableArray array];
    UIImage *image12 = [UIImage imageNamed:@"img12"];
    UIImage *image13 = [UIImage imageNamed:@"img13"];
    [arr2 addObject:image12];
    [arr2 addObject:image13];
    
    NSMutableArray *arr3 = [NSMutableArray array];
    UIImage *image15 = [UIImage imageNamed:@"img15"];
    [arr3 addObject:image15];
    
    NSMutableArray *arr4 = [NSMutableArray array];
    UIImage *image16 = [UIImage imageNamed:@"img16"];
    [arr4 addObject:image16];
    
    
    HMBaoluo *baoluo1 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"4小时前" price:@"30" images:arr1 title:@"多个螺丝刀" detail:@"螺丝刀，家常必备，如果遇到紧急情况急用螺丝刀的话，我这儿有一把。" broken:@"10"];
    baoluo1.location = @" 300米";
    
    HMBaoluo *baoluo2 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"4小时前" price:@"30" images:arr2 title:@"螺丝刀" detail:@"螺丝刀，家常必备，如果遇到紧急情况急用螺丝刀的话，我这儿有一把。" broken:@"10"];
    baoluo2.location = @" 200米";
    
    HMBaoluo *baoluo3 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"4小时前" price:@"30" images:arr3 title:@"一把螺丝刀" detail:@"螺丝刀，家常必备，如果遇到紧急情况急用螺丝刀的话，我这儿有一把。" broken:@"10"];
    baoluo3.location = @" 340米";
    
    HMBaoluo *baoluo4 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"4小时前" price:@"30" images:arr4 title:@"一套螺丝刀" detail:@"螺丝刀，家常必备，如果遇到紧急情况急用螺丝刀的话，我这儿有一把。" broken:@"10"];
    baoluo4.location = @" 250米";
    
    
    [self.baoluos addObject:baoluo1];
    [self.baoluos addObject:baoluo2];
    [self.baoluos addObject:baoluo3];
    [self.baoluos addObject:baoluo4];
    
}

//文本框搜索按钮监听
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.textfield resignFirstResponder];
    
    [self addBaoluo];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
       [hud hide:YES];
       [self.tableView reloadData];
    });
    
    return YES;
}


//初始化两个按钮
- (void)initTwoButton{
    
    [self.searchThing addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchSkill addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.searchThing setTitleColor:themeColor forState:UIControlStateSelected];
    
    [self.searchSkill setTitleColor:themeColor forState:UIControlStateSelected];
    
}

//点击事件
- (void)searchBtnClick:(UIButton *)searchBtn{
    
    self.searchThing.selected = NO;
    self.searchSkill.selected = NO;
    
    searchBtn.selected = !searchBtn.selected;
    
    [self addLine:searchBtn];
}


//添加线
- (void)addLine:(UIButton *)searchBtn{
    
    CGFloat lineW = searchBtn.frame.size.width + 10;
    CGFloat lineH = 2;
    CGFloat lineX = searchBtn.frame.origin.x - 5;
    CGFloat lineY = 38;
    
    //加点动画
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }];
    
    [self.titleView addSubview:self.bottomLine];
}

//取消按钮
- (IBAction)cancelClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.baoluos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HMSearchCell *cell = [HMSearchCell searchCellWithTableview:tableView];
    
    HMBaoluo *baoluo = self.baoluos[indexPath.row];
    
    cell.baoluo = baoluo;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 98;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.title = @"搜索";
    
    
    HMBaoluo *baoluo = self.baoluos[indexPath.row];
    
    HMThingDetailController *thing = [[HMThingDetailController alloc] init];
    
    thing.view.backgroundColor = [UIColor whiteColor];
    
    thing.baoluo = baoluo;
    
    thing.hidesBottomBarWhenPushed = YES;
    
    thing.navigationItem.title = @"详情";
    
    [self.navigationController showViewController:thing sender:nil];
    
}


@end
