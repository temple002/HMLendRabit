//
//  HMBorrowedCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/30.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMBorrowedCell.h"
#import "HMBaoluo.h"
#import "HMSkill.h"
#import "NSString+NSStringExtr.h"
#import "HMImagePreview.h"


@interface HMBorrowedCell ()

//物品图片
@property (weak, nonatomic) IBOutlet UIImageView *icon;

//标题
@property (weak, nonatomic) IBOutlet UILabel *des;

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (strong, nonatomic) UIButton *certificate;
@property (strong, nonatomic) UIButton *giveBack;

//物主
@property (nonatomic,weak) IBOutlet UIButton *master;

//剩余时间
@property (nonatomic,weak) IBOutlet UILabel *lastTime;

//凭证
@property (nonatomic,strong) UIImage *certImage;


@end


@implementation HMBorrowedCell

//懒加载

- (UIButton *)certificate{
    
    if (_certificate == nil) {
        
        self.certificate = [[UIButton alloc] init];
        
        [self.certificate setTitleColor:themeColor forState:UIControlStateNormal];
        self.certificate.layer.cornerRadius = 2;
        self.certificate.layer.borderWidth = 1;
        self.certificate.layer.borderColor = themeColor.CGColor;
        self.certificate.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.certificate addTarget:self action:@selector(checkCertificate:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _certificate;
}

- (UIButton *)giveBack{
    
    if (_giveBack == nil) {
        
        self.giveBack = [[UIButton alloc] init];
        
        [self.giveBack setTitleColor:themeColor forState:UIControlStateNormal];
        self.giveBack.layer.cornerRadius = 2;
        self.giveBack.layer.borderWidth = 1;
        self.giveBack.layer.borderColor = themeColor.CGColor;
        self.giveBack.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [self.giveBack setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
        
        [self.giveBack addTarget:self action:@selector(giveBackClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giveBack;
}


- (UIImage *)certImage{
    
    if (_certImage == nil) {
        
        self.certImage = [[UIImage alloc] init];
    }
    return _certImage;
}

- (void)awakeFromNib {
    
    //设置背景为空
    self.backgroundColor=[UIColor clearColor];
    
    self.buttonName = @"物归原主";
    self.alertMessage = @"对方已收到消息，请您尽快将物品归还物主，有借有还再借不难";
    self.skillFinishMessage = @"希望您也能多多帮助别人，互帮互助";
    self.user = @"物主";
}

//从nib加载
+ (instancetype)borrowedCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMBorrowedCell" owner:nil options:nil] lastObject];
}


/**
 *  快捷创建cell
 */
+ (instancetype)borrowedCellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"borrowedCell";
    
    HMBorrowedCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMBorrowedCell borrowedCell];
    }
    
    return cell;
}

//设置数据
- (void)setData:(id)data{
    
    _data = data;

    
    if ([data isKindOfClass:[HMBaoluo class]]) {
        HMBaoluo *baoluo = (HMBaoluo *)data;
        
        self.icon.image = baoluo.images[0];
        self.des.text = baoluo.title;
        self.certImage = baoluo.certificate;
        
        [self.master setTitle:[NSString stringWithFormat:@"%@:%@",self.user,baoluo.username] forState:UIControlStateNormal];
        self.lastTime.hidden = NO;
        self.certificate.hidden = NO;
        [self.certificate setTitle:@"查看凭证" forState:UIControlStateNormal];
        [self.giveBack setTitle:self.buttonName forState:UIControlStateNormal];
        
        
    }else{
        HMSkill *skill = (HMSkill *)data;
        
        self.icon.image = [UIImage imageNamed:@"skill"];
        self.des.text = skill.skillDes;
        [self.master setTitle:[NSString stringWithFormat:@"%@:%@",self.user,skill.username] forState:UIControlStateNormal];
        self.lastTime.hidden = YES;
        self.certificate.hidden = YES;
        [self.giveBack setTitle:@"完成" forState:UIControlStateNormal];
    }
    
    [self setFrameWithModel:data];
}

//设置frame
- (void)setFrameWithModel:(id)data{
    
    //certificate
    CGFloat certificateW = 75;
    CGFloat certificateH = 26;
    CGFloat certificateX = 132;
    CGFloat certificateY = 98;
    self.certificate.frame = CGRectMake(certificateX, certificateY, certificateW, certificateH);
    [self.backView addSubview:self.certificate];
    
    //giveBack
    CGFloat backW = 75;
    CGFloat backH = 26;
    CGFloat backX = 215;
    CGFloat backY = 98;
    self.giveBack.frame = CGRectMake(backX, backY, backW, backH);
    [self.backView addSubview:self.giveBack];
}
//点击查看凭证
- (void)checkCertificate:(id)sender {
    
    HMImagePreview *preview = [[HMImagePreview alloc] init];
    
    preview.view.backgroundColor = [UIColor whiteColor];
    
    [preview previewImage:self.certImage];
    
    if (self.previewBlock) {
        self.previewBlock(preview);
    }
}

//点击物归原主
- (void)giveBackClick:(UIButton *)sender {
    
    self.giveBack.selected = YES;
    self.giveBack.layer.borderColor = [UIColor grayColor].CGColor;
    
    NSString *message = nil;
    if ([sender.currentTitle isEqualToString:@"完成"]) {
        message = self.skillFinishMessage;
    }else{
        message = self.alertMessage;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    if (self.block) {
        self.block(alert);
    }
}


@end
