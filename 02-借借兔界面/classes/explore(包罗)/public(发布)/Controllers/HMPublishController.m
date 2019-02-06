//
//  HMPublishController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMPublishController.h"
#import "HMPublish.h"
#import "HMPublishTableCell.h"

@interface HMPublishController ()<UITableViewDelegate>



@end

@implementation HMPublishController

#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMPublishController alloc] init];
    
}

//第一次使用类的时候调用（以后再创建也不会执行）
+ (void)initialize{
    
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (instance == nil) {//防止创建多次
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)sharePublish{
    
    
    return instance;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return instance;
}


/************************************************************************************/


/**
 *  懒加载数组
 */
- (NSMutableArray *)publishs{
    
    if (_publishs == nil) {
        
        self.publishs = [[NSMutableArray alloc] init];
    }
    return _publishs;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
}



//添加假数据
- (void)addPublish{
    HMPublish *publish1 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"张三" detail:@"我想要一个篮球"];
    HMPublish *publish2 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"李四" detail:@"我需要找个人代考"];
    HMPublish *publish3 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"王五" detail:@"我需要借个耳机，我耳机坏了，听不了音乐"];
    HMPublish *publish4 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"马六" detail:@"我需要借一身西装，我要参加四代会"];
    HMPublish *publish5 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"杨威" detail:@"我要一个充电宝充电"];
    HMPublish *publish6 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"王龙权" detail:@"我要借本Linux书，忘带了"];
    HMPublish *publish7 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"乔阿斗" detail:@"我Linux作业没做，想找人帮忙抄作业"];
    HMPublish *publish8 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"吴海斌" detail:@"我想要一个篮球"];
    HMPublish *publish9 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"陈苏杭" detail:@"我想要一个篮球"];
    HMPublish *publish10 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"黄敏" detail:@"我想要一个篮球"];
    HMPublish *publish11 = [HMPublish publishWithIcon:@"ic_account_circle_18pt" name:@"赵亮" detail:@"我想要一个篮球"];
    
    
    [self.publishs addObject:publish1];
    [self.publishs addObject:publish2];
    [self.publishs addObject:publish3];
    [self.publishs addObject:publish4];
    [self.publishs addObject:publish5];
    [self.publishs addObject:publish6];
    [self.publishs addObject:publish7];
    [self.publishs addObject:publish8];
    [self.publishs addObject:publish9];
    [self.publishs addObject:publish10];
    [self.publishs addObject:publish11];
    
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.publishs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HMPublish *publish = self.publishs[indexPath.row];
    
    HMPublishTableCell *cell = [HMPublishTableCell publishCellWithTableview:tableView];
    
    
    cell.publish = publish;
    
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 85;
}

/**
 *  设置cell颜色
 *
 *  @param tableView
 *  @param cell
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
}


@end
