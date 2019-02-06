//
//  HMSkillCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/7.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMSkillCell.h"
#import "NSString+NSStringExtr.h"
@interface HMSkillCell ()

/**
 *  背景view
 */
@property (weak, nonatomic) IBOutlet UIView *backView;

/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *username;

/**
 *  价格
 */
@property (nonatomic,strong) UILabel *price;

/**
 *  发布时间
 */
@property (weak, nonatomic) IBOutlet UILabel *lastTime;

/**
 *  技能名称
 */
@property (weak, nonatomic) IBOutlet UILabel *skillDes;

/**
 *  技能内容
 */
@property (weak, nonatomic) IBOutlet UILabel *skillContent;

@end


@implementation HMSkillCell

//懒加载
- (UILabel *)price{
    
    if (_price == nil) {
        
        self.price = [[UILabel alloc] init];
        
        [self.price setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
        
        self.price.textAlignment = NSTextAlignmentRight;
        self.price.font = [UIFont systemFontOfSize:14];
        self.price.textColor = themeColor;
        
        [self.backView addSubview:_price];
    }
    return _price;
}

- (void)awakeFromNib {
    
    
    //设置背景为空
    self.backgroundColor=[UIColor clearColor];
    
//    self.backView.layer.cornerRadius = 4;
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = themeColor;
    self.selectedBackgroundView = view;
}

//从nib加载
+ (instancetype)skillCell{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HMSkillCell" owner:nil options:nil] lastObject];
    
}

/**
 *  快捷创建cell
 */
+ (instancetype)skillCellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"skillCell";
    
    HMSkillCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMSkillCell skillCell];
    }
    
    return cell;
}

/**
 *  设置模型
 */
- (void)setSkill:(HMSkill *)skill{
    _skill = skill;
    
    self.icon.image = skill.icon;
    self.username.text = skill.username;
    self.lastTime.text = skill.lastTime;
    self.price.text = [NSString stringWithFormat:@"需%@信用度",skill.price];
    self.skillDes.text = skill.skillDes;
    self.skillContent.text = skill.skillContent;
    
    //    //根据字的长度来设置label长度
    [self sizeOftextLength:skill];
}

/**
 *  根据字的长度来设置label长度
 */
- (void)sizeOftextLength:(HMSkill *)skill{
    
    NSString *price = [NSString stringWithFormat:@"需%@信用度",skill.price];
    
    //计算用户名frame
    CGSize priceSize= [NSString sizeWithString:price maxSize:CGSizeMake(300, 40) font:[UIFont systemFontOfSize:14]];
    
    CGFloat priceW = priceSize.width + 5;
    CGFloat priceH = 25;
    
    self.price.translatesAutoresizingMaskIntoConstraints=NO;
    
    //添加约束
    NSLayoutConstraint *priceWidth = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:priceW];
    
    NSLayoutConstraint *priceHight = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:priceH];
    
    NSLayoutConstraint *priceRight = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeRight multiplier:1.0 constant:1];
    
    NSLayoutConstraint *priceTop = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeTop multiplier:1.0 constant:8];
    
    [self.price addConstraint:priceWidth];
    [self.price addConstraint:priceHight];
    [self.backView addConstraint:priceRight];
    [self.backView addConstraint:priceTop];
    
    
}

@end
