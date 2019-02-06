//
//  HMRegisterController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/4.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMRegisterController.h"
#import "HMLoginOnController.h"
#import "MBProgressHUD+MJ.h"
@interface HMRegisterController ()

//注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

//注册界面textfield
@property (weak, nonatomic) IBOutlet UITextField *stuNum;
@property (weak, nonatomic) IBOutlet UITextField *psw;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *mail;
@property (weak, nonatomic) IBOutlet UITextField *name;

@end

@implementation HMRegisterController


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.registerBtn.layer.borderColor = [UIColor colorWithRed:87/255.0 green:176/255.0 blue:7/255.0 alpha:1].CGColor;
    
    self.registerBtn.layer.borderWidth = 1;
    
    self.registerBtn.layer.cornerRadius = 2;
    
    //设置键盘样式
    self.phone.keyboardType = UIKeyboardTypePhonePad;
    
}

//返回按钮
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//注册按钮
- (IBAction)registerClick:(id)sender {
    
    NSString *stuNum = self.stuNum.text;
    NSString *psw = self.psw.text;
    NSString *phone = self.phone.text;
    NSString *mail = self.mail.text;
    NSString *name = self.name.text;
    
    
    if (stuNum.length && psw.length && phone.length && mail && name.length) {
        
        //退回到登录界面
        [self back:nil];
        
        if ([self.delegate respondsToSelector:@selector(HMRegisterController:stuNum:psw:name:)]) {
            [self.delegate HMRegisterController:self stuNum:stuNum psw:psw name:name];
        }
    }else{
        [MBProgressHUD showError:@"请补全信息"];
    }
}

//点击空白处退出键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
