//
//  HMLoginOnController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/24.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMLoginOnController.h"
#import "HMRegisterController.h"
#import "HYBEaseInOutTransition.h"
#import "MBProgressHUD+MJ.h"
#import "MBProgressHUD.h"
#import "HMLoginController.h"

@interface HMLoginOnController ()<HMRegisterControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *studentNum;
@property (weak, nonatomic) IBOutlet UITextField *pwd;

//昵称
@property (nonatomic,copy) NSString *name;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//淡入淡出
@property (nonatomic, strong) HYBEaseInOutTransition *transition;

@end

@implementation HMLoginOnController

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    [UIView transitionWithView:self.view duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        
    } completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.loginBtn.layer.borderColor = themeColor.CGColor;
    
    self.loginBtn.layer.borderWidth = 1;
    
    self.loginBtn.layer.cornerRadius = 2;
}


//登录按钮点击
- (IBAction)loginBtnClick:(id)sender {
    
    NSString *stuNum = self.studentNum.text;
    NSString *pwd = self.pwd.text;
    
    //判断是否输入完整
    if (stuNum.length && pwd.length) {
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        hud.labelText = @"正字登录...";
        
        hud.mode = MBProgressHUDModeIndeterminate;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [hud hide:YES];
            
            //让tabbar选中我的界面
            if (self.dismissBlock) {
                
                self.dismissBlock();
            }
            
            //设置用户名
            HMLoginController *login = [HMLoginController shareLogin];
            [login setUsername:self.name];
            
            //退出键盘
            [self.view endEditing:YES];
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
    }else{
        
        [MBProgressHUD showError:@"请补全信息"];
    }
}

//关闭
- (IBAction)closeClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//点击注册按钮
- (IBAction)registerBtnClick:(id)sender {
    
    [self onPresent];
}

- (void)onPresent{
    UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    
    HMRegisterController* registerOn =[story instantiateViewControllerWithIdentifier:@"register"];
    
    registerOn.delegate = self;
    
    self.transition = [[HYBEaseInOutTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        HYBEaseInOutTransition *modal = (HYBEaseInOutTransition *)transition;
        
        modal.animatedWithSpring = NO;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
    }];
    
    registerOn.transitioningDelegate = self.transition;
    [self presentViewController:registerOn animated:YES completion:NULL];

}

#pragma mark - 代理方法，传值
- (void)HMRegisterController:(HMRegisterController *)regist stuNum:(NSString *)stuNum psw:(NSString *)psw name:(NSString *)name{
    
    self.studentNum.text = stuNum;
    self.pwd.text = psw;
    self.name = name;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loginBtnClick:nil];
    });
}

//点击空白处退出键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
