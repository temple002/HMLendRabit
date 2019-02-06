//
//  HMBaoLuoController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/21.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMBaoLuoController.h"
#import "HMBaoluo.h"
#import "HMBaoluoCell.h"
#import "HMConst.h"
#import "MenuScroll.h"
#import "HMSkill.h"
#import "HMSkillCell.h"
#import "HMThingDetailController.h"
#import "HMSkillDetailController.h"
@interface HMBaoLuoController ()
/**
 *  分段控制
 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;

/**
 *  menuScroll
 */
@property (nonatomic,strong) MenuScroll *menuView;


/**
 *  判断物品还是技能segment选中
 */
@property (nonatomic,assign) BOOL isThingSeg;


@end

@implementation HMBaoLuoController


#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMBaoLuoController alloc] init];
    
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

+ (instancetype)shareBaoluo{
    
    //添加监听看要不要添加baoluo
    [[NSNotificationCenter defaultCenter] addObserver:instance selector:@selector(didAddBaoluo:) name:HMDidAddBaoluoNotification object:nil];
    
    
    return instance;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return instance;
}


/************************************************************************************/


//懒加载
- (NSMutableArray *)baoluos{
    
    if (_baoluos == nil) {
        
        self.baoluos = [NSMutableArray array];
    }
    return _baoluos;
}

- (NSMutableArray *)skills{
    
    if (_skills == nil) {
        
        self.skills = [[NSMutableArray alloc] init];
    }
    return _skills;
}

- (MenuScroll *)menuView{
    
    if (_menuView == nil) {
        
        self.menuView = [MenuScroll menuScroll];
    }
    return _menuView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置包罗界面标题
    self.navigationItem.title = @"包罗";
    
    //一开始默认是物品选中
    self.isThingSeg = YES;
    self.segmentControl.selectedSegmentIndex = 0;
    
    //设置背景
    [self.view setBackgroundColor:bgColor];
    
    //推出此界面
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //设置标题segment大小
    CGRect frame= self.segmentControl.frame;
    [self.segmentControl setFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width,28)];
    
    
    /*******************滚动scroll******************************/
    
    //定义标题
    NSArray *menus = @[@"全部",@"文具",@"体育",@"图书",@"数码",@"服装",@"其他"];
    
    self.menuView.frame = CGRectMake(0, 0, 320,38);
    
    [self.menuView addMenus:menus];
    
    
    /*************************************************/
}

#pragma mark - segmentControl监听
- (IBAction)segmentClick:(id)sender {
    
    if (self.segmentControl.selectedSegmentIndex == 0) {
        
        
        [self addBaoluo];
        
        [self.skills removeAllObjects];
        
        self.isThingSeg = YES;
        
        //改变menu
        NSArray *menus = @[@"全部",@"文具",@"体育",@"图书",@"数码",@"服装",@"其他"];
        [self.menuView deleteMenus];
        [self.menuView addMenus:menus];
        
        [self.tableView reloadData];
        
        
    }else if(self.segmentControl.selectedSegmentIndex == 1){
        
        [self.skills removeAllObjects];
        
        [self addSkill];
        
        [self.baoluos removeAllObjects];
        
        self.isThingSeg = NO;
        
        //改变menu
        NSArray *menus = @[@"帮作业",@"帮取物品",@"球赛缺人",@"送外卖",@"一起旅游",@"寄快递",@"其他"];
        [self.menuView deleteMenus];
        [self.menuView addMenus:menus];
        
        [self.tableView reloadData];
        
    }
}




#pragma mark - 添加静态数据
- (void)addBaoluo{

    /**************************包罗*******************************/
    
    NSMutableArray *arr1 = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"img01"];
    UIImage *image2 = [UIImage imageNamed:@"img02"];
    UIImage *image3 = [UIImage imageNamed:@"img03"];
    
    [arr1 addObject:image1];
    [arr1 addObject:image2];
    [arr1 addObject:image3];
    
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
    
    NSMutableArray *arr3 = [NSMutableArray array];
    UIImage *image9 = [UIImage imageNamed:@"img09"];
    UIImage *image10 = [UIImage imageNamed:@"img10"];
    UIImage *image11= [UIImage imageNamed:@"img11"];
    [arr3 addObject:image9];
    [arr3 addObject:image10];
    [arr3 addObject:image11];
    
    NSMutableArray *arr4 = [NSMutableArray array];
    UIImage *image12 = [UIImage imageNamed:@"img12"];
    UIImage *image13 = [UIImage imageNamed:@"img13"];
    [arr4 addObject:image12];
    [arr4 addObject:image13];
    
    HMBaoluo *baoluo1 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"1小时前" price:@"150" images:arr1 title:@"十字绣" detail:@"盆景十字绣，纯手工，无错针，无瑕疵，房间必备品装饰品。" broken:@"200"];
    baoluo1.isBorrowed = NO;
    
    HMBaoluo *baoluo2 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"吴海斌" lastTime:@"2小时前" price:@"300" images:arr3 title:@"电饭锅" detail:@"苏泊尔电饭锅，八成新，用过两三次，设备齐全，人口数量增多，用不上了，可以出借。" broken:@"100"];
    baoluo2.isBorrowed = NO;
    
    HMBaoluo *baoluo3 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"陈鑫远" lastTime:@"3小时前" price:@"500" images:arr2 title:@"樱桃茶轴机械键盘" detail:@"樱桃MX-Board 3.0黑色茶轴机械键盘，本人学编程，认为机械键盘可以帮助打字速度，但是有了笔记本电脑觉得外接键盘比较多余。才买了一个多月，一直没怎么用，想借的同学尽快联系我。" broken:@"500"];
    baoluo3.isBorrowed = NO;
    
    HMBaoluo *baoluo4 = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"4小时前" price:@"30" images:arr4 title:@"螺丝刀" detail:@"螺丝刀，家常必备，如果遇到紧急情况急用螺丝刀的话，我这儿有一把。" broken:@"10"];
    
    [self.baoluos addObject:baoluo1];
    [self.baoluos addObject:baoluo2];
    [self.baoluos addObject:baoluo3];
    [self.baoluos addObject:baoluo4];
    
   
}

- (void)addSkill{
    /**************************技能*******************************/
    
    HMSkill *skill1 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"乔阿斗" lastTime:@"1小时前" price:@"20" skillDes:@"打篮球" skillContent:@"本人会打篮球，参加过校级，省级，全国级篮球比赛并获得优异的成绩，我热爱篮球，从小就开始练，觉得篮球是我的生命。如果球赛确认随时可以叫我。"];
    skill1.isBorrowed = NO;
    
    HMSkill *skill2 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"杨威" lastTime:@"2小时前" price:@"20" skillDes:@"带饭" skillContent:@"本人在学校闲的没事干，想赚点信用值借别人的苹果电脑用用，本人什么外卖都可以帮忙带，只要一个电话。"];
    skill2.isBorrowed = NO;
    
    HMSkill *skill3 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"黄敏" lastTime:@"3小时前" price:@"5" skillDes:@"旅游" skillContent:@"本人喜欢旅游，曾经游过北京，三亚，九寨沟，黄山等等，我喜欢旅游，觉得旅游让我的心得到进化，忘记所有烦恼，如果哪个班春游缺人的话可以考虑我一个。"];
    skill3.isBorrowed = NO;
    
    HMSkill *skill4 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"二毛" lastTime:@"4小时前" price:@"20" skillDes:@"教考研知识" skillContent:@"本人才高八斗，学富五车，对考研这方面的知识钻研很深，考研数学，政治，英语等等都不在话下，我有一套很有用的教学方法，想考研通过的同学和我说一下哦，我全面辅导。PS:我是个帅哥。"];
    skill4.isBorrowed = NO;
    
    HMSkill *skill5 = [HMSkill skillWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"王龙权" lastTime:@"4小时前" price:@"20" skillDes:@"修电脑" skillContent:@"本人专业修电脑一百年，各类电脑问题都会，本人不追求钱，追求乐于帮助"];
    
    
    [self.skills addObject:skill1];
    [self.skills addObject:skill2];
    [self.skills addObject:skill3];
    [self.skills addObject:skill4];
    [self.skills addObject:skill5];
}

//实现通知方法
- (void)didAddBaoluo:(NSNotification *)note{
    
    HMBaoluo *baoluo = note.userInfo[HMDidAddBaoluoNotificationKey];
    
    //插入数组
    [self.baoluos insertObject:baoluo atIndex:0];
    
    //刷新数据
    [self.tableView reloadData];
    
}


//控制器销毁时，停止监听
- (void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.isThingSeg) {
        return self.baoluos.count;
    }else{
        return self.skills.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isThingSeg) {
        HMBaoluoCell *cell = [HMBaoluoCell baoluoCellWithTableview:tableView];
        
        HMBaoluo *baoluo = self.baoluos[indexPath.row];
        
        cell.baoluo = baoluo;
        
        return cell;
    }else{
        
        HMSkillCell *cell = [HMSkillCell skillCellWithTableview:tableView];
        
        HMSkill *skill = self.skills[indexPath.row];
        
        cell.skill = skill;
        
        return cell;
    }
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isThingSeg) {
        
        HMBaoluo *baoluo = self.baoluos[indexPath.row];
        
        HMThingDetailController *thing = [[HMThingDetailController alloc] init];
        
        thing.view.backgroundColor = [UIColor whiteColor];
        
        thing.baoluo = baoluo;
        
        thing.hidesBottomBarWhenPushed = YES;
        
        thing.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:thing sender:nil];
        
    }else{
        
        HMSkill *skillModel = self.skills[indexPath.row];
        
        HMSkillDetailController *skill = [[HMSkillDetailController alloc] init];
        
        skill.view.backgroundColor = [UIColor whiteColor];
        
        skill.skill = skillModel;
        
        skill.hidesBottomBarWhenPushed = YES;
        
        skill.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:skill sender:nil];
        
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.isThingSeg) {
        return 280;
    }else{
        return 204;
    }
    
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    
    return self.menuView;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 38;
}

@end
