//
//  HMOrderCell.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/28.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import "HMOrderCell.h"
#import "HMBaoluo.h"
#import "HMSkill.h"
#import "NSString+NSStringExtr.h"
#import "HMBorrowedController.h"


@interface HMOrderCell ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

//背景
@property (weak, nonatomic) IBOutlet UIView *backView;

//物品图片
@property (weak, nonatomic) IBOutlet UIImageView *icon;

//标题
@property (weak, nonatomic) IBOutlet UILabel *des;

//信用值
@property (nonatomic,strong) UILabel *price;

//确认收货
@property (weak, nonatomic) IBOutlet UIButton *receipt;

//展示图片的View
@property (nonatomic,strong) UIImageView *imageV;

//打开照相机
@property (nonatomic,strong) UIImagePickerController *picker;

@end

@implementation HMOrderCell

- (void)awakeFromNib {
    //设置背景为空
    self.backgroundColor=[UIColor clearColor];
    
    [self.receipt setTitleColor:themeColor forState:UIControlStateNormal];
    [self.receipt setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [self.receipt setTitle:@"已收货" forState:UIControlStateSelected];
    self.receipt.layer.cornerRadius = 2;
    self.receipt.layer.borderWidth = 1;
    self.receipt.layer.borderColor = themeColor.CGColor;
    
}

//懒加载
- (UILabel *)price{
    
    if (_price == nil) {
        
        self.price = [[UILabel alloc] init];
        
        self.price.font = [UIFont systemFontOfSize:15];
        
        self.price.textColor = [UIColor grayColor];
    }
    return _price;
}

- (UIImageView *)imageV{
    
    if (_imageV == nil) {
        
        self.imageV = [[UIImageView alloc] init];
        
    }
    return _imageV;
}

- (UIImagePickerController *)picker{
    
    if (_picker == nil) {
        
        self.picker = [[UIImagePickerController alloc] init];
    }
    return _picker;
}

//收货点击
- (IBAction)reciptClick:(UIButton *)sender {
    
    //提示去拍照作为凭证
    if ([self.data isKindOfClass:[HMBaoluo class]] && !self.receipt.selected) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"建议拍照作为借物的依据" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *OK = [UIAlertAction actionWithTitle:@"去拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //拍照
            self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            self.picker.delegate = self;
            
            if (self.cameraBlock) {
                self.cameraBlock(self.picker);
            }
        }];
        
        [alert addAction:cancel];
        [alert addAction:OK];
        
        if (self.block) {
            self.block(alert);
        }
    }
    
    if ([self.data isKindOfClass:[HMSkill class]]) {
        //加到已借到的界面
        HMBorrowedController *borrowed = [HMBorrowedController shareBorrowedController];
        
        [borrowed addBorrowedThing:self.data];
    }
    
    self.receipt.selected = YES;
    self.receipt.layer.borderColor = [UIColor grayColor].CGColor;

}

#pragma mark - 拍完照执行的代码
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //加到已借到的界面
    HMBorrowedController *borrowed = [HMBorrowedController shareBorrowedController];
    HMBaoluo *baoluo = (HMBaoluo *)self.data;
    baoluo.certificate = image;
    [borrowed addBorrowedThing:baoluo];
    
    if (self.imageBlock) {
        self.imageBlock(image);
    }
}


//从nib加载
+ (instancetype)orderCell{
    return [[[NSBundle mainBundle] loadNibNamed:@"HMOrderCell" owner:nil options:nil] lastObject];
}

/**
 *  快捷创建cell
 */
+ (instancetype)orderCellWithTableview:(UITableView *)tableView{
    static NSString *ID = @"orderCell";
    
    HMOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [HMOrderCell orderCell];
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
        self.price.text = [NSString stringWithFormat:@"需要花费%@信用值",baoluo.price];
        
    }else{
        HMSkill *skill = (HMSkill *)data;
        
        self.icon.image = [UIImage imageNamed:@"skill"];
        self.des.text = skill.skillDes;
        self.price.text = [NSString stringWithFormat:@"需要花费%@信用值",skill.price];
    }
    
    //设置price坐标
    [self sizeOftextLength:self.price.text];
}

/**
 *  根据字的长度来设置label长度
 */
- (void)sizeOftextLength:(NSString *)title{
    
    NSString *price = title;
    
    //计算用户名frame
    CGSize priceSize= [NSString sizeWithString:price maxSize:CGSizeMake(190, 40) font:[UIFont systemFontOfSize:15]];
    
    CGFloat priceW = priceSize.width;
    CGFloat priceH = priceSize.height;
    CGFloat priceX = self.des.frame.origin.x;
    CGFloat priceY = 58;
    
    self.price.frame = CGRectMake(priceX, priceY, priceW, priceH);
    
    [self.backView addSubview:self.price];
}



@end
