//
//  HMCollectController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/26.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMCollectController.h"
#import "HMBaoluoCell.h"
#import "HMSkillCell.h"
#import "HMBaoluo.h"
#import "HMSkill.h"
#import "HMThingDetailController.h"
#import "HMSkillDetailController.h"

@interface HMCollectController ()

//借物数据
@property (nonatomic,strong) NSMutableArray *collectList;

@end

@implementation HMCollectController

#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMCollectController alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (instance == nil) {//防止创建多次
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)shareCollectController{
    
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
    
}

//懒加载
- (NSMutableArray *)collectList{
    
    if (_collectList == nil) {
        
        self.collectList = [NSMutableArray array];
    }
    return _collectList;
}

//添加借物记录
- (void)addCollectThing:(id)collect{
    
    if (collect) {
        [self.collectList addObject:collect];
        [self.tableView reloadData];
    }
}
//删除借物记录
- (void)deleteCollectThing:(id)collect{
    if (collect) {
        
        for (int i = 0; i < self.collectList.count; i ++) {
            if (self.collectList[i] == collect) {
                [self.collectList removeObject:self.collectList[i]];
            }
        }
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.collectList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id obj = self.collectList[indexPath.row];
    
    if ([obj isKindOfClass:[HMBaoluo class]]) {
        
        HMBaoluoCell *cell = [HMBaoluoCell baoluoCellWithTableview:tableView];
        HMBaoluo *baoluo = (HMBaoluo *)obj;
        cell.baoluo = baoluo;
        
        return cell;
    }else{
        
        HMSkillCell *cell = [HMSkillCell skillCellWithTableview:tableView];
        HMSkill *skill = (HMSkill *)obj;
        cell.skill = skill;
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id obj = self.collectList[indexPath.row];
    
    if ([obj isKindOfClass:[HMBaoluo class]]) {
        
        return 280;
    }else{
        return 204;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
     id obj = self.collectList[indexPath.row];
    
    if ([obj isKindOfClass:[HMBaoluo class]]) {
        
        HMBaoluo *baoluo = (HMBaoluo *)obj;
        
        HMThingDetailController *thing = [[HMThingDetailController alloc] init];
        
        thing.view.backgroundColor = [UIColor whiteColor];
        
        thing.baoluo = baoluo;
        
        thing.hidesBottomBarWhenPushed = YES;
        
        thing.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:thing sender:nil];
    }else{
        
        HMSkill *skillModel = (HMSkill *)obj;
        
        HMSkillDetailController *skill = [[HMSkillDetailController alloc] init];
        
        skill.view.backgroundColor = [UIColor whiteColor];
        
        skill.skill = skillModel;
        
        skill.hidesBottomBarWhenPushed = YES;
        
        skill.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:skill sender:nil];
    }
    
    
}


@end
