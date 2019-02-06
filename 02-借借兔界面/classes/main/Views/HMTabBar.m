//
//  HMTabBar.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMTabBar.h"
#import "HMAddPublishController.h"
#import "HMLoginController.h"
#import "HMLoginOnController.h"
@interface HMTabBar ()

//图标
@property (weak, nonatomic) IBOutlet UIButton *home;
@property (weak, nonatomic) IBOutlet UIButton *baoluo;
@property (weak, nonatomic) IBOutlet UIButton *publish;
@property (weak, nonatomic) IBOutlet UIButton *mine;

//文字
@property (weak, nonatomic) IBOutlet UILabel *label_home;
@property (weak, nonatomic) IBOutlet UILabel *label_baoluo;
@property (weak, nonatomic) IBOutlet UILabel *label_publish;
@property (weak, nonatomic) IBOutlet UILabel *label_mine;

/**
 * 背景图
 */
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (nonatomic,strong) HMLoginController *login;

@end

@implementation HMTabBar


#pragma mark - 单例对象
/**********************************************************************************/

static id instance;

//load方法在调用内存中就调用一次，之调用一次
+ (void)load{
    instance = [[HMTabBar alloc] init];
    
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

+ (instancetype)shareTabBar{
    
    
    return instance;
    
}

/************************************************************************************/

- (void)awakeFromNib{
    HMLoginController *login = [HMLoginController shareLogin];
    self.login = login;
    
    self.backImageView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.backImageView.layer.shadowOpacity = 0.1;
    self.backImageView.layer.shadowRadius = 4;
    
    [self.home setImage:[UIImage imageNamed:@"11#"] forState:UIControlStateSelected];
    [self.baoluo setImage:[UIImage imageNamed:@"22#"] forState:UIControlStateSelected];
    [self.publish setImage:[UIImage imageNamed:@"33#"] forState:UIControlStateSelected];
    [self.mine setImage:[UIImage imageNamed:@"44#"] forState:UIControlStateSelected];
    
    self.home.selected = YES;
    self.label_home.textColor = themeColor;
    
}


+ (instancetype)tabbar{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HMTabBar" owner:nil options:nil] lastObject];
    
}


#pragma mark - 底部菜单栏点击监听

- (IBAction)publishClick:(id)sender {
    self.mine.selected = NO;
    self.publish.selected = YES;
    self.baoluo.selected = NO;
    self.home.selected = NO;
    self.label_home.textColor = [UIColor grayColor];
    self.label_baoluo.textColor = [UIColor grayColor];
    self.label_publish.textColor = themeColor;
    self.label_mine.textColor = [UIColor grayColor];
    //调用block
    if (_block) {
        _block(2);
    }
}

- (IBAction)mineClick:(id)sender {
    
    if ([self.login ifLoginOn]) {
        
        self.mine.selected = YES;
        self.publish.selected = NO;
        self.baoluo.selected = NO;
        self.home.selected = NO;
        self.label_home.textColor = [UIColor grayColor];
        self.label_baoluo.textColor = [UIColor grayColor];
        self.label_publish.textColor = [UIColor grayColor];
        self.label_mine.textColor = themeColor;
        //调用block
        if (_block) {
            _block(3);
        }
    }else{
        //跳到登录界面
        if (_jump2LoginBlock) {
            _jump2LoginBlock();
        }
        
    }
}

- (IBAction)homeClick:(id)sender {
    self.mine.selected = NO;
    self.publish.selected = NO;
    self.baoluo.selected = NO;
    self.home.selected = YES;
    self.label_home.textColor = themeColor;
    self.label_baoluo.textColor = [UIColor grayColor];
    self.label_publish.textColor = [UIColor grayColor];
    self.label_mine.textColor = [UIColor grayColor];
    //调用block
    if (_block) {
        _block(0);
    }
}

- (IBAction)baoluoClick:(id)sender {
    self.mine.selected = NO;
    self.publish.selected = NO;
    self.baoluo.selected = YES;
    self.home.selected = NO;
    self.label_home.textColor = [UIColor grayColor];
    self.label_baoluo.textColor = themeColor;
    self.label_publish.textColor = [UIColor grayColor];
    self.label_mine.textColor = [UIColor grayColor];
    //调用block
    if (_block) {
        _block(1);
    }
}
@end
