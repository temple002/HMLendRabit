//
//  HMSearchCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/6/14.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMSearchCell.h"
#import "HMBaoluo.h"

@interface HMSearchCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIButton *location;

@end

@implementation HMSearchCell

- (void)awakeFromNib {

    
    self.backgroundColor = [UIColor clearColor];
}

+ (instancetype)searchCell{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"HMSearchCell" owner:nil options:nil] firstObject];
}

+ (instancetype)searchCellWithTableview:(UITableView *)tableView{
    
    static NSString *ID = @"searchCell";
    
    HMSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMSearchCell searchCell];
    }
    return cell;
}

- (void)setBaoluo:(HMBaoluo *)baoluo{
    _baoluo = baoluo;
    
    self.icon.image = baoluo.images[0];
    
    self.name.text = baoluo.title;
    
    [self.location setTitle:baoluo.location forState:UIControlStateNormal];
    
}


@end
