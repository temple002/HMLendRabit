//
//  HMBorrowingController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/28.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMOrderController.h"
#import "HMOrderCell.h"
#import "HMBaoluo.h"
#import "HMSkill.h"
#import "HMThingDetailController.h"
#import "HMSkillDetailController.h"
#import "MBProgressHUD.h"

@interface HMOrderController ()

@property (nonatomic,strong) NSMutableArray *orders;

@property (nonatomic,strong) UIImageView *imageV;


@end

@implementation HMOrderController

#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMOrderController alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    
    if (instance == nil) {//防止创建多次
        instance = [super allocWithZone:zone];
    }
    return instance;
}

+ (instancetype)shareHMOrderController{
    
    return instance;
    
}

- (id)copyWithZone:(NSZone *)zone{
    
    return instance;
}

/**********************************************************************************/


//懒加载
- (NSMutableArray *)orders{
    
    if (_orders == nil) {
        
        self.orders = [NSMutableArray array];
    }
    return _orders;
}

- (UIImageView *)imageV{
    
    if (_imageV == nil) {
        
        CGFloat imageVw = 300;
        CGFloat imageVh = 360;
        UIWindow * window = [UIApplication sharedApplication].keyWindow;
        CGFloat imageVx = (window.bounds.size.width - imageVw) * 0.5;
        CGFloat imageVy = (window.bounds.size.height - imageVh) * 0.5;
        
        self.imageV = [[UIImageView alloc] init];
        
        self.imageV.frame = CGRectMake(imageVx, imageVy, imageVw, imageVh);
        
        self.imageV.layer.cornerRadius = 3;
        
        //拉伸方式
        self.imageV.contentMode = UIViewContentModeScaleAspectFill;
        self.imageV.layer.borderWidth = 3;
        
        //图像裁剪
        self.imageV.layer.masksToBounds = YES;
        
    }
    return _imageV;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView setBackgroundColor:bgColor];
    
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
    
    [self.orders addObject:baoluo1];
    [self.orders addObject:skill1];
    
}

//添加订单
- (void)addOrder:(id)order{
    [self.orders addObject:order];
    
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.orders.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id data = self.orders[indexPath.row];
    
    HMOrderCell *cell = [HMOrderCell orderCellWithTableview:tableView];
    
    //弹出提示框去拍照
    cell.block = ^(UIAlertController *alert){
        [self presentViewController:alert animated:YES completion:nil];
    };
    
    //弹出拍照界面
    cell.cameraBlock = ^(UIImagePickerController *picker){
        [self presentViewController:picker animated:YES completion:nil];
    };
    
    //传图片
    cell.imageBlock = ^(UIImage *image){
        
        self.imageV.image = image;
        
        [self imageAnimation:self.imageV];
    };
    
    cell.data = data;
    
    return cell;
}

//设置高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 142;
}

//点中进入详情页
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id data = self.orders[indexPath.row];
    
    if ([data isKindOfClass:[HMBaoluo class]]) {
        
        HMBaoluo *baoluo = (HMBaoluo *)data;
        
        HMThingDetailController *thing = [[HMThingDetailController alloc] init];
        
        thing.view.backgroundColor = [UIColor whiteColor];
        
        thing.baoluo = baoluo;
        
        thing.hidesBottomBarWhenPushed = YES;
        
        thing.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:thing sender:nil];
        
    }else{
        
        HMSkill *skillModel = (HMSkill *)data;
        
        HMSkillDetailController *skill = [[HMSkillDetailController alloc] init];
        
        skill.view.backgroundColor = [UIColor whiteColor];
        
        skill.skill = skillModel;
        
        skill.hidesBottomBarWhenPushed = YES;
        
        skill.navigationItem.title = @"详情";
        
        [self.navigationController showViewController:skill sender:nil];
    }
}

//显示照片
- (void)imageAnimation:(UIImageView *)imageV{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.imageV];
    
    [self bounceIn];
    
}

//显示图片动画
- (void)bounceIn{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //增加几个动画
        CABasicAnimation *basic = [CABasicAnimation animation];
        basic.keyPath = @"position";
        basic.toValue = [NSValue valueWithCGPoint:CGPointMake(30, 44)];
        
        CABasicAnimation *basic3 = [CABasicAnimation animation];
        basic3.keyPath = @"transform.scale";
        basic3.toValue = @0.1;
        
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.animations = @[basic,basic3];
        group.duration = 0.8;
        
        group.removedOnCompletion = NO;
        group.fillMode = kCAFillModeForwards;
        
        [_imageV.layer addAnimation:group forKey:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [_imageV.layer removeAllAnimations];
            
            [_imageV removeFromSuperview];
            
            [self showHUD:@"已添加到我借到的"];
        });
        
    });
    
}
//显示消息
- (void)showHUD:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}


@end
