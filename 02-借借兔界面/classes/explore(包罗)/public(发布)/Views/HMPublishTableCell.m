//
//  HMPublishTableCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMPublishTableCell.h"

@interface HMPublishTableCell ()

/**
 *  用户头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;

/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *username;

/**
 *  发布的消息
 */
@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
/**
 *  背景View
 */
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation HMPublishTableCell


- (void)awakeFromNib{
    
    //设置背景为空
    self.backgroundColor=[UIColor clearColor];
    
    /**
     *  设置阴影和边角
     */
//    self.backView.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.backView.layer.shadowOpacity = 0.2;
//    self.backView.layer.shadowRadius = 6;
//    self.backView.layer.cornerRadius = 4;
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = themeColor;
    self.selectedBackgroundView = view;
}


/**
 *  从nib加载cell
 */
+ (instancetype)publishCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMPublishTableCell" owner:nil options:nil] lastObject];
}

/**
 *  快捷返回一个cell
 */
+ (instancetype)publishCellWithTableview:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
    HMPublishTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMPublishTableCell publishCell];
    }
    
    
    return cell;
}

/**
 *  设置模型数据
 */
- (void)setPublish:(HMPublish *)publish{
    
    _publish = publish;
    
    _icon.image = [UIImage imageNamed:publish.icon];
    _username.text = publish.name;
    _detailTitle.text = publish.detail;
}

@end
