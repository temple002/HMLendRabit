//
//  HMAddPublishController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMAddPublishController.h"
#import "UIImage+resizeImage.h"
#import "HMBaoluo.h"
#import "HMConst.h"
#import "HMBaoLuoController.h"
#import "HMToolBar.h"
#import "MBProgressHUD+MJ.h"
@interface HMAddPublishController ()


/**
 *  发布按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *btn_publish;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UITextField *titleView;

/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UITextView *detailView;

/**
 *  价格
 */
@property (weak, nonatomic) IBOutlet UITextField *priceView;

/**
 *  损坏赔偿
 */
@property (weak, nonatomic) IBOutlet UITextField *brokenPrice;

@end

@implementation HMAddPublishController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置键盘
    self.priceView.keyboardType = UIKeyboardTypeNumberPad;
    self.brokenPrice.keyboardType = UIKeyboardTypeNumberPad;
    //添加toolbar
    [self addToolBar];
    
    //添加键盘监听
    //键盘监听
    //不需要发送者，只要触发键盘就监听到。
    NSNotificationCenter *center=[NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

//键盘监听事件执行的方法
-(void)keyBoardChange:(NSNotification *)userInfo{
    
    if ([self.priceView isEditing] || [self.brokenPrice isEditing]) {
        //获取键盘最终的位置
        CGRect rectEnd=[userInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        CGFloat keyBoardY=rectEnd.origin.y;

        //用键盘的Y减去屏幕的高度。
        CGFloat transformY = keyBoardY - self.view.frame.size.height;
        
        //增加动画
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform=CGAffineTransformMakeTranslation(0, transformY);
        }];
    }
}

//添加toolbar
- (void)addToolBar{
    
    HMToolBar *priceToolBar = [HMToolBar toolBar];
    
    //设置键盘toolbar
    self.priceView.inputAccessoryView = priceToolBar;
    self.brokenPrice.inputAccessoryView = priceToolBar;
    //退出键盘
    priceToolBar.block = ^(){
        [self.priceView resignFirstResponder];
        [self.brokenPrice resignFirstResponder];
    };
    
}


//添加图片按钮点击事件
- (IBAction)addPicClick:(id)sender {
    
    
}

//退出键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


//取消按钮
- (IBAction)cancelClick:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//发布按钮点击事件
- (IBAction)publishBtnClick:(id)sender {
    
    NSMutableArray *arr = [NSMutableArray array];
    UIImage *image1 = [UIImage imageNamed:@"img01"];
    UIImage *image2 = [UIImage imageNamed:@"img02"];
    UIImage *image3 = [UIImage imageNamed:@"img03"];
    UIImage *image4 = [UIImage imageNamed:@"img04"];
    
    [arr addObject:image1];
    [arr addObject:image2];
    [arr addObject:image3];
    [arr addObject:image4];
    
    
    //只有填了信息才发布
    if (self.titleView.text.length && self.priceView.text.length && self.detailView.text.length && self.brokenPrice.text.length) {
        
        //推出此界面
        [self dismissViewControllerAnimated:YES completion:nil];
        
        HMBaoluo *baoluo = [HMBaoluo baoluoWithIcon:[UIImage imageNamed:@"ic_account_circle_18pt"] username:@"王五" lastTime:@"1小时前" price:self.priceView.text images:arr title:self.titleView.text detail:self.detailView.text broken:self.brokenPrice.text];
        
        NSDictionary *userInfo = @{
                                   HMDidAddBaoluoNotificationKey : baoluo
                                   };
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HMDidAddBaoluoNotification object:nil userInfo:userInfo];
        
    }else{
        [MBProgressHUD showError:@"请完整填写信息"];
    }
}


@end
