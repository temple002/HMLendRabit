//
//  HMThingDetailController.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/8.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMThingDetailController.h"
#import "HMBaoluo.h"
#import "NSString+NSStringExtr.h"
#import "MBProgressHUD.h"
#import "SFDraggableDialogView.h"
#import "HMBorrowedController.h"
#import "HMLoginController.h"
#import "MBProgressHUD.h"
#import "HMCollectController.h"
#import <CoreTelephony/CTCallCenter.h>
#import <CoreTelephony/CTCall.h>
#import "HMInfoController.h"
#import "HMOrderController.h"

@interface HMThingDetailController ()<SFDraggableDialogViewDelegate>

//控件都放到一个scrollview上面
@property (nonatomic,strong) UIScrollView *scrollView;

@property (nonatomic,strong) UIImageView *icon;

@property (nonatomic,strong) UILabel *username;

@property (nonatomic,strong) UILabel *lastTime;

@property (nonatomic,strong) UILabel *price;

@property (nonatomic,strong) NSArray *images;

//标题引导字
@property (nonatomic,strong) UILabel *titleHead;

@property (nonatomic,strong) UILabel *BaoluoTitle;

//正文引导字
@property (nonatomic,strong) UILabel *detailHead;

//正文
@property (nonatomic,strong) UILabel *detail;

//损坏时须赔偿的金额
@property (nonatomic,strong) UILabel *brokenPrice;

//底部菜单栏
@property (nonatomic,strong) UIView *bottomView;

//打电话
@property (nonatomic,strong) UIWebView *webView;

@property (nonatomic,strong) CTCallCenter *call;

@end
@implementation HMThingDetailController

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

- (NSArray *)images{
    
    if (_images == nil) {
        
        self.images = [NSArray array];
    }
    return _images;
}

- (UILabel *)titleHead{
    
    if (_titleHead == nil) {
        
        self.titleHead = [[UILabel alloc] init];
        self.titleHead.textColor = [UIColor whiteColor];
        self.titleHead.font = HeadFont;
        self.titleHead.text = @"物品名称";
        self.titleHead.textAlignment = NSTextAlignmentCenter;
        [self.titleHead setBackgroundColor:themeColor];
    }
    return _titleHead;
}

- (UILabel *)BaoluoTitle{
    
    if (_BaoluoTitle == nil) {
        
        self.BaoluoTitle = [[UILabel alloc] init];
        self.BaoluoTitle.font = titleFont;
    }
    return _BaoluoTitle;
}

- (UILabel *)detailHead{
    
    if (_detailHead == nil) {
        
        self.detailHead = [[UILabel alloc] init];
        self.detailHead.textColor = [UIColor whiteColor];
        self.detailHead.font = HeadFont;
        self.detailHead.text = @"详细描述";
        self.detailHead.textAlignment = NSTextAlignmentCenter;
        [self.detailHead setBackgroundColor:themeColor];
    }
    return _detailHead;
}

- (UILabel *)detail{
    
    if (_detail == nil) {
        
        self.detail = [[UILabel alloc] init];
        self.detail.font = titleFont;
        self.detail.numberOfLines = 0;
    }
    return _detail;
}

//赔偿
- (UILabel *)brokenPrice{
    
    if (_brokenPrice == nil) {
        
        self.brokenPrice = [[UILabel alloc] init];
        self.brokenPrice.font = brokenFont;
        [self.brokenPrice setTextColor:[UIColor colorWithRed:170.0/255.0 green:170.0/255.0 blue:170.0/255.0 alpha:1.0]];
        self.brokenPrice.numberOfLines = 0;
    }
    return _brokenPrice;
}

- (UIWebView *)webView{
    
    if (_webView == nil) {
        
        _webView = [[UIWebView alloc]initWithFrame:CGRectZero];
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
        [borrow setTitle:@"我想借" forState:UIControlStateNormal];
        borrow.titleLabel.font = [UIFont systemFontOfSize:15];
        [borrow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [borrow setBackgroundColor:themeColor];
        //添加监听
        [borrow addTarget:self action:@selector(IWantBorrow:) forControlEvents:UIControlEventTouchUpInside];
        
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
        if (!self.baoluo.isBorrowed) {
            SFDraggableDialogView *dialogView = [[[NSBundle mainBundle] loadNibNamed:@"SFDraggableDialogView" owner:self options:nil] firstObject];
            dialogView.frame = self.view.bounds;
            dialogView.photo = [UIImage imageNamed:@"big_icon"];
            dialogView.delegate = self;
            dialogView.titleText = [[NSMutableAttributedString alloc] initWithString:@"杨威"];
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
        
        [self showHUD:@"-_-# 想要借？去登录吧"];
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
    
//    //放到我借到的界面里
//    HMBorrowedController *borrowed = [HMBorrowedController shareBorrowedController];
//    [borrowed addBorrowedThing:self.baoluo];

    //拨打电话
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://18888179021"]]];
    
    //移除dialogView
    [dialogView removeFromSuperview];
    
    //电话监听
    CTCallCenter *callCenter = [[CTCallCenter alloc] init];

    //定为成员变量，以免执行玩被释放。
    self.call = callCenter;
    
    //防止block循环引用
    __weak HMThingDetailController *VC = self;
    
    
    self.call.callEventHandler = ^(CTCall* call) {
        
        //电话结束后显示有没有同意借用
        if ([call.callState isEqualToString:CTCallStateDisconnected])
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"对方同意借用？" message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"不同意" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"同意" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                //如果同意，则进行下一步
                //存入我的订单界面
                HMOrderController *order = [HMOrderController shareHMOrderController];
                [order addOrder:VC.baoluo];
                
                //提示拍张界面
                UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                HMInfoController *info =[story instantiateViewControllerWithIdentifier:@"info"];
                
                //记录一下这个东西已借
                VC.baoluo.isBorrowed = YES;
                
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
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"电话:18888179021"];
    
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
            [collected addCollectThing:self.baoluo];
            
        }else{
            hud.labelText = @"取消收藏";
            [collected deleteCollectThing:self.baoluo];
            
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [hud hide:YES];
        });
    }else{
        [self showHUD:@"-_-# 想要借？去登录吧"];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加scrollView
    self.scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 44);
    [self.view addSubview:self.scrollView];
}


#pragma mark - 设置数据
- (void)setBaoluo:(HMBaoluo *)baoluo{
    
    _baoluo = baoluo;
    
    self.icon.image = baoluo.icon;
    self.username.text = baoluo.username;
    self.lastTime.text = baoluo.lastTime;
    self.BaoluoTitle.text = baoluo.title;
    self.images = baoluo.images;
    self.detail.text = baoluo.detail;
    
    NSString *broken = [NSString stringWithFormat:@"*此物品如遭损坏,须赔偿物主￥%@,请妥善借用。",baoluo.brokenPrice];
    self.brokenPrice.text = broken;
    
    NSString *price = [NSString stringWithFormat:@"需%@信用值",baoluo.price];
    self.price.text = price;
    
    //设置frame
    [self setframesWithModel:baoluo];
}

/**
 *  设置frame
 */
- (void)setframesWithModel:(HMBaoluo *)baoluo{
    
    CGFloat margin = 10;
    
    //头像
    CGFloat iconW = 40;
    CGFloat iconH = 40;
    CGFloat iconX = margin;
    CGFloat iconY = margin;
    self.icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [self.scrollView addSubview:self.icon];
    
    //username
    CGFloat usernameW = [NSString sizeWithString:baoluo.username maxSize:CGSizeMake(100, 30) font:usernameFont].width;
    CGFloat usernameH = [NSString sizeWithString:baoluo.username maxSize:CGSizeMake(100, 30) font:usernameFont].height;
    CGFloat usernameX = margin + iconW + 5;
    CGFloat usernameY = margin;
    self.username.frame = CGRectMake(usernameX, usernameY, usernameW, usernameH);
    [self.scrollView addSubview:self.username];
    
    //lasttime
    CGFloat lasttimeW = [NSString sizeWithString:baoluo.lastTime maxSize:CGSizeMake(100, 30) font:lastTimeFont].width;
    CGFloat lasttimeH = [NSString sizeWithString:baoluo.lastTime maxSize:CGSizeMake(100, 30) font:lastTimeFont].height;
    CGFloat lasttimeX = usernameX;
    CGFloat lasttimeY = CGRectGetMaxY(self.icon.frame) - lasttimeH - 5;
    self.lastTime.frame = CGRectMake(lasttimeX, lasttimeY, lasttimeW, lasttimeH);
    [self.scrollView addSubview:self.lastTime];
    
    //price
    NSString *price = [NSString stringWithFormat:@"需%@信用值",baoluo.price];
    CGFloat priceW = [NSString sizeWithString:price maxSize:CGSizeMake(200, 30) font:priceFont].width + 5;
    CGFloat priceH = [NSString sizeWithString:price maxSize:CGSizeMake(200, 30) font:priceFont].height + 5;
    CGFloat priceX = self.view.bounds.size.width - priceW;
    CGFloat priceY = margin;
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    [self.scrollView addSubview:self.price];
    
    //标题引导字
    CGFloat titleHeadW = [NSString sizeWithString:@" 物品名称 " maxSize:CGSizeMake(200, 20) font:HeadFont].width;
    CGFloat titleHeadH = [NSString sizeWithString:@" 物品名称 " maxSize:CGSizeMake(200, 20) font:HeadFont].height;
    CGFloat titleHeadX = iconX + 5;
    CGFloat titleHeadY = margin + CGRectGetMaxY(self.icon.frame);
    self.titleHead.frame = CGRectMake(titleHeadX, titleHeadY, titleHeadW, titleHeadH);
    [self.scrollView addSubview:self.titleHead];
    
    //标题
    CGFloat titleW = [NSString sizeWithString:baoluo.title maxSize:CGSizeMake(320, CGFLOAT_MAX) font:titleFont].width;
    CGFloat titleH = [NSString sizeWithString:baoluo.title maxSize:CGSizeMake(320, CGFLOAT_MAX) font:titleFont].height;
    CGFloat titleX = titleHeadX;
    CGFloat titleY = CGRectGetMaxY(self.titleHead.frame) + margin * 0.5 + 5;;
    self.BaoluoTitle.frame = CGRectMake(titleX, titleY, titleW, titleH);
    [self.scrollView addSubview:self.BaoluoTitle];
    
    //详细引导字
    CGFloat detailHeadW = [NSString sizeWithString:@" 详细描述 " maxSize:CGSizeMake(200, 20) font:HeadFont].width;
    CGFloat detailHeadH = [NSString sizeWithString:@" 详细描述 " maxSize:CGSizeMake(200, 20) font:HeadFont].height;
    CGFloat detailHeadX = titleHeadX;
    CGFloat detailHeadY = margin + CGRectGetMaxY(self.BaoluoTitle.frame) + 5;
    self.detailHead.frame = CGRectMake(detailHeadX, detailHeadY, detailHeadW, detailHeadH);
    [self.scrollView addSubview:self.detailHead];
    
    //详细描述
    CGFloat detailW = [NSString sizeWithString:baoluo.detail maxSize:CGSizeMake(300, CGFLOAT_MAX) font:titleFont].width;
    CGFloat detailH = [NSString sizeWithString:baoluo.detail maxSize:CGSizeMake(300, CGFLOAT_MAX) font:titleFont].height;
    CGFloat detailX = titleHeadX;
    CGFloat detailY = CGRectGetMaxY(self.detailHead.frame) + margin * 0.5 + 5;
    self.detail.frame = CGRectMake(detailX, detailY, detailW, detailH);
    [self.scrollView addSubview:self.detail];
    
    //图片
    CGFloat imageW = 290.0;
    CGFloat imageH = 310.0;
    CGFloat imageX = (self.view.bounds.size.width - imageW) * 0.5;
    CGFloat imageY = CGRectGetMaxY(self.detail.frame);
    CGFloat offsetY = imageY + 5;
    
    //有图则发布
    if (baoluo.images) {
        for (int i = 0; i < baoluo.images.count; i ++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            
            imageView.image = baoluo.images[i];
            
            //拉伸方式
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            //图像裁剪
            imageView.layer.masksToBounds = YES;
            
            imageView.frame = CGRectMake(imageX, margin + offsetY, imageW, imageH);
            
            offsetY = offsetY + imageH + margin;
            
            [self.scrollView addSubview:imageView];
        }
    }
    //损坏提示
    CGFloat brokenW = [NSString sizeWithString:self.brokenPrice.text maxSize:CGSizeMake(self.view.bounds.size.width, MAXFLOAT) font:brokenFont].width;
    CGFloat brokenH = [NSString sizeWithString:self.brokenPrice.text maxSize:CGSizeMake(self.view.bounds.size.width, MAXFLOAT) font:brokenFont].height;
    CGFloat brokenX = imageX;
    CGFloat brokenY = offsetY + 10;
    self.brokenPrice.frame = CGRectMake(brokenX, brokenY, brokenW, brokenH);
    [self.scrollView addSubview:self.brokenPrice];
    
    self.scrollView.contentSize = CGSizeMake(320, offsetY + 10 + brokenH);
    
    //底部菜单栏
    [self.view addSubview:self.bottomView];
    
}

@end
