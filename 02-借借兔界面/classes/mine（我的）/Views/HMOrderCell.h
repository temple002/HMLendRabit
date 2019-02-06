//
//  HMOrderCell.h
//  02-借借兔界面
//
//  Created by Temple on 16/5/28.
//  Copyright © 2016年 Temple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HMOrderCellPhotoBlock)(UIAlertController *alert);
typedef void(^HMOrderCellCameraBlock)(UIImagePickerController *imagePicker);
typedef void(^HMOrderCellImageBlock)(UIImage *imageV);

@interface HMOrderCell : UITableViewCell

@property (nonatomic,strong) id data;

//从nib加载
+ (instancetype)orderCell;

/**
 *  快捷创建cell
 */
+ (instancetype)orderCellWithTableview:(UITableView *)tableView;


//提示拍照
@property (nonatomic,copy) HMOrderCellPhotoBlock block;

//拍摄
@property (nonatomic,copy) HMOrderCellCameraBlock cameraBlock;

//传照片到控制器
@property (nonatomic,copy) HMOrderCellImageBlock imageBlock;

@end
