//
//  MenuScroll.m
//  02-借借兔界面
//
//  Created by Temple on 16/5/4.
//  Copyright (c) 2016年 Temple. All rights reserved.
//

#import "MenuScroll.h"
#import "NSString+NSStringExtr.h"
@interface MenuScroll ()

@property (nonatomic,strong) UIView *bottomLine;

@property (nonatomic,strong) NSMutableArray *menus;

/**
 *  按钮应该放的x方向值
 */
@property (nonatomic,assign) CGFloat offset;

@end

@implementation MenuScroll

/**
 *  懒加载
 */
- (UIView *)bottomLine{
    
    if (_bottomLine == nil) {
        
        self.bottomLine = [[UIView alloc] init];
        
        [self.bottomLine setBackgroundColor:themeColor];
        
    }
    return _bottomLine;
}

- (NSMutableArray *)menus{
    
    if (_menus == nil) {
        
        self.menus = [[NSMutableArray alloc] init];
    }
    return _menus;
}

//提供快速创建的方法
+ (instancetype)menuScroll{
    
    MenuScroll *menu = [[MenuScroll alloc] init];
    
    [menu setBackgroundColor:[UIColor whiteColor]];
    
    
    
    return menu;
}

//添加按钮
- (void)addMenus:(NSArray *)menus{
    
    //循环添加按钮
    for (int i = 0; i < menus.count; i ++) {
        
        NSString *menuText = (NSString *)menus[i];
        
        //获取按钮的宽
        CGFloat BtnWidth = [NSString sizeWithString:menuText maxSize:CGSizeMake(MAXFLOAT, 30) font:[UIFont systemFontOfSize:14]].width;
        
        UIButton *menu = [[UIButton alloc] init];
        
        menu.frame = CGRectMake(self.offset, 0, BtnWidth + 22, 40);
        
        //设置offset值
        self.offset += BtnWidth + 22;
        
        [menu setTitle:menuText forState:UIControlStateNormal];
        
        menu.titleLabel.font = [UIFont systemFontOfSize:14];
        
        [menu setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [menu setTitleColor:themeColor forState:UIControlStateSelected];
        
        [menu addTarget:self action:@selector(menuClick:) forControlEvents:UIControlEventTouchUpInside];
        
        menu.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.menus addObject:menu];
        
        [self addSubview:menu];
        
    }
    
    //默认选中第一个
    UIButton *firstMenu = [self.subviews firstObject];
    firstMenu.selected = YES;
    [self addLine:firstMenu];
    
    self.userInteractionEnabled=YES;
    
    //让添加按钮的scroll可以滑动
    self.panGestureRecognizer.delaysTouchesBegan = YES;
    
    //取消滚动指示器
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    
    self.contentSize = CGSizeMake(self.offset, 0);
}

//删除按钮
- (void)deleteMenus{
    
    UIButton *menu = nil;
    
    for (int i = 0; i < self.menus.count; i ++) {
        
        menu = self.menus[i];
        [menu removeFromSuperview];
    }
    
    [self.bottomLine removeFromSuperview];
    
    self.offset = 0.0;
    
    [self.menus removeAllObjects];
    
}

- (void)menuClick:(UIButton *)menu{
    
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *button = self.subviews[i];
        
        button.selected = NO;
        [self.bottomLine removeFromSuperview];
    }
    menu.selected = !menu.selected;
    
    //添加线
    [self addLine:menu];
}

//添加线
- (void)addLine:(UIButton *)menu{
    
    CGFloat lineW = menu.frame.size.width;
    CGFloat lineH = 2;
    CGFloat lineX = menu.frame.origin.x;
    CGFloat lineY = 36;
    
    //加点动画
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.frame = CGRectMake(lineX, lineY, lineW, lineH);
    }];
    
    [self addSubview:self.bottomLine];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
