//
//  HMHomeControllerr.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/24.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMHomeControllerr.h"
#import "HMBaoLuoController.h"
#import "HMLoginController.h"
#import "HMPublishController.h"
#import "HMBaoluo.h"
#import "HMBaoluoCell.h"
#import "HMPublish.h"
#import "HMPublishTableCell.h"
#import "HMHeaderView.h"
#import "HMSearchController.h"
#import "HYBEaseInOutTransition.h"
#import "HMSkill.h"
#import "HMSkillCell.h"
#import "HMThingDetailController.h"
#import "HMSkillDetailController.h"
@interface HMHomeControllerr ()<UISearchBarDelegate>

//淡入淡出
@property (nonatomic, strong) HYBEaseInOutTransition *transition;

/**
 *  searchBar成员属性
 */
@property (nonatomic,strong) UISearchBar *searchBar;

/**
 *  活动墙
 */
@property (weak, nonatomic) IBOutlet UIView *activityView;

@property (nonatomic,strong) NSMutableArray *dataList;


@end

@implementation HMHomeControllerr

/**
 *  懒加载数据
 */
- (NSMutableArray *)dataList{
    
    if (_dataList == nil) {
        
        self.dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
#pragma mark - 初始化单例
    HMBaoLuoController *baoluo = [HMBaoLuoController shareBaoluo];
    [HMLoginController shareLogin];
    HMPublishController *publish = [HMPublishController sharePublish];
    
    //给首页添加点数据
    [baoluo addBaoluo];
    [baoluo addSkill];
    [publish addPublish];
    
    //把数据添加到首页Datalist
    [self.dataList addObjectsFromArray:baoluo.baoluos];
    [self.dataList addObjectsFromArray:baoluo.skills];
    //打乱数组顺序
    [self upSetForDataList];
    
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
    //设置活动图片边框与阴影
    [self setActivityStyle];
    
}

//把数据添加到首页Datalist
- (void)upSetForDataList{

    
    for (int i = 0; i < self.dataList.count; i ++) {
        
        int countIndex = (int)self.dataList.count;
        
        int index = (int)arc4random_uniform(countIndex);
        
        id temp = self.dataList[i];
        
        self.dataList[i] = self.dataList[index];
        
        self.dataList[index] = temp;
    
    }
    
}


#pragma mark - 设置活动图片边框与阴影
- (void)setActivityStyle{
    
    for (int i = 0; i < self.activityView.subviews.count; i ++) {
        
        UIView *view = self.activityView.subviews[i];
        
        if ([view isKindOfClass:[UIButton class]]) {
            
            UIButton *button = (UIButton *)view;
            
            button.layer.cornerRadius = 2;
            button.layer.masksToBounds = YES;
            
        }
    }
}

//搜索按钮点击
- (IBAction)searchClick:(id)sender {
    
    [self onPresent];
}


- (void)onPresent {
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *search = [story instantiateViewControllerWithIdentifier:@"searchNav"];
    
    self.transition = [[HYBEaseInOutTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        HYBEaseInOutTransition *modal = (HYBEaseInOutTransition *)transition;
        
        // If you don't specify, it will use default value
        // Default is NO, if set to YES, it will use spring animation.
        modal.animatedWithSpring = NO;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        // do nothing
    }];
    
    search.transitioningDelegate = self.transition;
    [self presentViewController:search animated:YES completion:NULL];
    
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSObject *data = self.dataList[indexPath.row];
    if ([data isKindOfClass:[HMBaoluo class]]) {
        
        HMBaoluo *baoluo = (HMBaoluo *)data;
        
        HMBaoluoCell *BaoluoCell = [HMBaoluoCell baoluoCellWithTableview:tableView];
        
        BaoluoCell.baoluo = baoluo;
        
        
        return BaoluoCell;
        
    }else{
        
        HMSkill *skill = (HMSkill *)data;
        
        HMSkillCell *skillCell = [HMSkillCell skillCellWithTableview:tableView];
        
        skillCell.skill = skill;
        
        return skillCell;
    }
}


#pragma mark - Table view delegate
//选中跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *data = self.dataList[indexPath.row];
    
    if ([data isKindOfClass:[HMBaoluo class]]) {
 
        HMBaoluo *baoluo = (HMBaoluo *)data;
        
        HMThingDetailController *thing = [[HMThingDetailController alloc] init];
        
        thing.view.backgroundColor = [UIColor whiteColor];
        
        thing.baoluo = baoluo;
        
        thing.navigationItem.title = @"详情";
        
        thing.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController showViewController:thing sender:nil];
        
    }else{
        
        HMSkill *skillModel = (HMSkill *)data;
        
        HMSkillDetailController *skill = [[HMSkillDetailController alloc] init];
        
        skill.view.backgroundColor = [UIColor whiteColor];
        
        skill.skill = skillModel;
        
        skill.navigationItem.title = @"详情";
        
        skill.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController showViewController:skill sender:nil];
    }
}



//设定cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSObject *data = self.dataList[indexPath.row];
    if ([data isKindOfClass:[HMBaoluo class]]) {
        
        return 280;
        
    }else{
        
        return 204;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    HMHeaderView *headerView = [HMHeaderView headerView];
    
    return headerView;
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

@end
