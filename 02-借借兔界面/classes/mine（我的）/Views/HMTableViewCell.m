//
//  HMTableViewCell.m
//  25-彩票系统
//
//  Created by Temple on 16/3/7.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMTableViewCell.h"
#import "HMSwitchTableVIewItem.h"
#import "HMArrowTableViewItem.h"
#import "HMLabelItem.h"
#import "HMSaveTool.h"
@interface HMTableViewCell ()

@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *text;
@end

@implementation HMTableViewCell

- (void)awakeFromNib{
    self.selectionStyle = UITableViewCellSelectionStyleDefault;
}

//控件的使用需要懒加载
- (UISwitch *)switchView{
    if (_switchView == nil) {
        
        _switchView = [[UISwitch alloc] init];
        
        [_switchView addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _switchView;
}

- (void)valueChange:(UISwitch *)switchView{
    
    HMSwitchTableVIewItem *item = (HMSwitchTableVIewItem *)self.item;
    item.off = switchView.on;
    
}


- (UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_normal"]];
    }
    
    return _imgView;
}

- (UILabel *)text{
    if (_text == nil) {
        _text = [[UILabel alloc] init];
        _text.bounds = CGRectMake(0, 0, 100, 44);
        _text.textAlignment = NSTextAlignmentRight;
        _text.textColor = [UIColor orangeColor];
    }
    return _text;
}

//设置模型的时候要考虑右侧显示
- (void)setItem:(HMTableViewItem *)item{
    _item = item;
    
    if (item.icon) {
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    
    self.textLabel.text = item.title;
    self.detailTextLabel.text = item.detailTitle;
    self.textLabel.font = [UIFont systemFontOfSize:14];
    self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    
    if ([item isKindOfClass:[HMArrowTableViewItem class]]) {
        
        self.accessoryView = self.imgView;
//        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        
        UIView *view = [[UIView alloc] initWithFrame:self.bounds];
        view.backgroundColor = themeColor;
        self.selectedBackgroundView = view;
        
    }
    
}

//封装初始化方法
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
    HMTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    
    if (!cell) {
        cell = [[HMTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    
    return cell;
}




@end
