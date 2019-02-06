//
//  HMBaoluoCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/22.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "HMBaoluoCell.h"
#import "NSString+NSStringExtr.h"


@interface HMBaoluoCell ()
/**
 *  头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon;
/**
 *  用户名
 */
@property (weak, nonatomic) IBOutlet UILabel *username;
/**
 *  发布时间
 */
@property (weak, nonatomic) IBOutlet UILabel *lastTime;
/**
 *  价格
 */
@property (nonatomic,strong) UILabel *price;
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIScrollView *imagescroll;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title;

/**
 *  背景View
 */
@property (weak, nonatomic) IBOutlet UIView *backview;



/**
 *  图片集合
 */
@property (nonatomic,strong) NSArray *images;

/**
 *  偏移量
 */
@property (nonatomic,assign) CGFloat offset;

@end

@implementation HMBaoluoCell

//懒加载
- (UILabel *)price{
    
    if (_price == nil) {
        
        self.price = [[UILabel alloc] init];
        
        [self.price setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
        
        self.price.font = [UIFont systemFontOfSize:14];
        self.price.textColor = themeColor;
    }
    return _price;
}


- (void)awakeFromNib{
    
    [super awakeFromNib];
    //设置偏移量初始值(图片)
    self.offset = 3.0;
    
    //设置背景为空
    self.backgroundColor=[UIColor clearColor];
    
    /**
     *  设置阴影和边角
     */
//    self.backview.layer.shadowColor = [UIColor grayColor].CGColor;
//    self.backview.layer.shadowOpacity = 0.2;
//    self.backview.layer.shadowRadius = 10;
//    self.backview.layer.cornerRadius = 4;
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = themeColor;
    self.selectedBackgroundView = view;
    
}


//从nib加载
+ (instancetype)baoluoCell{
    
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HMBaoluoCell" owner:nil options:nil] lastObject];
    
}

/**
 *  快捷创建cell
 */
+ (instancetype)baoluoCellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"baluoCell";
    
    HMBaoluoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMBaoluoCell baoluoCell];
    }
    
    
    return cell;
}

/**
 *  设置模型
 */
- (void)setBaoluo:(HMBaoluo *)baoluo{
    
    _baoluo = baoluo;
    
    self.icon.image = baoluo.icon;
    self.username.text = baoluo.username;
    self.lastTime.text = baoluo.lastTime;
    self.price.text = [NSString stringWithFormat:@"需%@信用度",baoluo.price];
    self.images = baoluo.images;
    self.title.text = baoluo.title;
    
    //重新排列scrollView
    [self layoutScrollView:baoluo.images];
    
//    //根据字的长度来设置label长度
    [self sizeOftextLength:baoluo];
    
}

/**
 *  根据字的长度来设置label长度
 */
- (void)sizeOftextLength:(HMBaoluo *)baoluo{
    
    NSString *price = [NSString stringWithFormat:@"需%@信用度",baoluo.price];
    
    //计算用户名frame
    CGSize priceSize= [NSString sizeWithString:price maxSize:CGSizeMake(300, 40) font:[UIFont systemFontOfSize:14]];
    
    CGFloat priceW = priceSize.width + 5;
    CGFloat priceH = 25;
    
    self.price.textAlignment = NSTextAlignmentRight;
    [self.backview addSubview:_price];
    
    self.price.translatesAutoresizingMaskIntoConstraints=NO;
    
    //添加约束
    NSLayoutConstraint *priceWidth = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:priceW];
    
    NSLayoutConstraint *priceHight = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:priceH];
    
    NSLayoutConstraint *priceRight = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backview attribute:NSLayoutAttributeRight multiplier:1.0 constant:1];
    
    NSLayoutConstraint *priceTop = [NSLayoutConstraint constraintWithItem:self.price attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backview attribute:NSLayoutAttributeTop multiplier:1.0 constant:8];
    
    [self.price addConstraint:priceWidth];
    [self.price addConstraint:priceHight];
    [self.backview addConstraint:priceRight];
    [self.backview addConstraint:priceTop];
}

/**
 *  重新排列scrollview
 *
 */
- (void)layoutScrollView:(NSArray *)images{
    
    for (int i = 0; i < images.count; i ++) {
        
        //提取图片
        UIImage *image = images[i];
        //创建imageView
        UIImageView *imageView=[[UIImageView alloc] initWithImage:image];
        
        //拉伸方式
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        //图像裁剪
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = 1;
        
        //设置frame
        imageView.frame = CGRectMake(self.offset, 0, 160, 160);
        //设置偏移量
        self.offset += imageView.frame.size.width + 3;
        
        //添加imageView
        [self.imagescroll addSubview:imageView];
        
        
    }
    
    //滚动的实际大小
    self.imagescroll.contentSize=CGSizeMake(self.offset, 0);
    
    //取消滚动指示器
    self.imagescroll.showsHorizontalScrollIndicator = NO;
    self.imagescroll.showsVerticalScrollIndicator = NO;
}



@end
