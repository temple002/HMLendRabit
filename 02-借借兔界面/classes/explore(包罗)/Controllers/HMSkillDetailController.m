//
//  HMSkillDetailController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/8.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMSkillDetailController.h"
#import "HMSkill.h"
#import "NSString+NSStringExtr.h"
#import "MBProgressHUD.h"
#import "SFDraggableDialogView.h"
#import "HMBorrowedController.h"
#import "HMLoginController.h"
#import "HMCollectController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "HMInfoController.h"
#import "HMOrderController.h"

@interface HMSkillDetailController ()<SFDraggableDialogViewDelegate>

//控件都放到一个scrollview上面
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *icon;

@property (nonatomic,strong) UILabel *username;

@property (nonatomic,strong) UILabel *lastTime;

@property (nonatomic,strong) UILabel *price;

@property (nonatomic,strong) UILabel *skillNameHead;

@property (nonatomic,strong) UILabel *skillName;

@property (nonatomic,strong) UILabel *skillDetailHead;

@property (nonatomic,strong) UILabel *skillDetail;

@property (nonatomic,strong) CTCallCenter *call;

//打电话
@property (nonatomic,strong) UIWebView *webView;

//底部菜单栏
@property (nonatomic,strong) UIView *bottomView;

@end

@implementation HMSkillDetailController

#pragma mark -懒加载


- (UIScrollView *)scrollView{
    
    if (_scrollView == nil) {
        
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.scrollEnabled = YES;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIImageView *)icon{
    
    if (_icon == nil) {
        
        self.icon = [[UIImageView alloc] init];
    }
    return _icon;
}

- (UILabel *)username{
    
    if (_username == nil) {
        
        self.username = [[UILabel alloc] init];
        self.username.font = usernameFont;
    }
    return _username;
}

- (UILabel *)lastTime{
    
    if (_lastTime == nil) {
        
        self.lastTime = [[UILabel alloc] init];
        self.lastTime.textColor = [UIColor lightGrayColor];
        self.lastTime.font = lastTimeFont;
    }
    return _lastTime;
}

- (UILabel *)price{
    
    if (_price == nil) {
        
        self.price = [[UILabel alloc] init];
        [self.price setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
        
        self.price.textAlignment = NSTextAlignmentRight;
        self.price.font = priceFont;
        self.price.textColor = themeColor;
    }
    return _price;
}

- (UILabel *)skillNameHead{
    
    if (_skillNameHead == nil) {
        
        self.skillNameHead = [[UILabel alloc] init];
        self.skillNameHead.textColor = [UIColor whiteColor];
        self.skillNameHead.font = HeadFont;
        self.skillNameHead.text = @"-技能名称-";
        self.skillNameHead.textAlignment = NSTextAlignmentCenter;
        [self.skillNameHead setBackgroundColor:themeColor];
    }
    return _skillNameHead;
}

- (UILabel *)skillName{
    
    if (_skillName == nil) {
        
        self.skillName = [[UILabel alloc] init];
        self.skillName.font = titleFont;
        self.skillName.numberOfLines = 0;
    }
    return _skillName;
}

- (UILabel *)skillDetailHead{
    
    if (_skillDetailHead == nil) {
        
        self.skillDetailHead = [[UILabel alloc] init];
        self.skillDetailHead.textColor = [UIColor whiteColor];
        self.skillDetailHead.font = HeadFont;
        self.skillDetailHead.text = @"-技能描述-";
        self.skillDetailHead.textAlignment = NSTextAlignmentCenter;
        [self.skillDetailHead setBackgroundColor:themeColor];
    }
    return _skillDetailHead;
}

- (UILabel *)skillDetail{
    
    if (_skillDetail == nil) {
        
        self.skillDetail = [[UILabel alloc] init];
        self.skillDetail.font = titleFont;
        self.skillDetail.numberOfLines = 0;
    }
    return _skillDetail;
}

- (UIWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}


- (UIView *)bottomView{
    
    if (_bottomView == nil) {
        
        self.bottomView = [[UIView alloc] init];
        self.bottomView.backgroundColor = [UIColor whiteColor];
        
        CGFloat bottomW = self.view.bounds.size.width;
        CGFloat bottomH = 44;
        CGFloat bottomX = 0;
        CGFloat bottomY = self.view.bounds.size.height - bottomH;
        self.bottomView.frame = CGRectMake(bottomX, bottomY, bottomW, bottomH);
        
        //留言按钮
        UIButton *message = [[UIButton alloc] init];
        [message setTitle:@"留言" forState:UIControlStateNormal];
        message.titleLabel.font = [UIFont systemFontOfSize:12];
        [message setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [message setImage:[UIImage imageNamed:@"icon_item_comment"] forState:UIControlStateNormal];
        CGFloat messageW = 60;
        CGFloat messageH = 22;
        CGFloat messageX = 10;
        CGFloat messageY = 12;
        message.frame = CGRectMake(messageX, messageY, messageW, messageH);
        
        //收藏按钮
        UIButton *collect = [[UIButton alloc] init];
        [collect setTitle:@"收藏" forState:UIControlStateNormal];
        collect.titleLabel.font = [UIFont systemFontOfSize:12];
        [collect setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [collect setImage:[UIImage imageNamed:@"icon_item_favorite"] forState:UIControlStateNormal];
        [collect setImage:[UIImage imageNamed:@"icon_item_favorite_highlight"] forState:UIControlStateSelected];
        [collect addTarget:self action:@selector(collectClick:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat collectW = 60;
        CGFloat collectH = 22;
        CGFloat collectX = CGRectGetMaxX(message.frame);
        CGFloat collectY = 12;
        collect.frame = CGRectMake(collectX, collectY, collectW, collectH);
        
        //我想借
        UIButton *borrow = [[UIButton alloc] init];
        //添加监听
        [borrow addTarget:self action:@selector(IWantBorrow:) forControlEvents:UIControlEventTouchUpInside];
        
        [borrow setTitle:@"我想寻求帮助" forState:UIControlStateNormal];
        borrow.titleLabel.font = [UIFont systemFontOfSize:15];
        [borrow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [borrow setBackgroundColor:themeColor];
        
        CGFloat borrowW = 100;
        CGFloat borrowH = 44;
        CGFloat borrowX = self.bottomView.bounds.size.width - borrowW;
        CGFloat borrowY = 0;
        borrow.frame = CGRectMake(borrowX, borrowY, borrowW, borrowH);
        
        [self.bottomView addSubview:message];
        [self.bottomView addSubview:collect];
        [self.bottomView addSubview:borrow];
    }
    return _bottomView;
}

//点击我想要
- (void)IWantBorrow:(UIButton *)borrow{
    
    HMLoginController *login = [HMLoginController shareLogin];
    
    //登录才能查看
    if ([login ifLoginOn]) {
        if (!self.skill.isBorrowed) {
            SFDraggableDialogView *dialogView = [[[NSBundle mainBundle] loadNibNamed:@"SFDraggableDialogView" owner:self options:nil] firstObject];
            dialogView.frame = self.view.bounds;
            dialogView.photo = [UIImage imageNamed:@"big_icon"];
            dialogView.delegate = self;
            dialogView.titleText = [[NSMutableAttributedString alloc] initWithString:@"王龙权"];
            dialogView.messageText = [self exampleAttributeString];
            dialogView.firstBtnText = [@"拨打" uppercaseString];
            dialogView.dialogBackgroundColor = [UIColor whiteColor];
            dialogView.cornerRadius = 8.0;
            dialogView.backgroundShadowOpacity = 0.2;
            dialogView.hideCloseButton = true;
            dialogView.showSecondBtn = false;
            dialogView.contentViewType = SFContentViewTypeDefault;
            dialogView.firstBtnBackgroundColor = themeColor;
            [dialogView createBlurBackgroundWithImage:[self jt_imageWithView:self.view] tintColor:[[UIColor blackColor] colorWithAlphaComponent:0.35] blurRadius:60.0];
            
            [self.view addSubview:dialogView];
            
        }else{
            [self showHUD:@"来晚了，已经被借啦"];
        }
    }else{
        [self showHUD:@"-_-# 想要求助？去登录吧"];
    }
}

- (void)showHUD:(NSString *)message{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = message;
    hud.mode = MBProgressHUDModeText;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud hide:YES];
    });
}

#pragma mark - 第一个按钮按下监听
- (void)draggableDialogView:(SFDraggableDialogView *)dialogView didPressFirstButton:(UIButton *)firstButton {
    
    //拨打电话
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://18888178763"]]];
    
    //移除dialogView
    [dialogView removeFromSuperview];
    
    //电话监听
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];
    
    //定为成员变量，以免执行玩被释放。
    self.call = callCenter;
    
    //防止block循环引用
    __weak HMSkillDetailController *VC = self;
    
    
    self.call.callEventHandler = ^(CTCall* call) {
        
        //电话结束后显示有没有同意借用
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"对方同意帮忙？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //如果同意，则进行下一步
                //存入我的订单界面
                HMOrderController *order = [HMOrderController shareHMOrderController];
                [order addOrder:VC.skill];
                
                //提示拍张界面
                UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                HMInfoController *info =[story instantiateViewControllerWithIdentifier:@"info"];
                
                //记录一下这个东西已借
                VC.skill.isBorrowed = YES;
                
                [VC presentViewController:info animated:YES completion:nil];
                
            }];
            
            [alert addAction:action];
            [alert addAction:action2];
            
            //放主线程才能不报错（把更新UI的操作放主线程）
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [VC presentViewController:alert animated:YES completion:nil];
            });
            
            
        }
        
    };
}
//设置电话
- (NSMutableAttributedString *)exampleAttributeString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"电话:18888178763"];
    
    return attributedString;
}

#pragma mark - Snapshot
- (UIImage *)jt_imageWithView:(UIView *)view {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, scale);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:true];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


//点击收藏
- (void)collectClick:(UIButton *)collect{
    
    HMLoginController *login = [HMLoginController shareLogin];
    
    //登录才能查看
    if ([login ifLoginOn]) {
        
        collect.selected = !collect.selected;
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        
        HMCollectController *collected = [HMCollectController shareCollectController];
        if (collect.selected) {
            
            hud.labelText = @"已收藏";
            [collected addCollectThing:self.skill];
            
        }else{
            hud.labelText = @"取消收藏";
            [collected deleteCollectThing:self.skill];
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    }else{
        [self showHUD:@"-_-# 想要借？去登录吧"];
    }
}


#pragma mark - 设置数据
- (void)setSkill:(HMSkill *)skill{
    
    _skill = skill;
    
    self.icon.image = skill.icon;
    self.username.text = skill.username;
    self.lastTime.text = skill.lastTime;
    self.skillName.text = skill.skillDes;
    self.skillDetail.text = skill.skillContent;
    
    NSString *price = [NSString stringWithFormat:@"需%@信用值",skill.price];
    self.price.text = price;
    
    //设置frame
    [self setframesWithModel:skill];
}

/**
 *  设置frame
 */
- (void)setframesWithModel:(HMSkill *)skill{
    
    CGFloat margin = 10;
    
    //头像
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.scrollView addSubview:self.icon];
    
    //username
    CGFloat usernameW = [NSString sizeWithString:skill.username maxSize:CGSizeMake(100, 30) font:usernameFont].width;
    CGFloat usernameH = [NSString sizeWithString:skill.username maxSize:CGSizeMake(100, 30) font:usernameFont].height;
    CGFloat usernameX = margin + iconW + 5;
    CGFloat usernameY = margin;
    self.username.frame = CGRectMake(usernameX, usernameY, usernameW, usernameH);
    [self.scrollView addSubview:self.username];
    
    //lasttime
    CGFloat lasttimeW = [NSString sizeWithString:skill.lastTime maxSize:CGSizeMake(100, 30) font:lastTimeFont].width;
    CGFloat lasttimeH = [NSString sizeWithString:skill.lastTime maxSize:CGSizeMake(100, 30) font:lastTimeFont].height;
    CGFloat lasttimeX = usernameX;
    CGFloat lasttimeY = CGRectGetMaxY(self.icon.frame) - lasttimeH - 5;
    self.lastTime.frame = CGRectMake(lasttimeX, lasttimeY, lasttimeW, lasttimeH);
    [self.scrollView addSubview:self.lastTime];
    
    //price
    NSString *price = [NSString stringWithFormat:@"需%@信用值",skill.price];
    CGFloat priceW = [NSString sizeWithString:price maxSize:CGSizeMake(200, 30) font:priceFont].width;
    CGFloat priceH = [NSString sizeWithString:price maxSize:CGSizeMake(200, 30) font:priceFont].height;
    CGFloat priceX = self.view.bounds.size.width - priceW;
    CGFloat priceY = margin;
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    [self.scrollView addSubview:self.price];
    
    //skillNameHead
    CGFloat skillNameHeadW = 100;
    CGFloat skillNameHeadH = [NSString sizeWithString:@"-技能名称-" maxSize:CGSizeMake(200, 20) font:HeadFont].height + 8;
    CGFloat skillNameHeadX = (self.view.bounds.size.width - skillNameHeadW) * 0.5;
    CGFloat skillNameHeadY = margin * 4 + CGRectGetMaxY(self.icon.frame);
    self.skillNameHead.frame = CGRectMake(skillNameHeadX, skillNameHeadY, skillNameHeadW, skillNameHeadH);
    [self.scrollView addSubview:self.skillNameHead];
    
    //skillName
    CGFloat skillNameW = [NSString sizeWithString:skill.skillDes maxSize:CGSizeMake(320, CGFLOAT_MAX) font:titleFont].width;
    CGFloat skillNameH = [NSString sizeWithString:skill.skillDes maxSize:CGSizeMake(320, CGFLOAT_MAX) font:titleFont].height;
    CGFloat skillNameX = (self.view.bounds.size.width - skillNameW) * 0.5;
    CGFloat skillNameY = CGRectGetMaxY(self.skillNameHead.frame) + 10;
    self.skillName.frame = CGRectMake(skillNameX, skillNameY, skillNameW, skillNameH);
    [self.scrollView addSubview:self.skillName];
    
    //skilldetailHead
    CGFloat skilldetailHeadW = 100;
    CGFloat skilldetailHeadH = [NSString sizeWithString:@"-技能描述-" maxSize:CGSizeMake(200, 20) font:HeadFont].height + 8;
    CGFloat skilldetailHeadX = (self.view.bounds.size.width - skilldetailHeadW) * 0.5;
    CGFloat skilldetailHeadY = margin * 2 + CGRectGetMaxY(self.skillName.frame);
    self.skillDetailHead.frame = CGRectMake(skilldetailHeadX, skilldetailHeadY, skilldetailHeadW, skilldetailHeadH);
    [self.scrollView addSubview:self.skillDetailHead];
    
    //skillDetail
    CGFloat skillDetailW = [NSString sizeWithString:skill.skillContent maxSize:CGSizeMake(250, CGFLOAT_MAX) font:titleFont].width;
    CGFloat skillDetailH = [NSString sizeWithString:skill.skillContent maxSize:CGSizeMake(250, CGFLOAT_MAX) font:titleFont].height;
    CGFloat skillDetailX = (self.view.bounds.size.width - skillDetailW) * 0.5;
    CGFloat skillDetailY = CGRectGetMaxY(self.skillDetailHead.frame) + 10;
    self.skillDetail.frame = CGRectMake(skillDetailX, skillDetailY, skillDetailW, skillDetailH);
    [self.scrollView addSubview:self.skillDetail];
    
    //底部菜单栏
    [self.view addSubview:self.bottomView];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加scrollView
    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    [self.view addSubview:self.scrollView];
}

@end
