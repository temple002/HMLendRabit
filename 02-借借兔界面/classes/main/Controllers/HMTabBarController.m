//
//  HMTabBarController.m
//  02-借借兔界面
//
//  Created by Temple on 16/4/19.
//  Copyright (c) 2016年 Temple. All rights reserved.
//
#import "HMTabBarController.h"
#import "HMTabBar.h"
#import "HMAddPublishController.h"
#import "HMLoginOnController.h"
#import "HMPublishController.h"
#import "HMAddPublishNavController.h"
#import "HMAddSkillNavController.h"
#import "HYBBaseTransition.h"
#import "HYBBubbleTransition.h"
#import "HYBEaseInOutTransition.h"
#import "HMLoginController.h"

@interface HMTabBarController ()

@property (nonatomic, strong) HYBBubbleTransition *bubbleTransition;
/**
 *  添加蒙版
 */
@property (nonatomic,strong) UIView *blackView;

/**
 *  添加快速发布按钮
 */
@property (nonatomic,strong) UIButton *fastPublish;

/**
 *  选择人物按钮
 */
@property (nonatomic,strong) UIButton *selectPeople;

/**
 *  选择物品按钮
 */
@property (nonatomic,strong) UIButton *selectThing;

@property (nonatomic,assign) BOOL isPublish;

@property (nonatomic,strong) HMTabBar *tabbar;

@property (nonatomic,assign) CGFloat fastPublishWitdh;

//淡入淡出
@property (nonatomic, strong) HYBEaseInOutTransition *transition;
@end

@implementation HMTabBarController

/**
 *  懒加载
 */
- (UIView *)blackView{
    
    if (_blackView == nil) {
        
        self.blackView = [[UIView alloc] init];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.blackView.alpha = 0.0;
        
    }
    return _blackView;
}

- (UIButton *)fastPublish{
    
    if (_fastPublish == nil) {
        
        self.fastPublish = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.fastPublish setImage:[UIImage imageNamed:@"1"] forState:UIControlStateNormal];
    }
    return _fastPublish;
}

- (UIButton *)selectPeople{
    
    if (_selectPeople == nil) {
        
        _selectPeople = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectPeople.tag = 1;
        
        [self.selectPeople setBackgroundColor:[UIColor whiteColor]];
        [self.selectPeople setTitle:@"物品" forState:UIControlStateNormal];
        [self.selectPeople setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectPeople.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        self.selectPeople.alpha = 0.0;
        self.selectPeople.layer.cornerRadius = 30;
        
        //添加监听
        [self.selectPeople addTarget:self action:@selector(jump2publish:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _selectPeople;
}

- (UIButton *)selectThing{
    
    if (_selectThing == nil) {
        
        _selectThing = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectThing.tag = 2;
        
        [self.selectThing setBackgroundColor:[UIColor whiteColor]];
        [self.selectThing setTitle:@"技能" forState:UIControlStateNormal];
        self.selectThing.titleLabel.font = [UIFont systemFontOfSize: 13.0];
        [self.selectThing setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.selectThing.alpha = 0.0;
        self.selectThing.layer.cornerRadius = 30;
        
        //添加监听
        [self.selectThing addTarget:self action:@selector(jump2publish:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectThing;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //尺寸
    UIImage *image = [UIImage imageNamed:@"1"];
    self.fastPublishWitdh = image.size.width;
    
    //初始化ispublish
    self.isPublish = NO;
    
    HMTabBar *tab = [HMTabBar tabbar];
    self.tabbar = tab;
    
    
    CGRect tabBounds = CGRectMake(0, 0, self.tabBar.bounds.size.width, 49);
    tab.frame = tabBounds;
    
    //执行block
    tab.block = ^(int selectIndex){
        self.selectedIndex = selectIndex;
    };
    
    //跳到登录界面
    tab.jump2LoginBlock = ^(){
        
        [self onPresent];
    };
    
    //隐藏边框
    [[UITabBar appearance] setShadowImage:[[UIImage alloc]init]];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    //设置菜单栏大小
    self.tabBar.bounds = tabBounds;
    
    
//    self.fastPublish.frame = CGRectMake(126, -27, self.fastPublishWitdh, self.fastPublishWitdh);
    
    //添加发布按钮
    [self.tabbar addSubview:self.fastPublish];
    //添加约束
    self.fastPublish.translatesAutoresizingMaskIntoConstraints=NO;
    
    NSLayoutConstraint *FastWidth = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
    [self.fastPublish addConstraint:FastWidth];
    
    NSLayoutConstraint *FastHeight = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
    [self.fastPublish addConstraint:FastHeight];
    
    NSLayoutConstraint *FastTop = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeTop multiplier:1.0 constant:-27];
    [self.tabbar addConstraint:FastTop];
    
    NSLayoutConstraint *fastMiddle = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-1.0];
    [self.tabbar addConstraint:fastMiddle];
    
    
    
    //发布按钮点击事件
    [self.fastPublish addTarget:self action:@selector(createBlackView) forControlEvents:UIControlEventTouchUpInside];
    
    //添加子控件
    [self.tabBar addSubview:tab];
    
    
}

//弹出登录界面
- (void)onPresent {
    UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HMLoginOnController* loginOn =[story instantiateViewControllerWithIdentifier:@"loginon"];
    
    loginOn.modalPresentationStyle = UIModalPresentationCustom;
    
    
    HMTabBar *tabbar = [HMTabBar shareTabBar];
    loginOn.dismissBlock = ^(){
    
        self.selectedIndex = 3;
        
        //为了避免which is already presenting 的错误
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [tabbar mineClick:nil];
        });
        
        
        HMLoginController *login = [HMLoginController shareLogin];
        
        login.loginOutBlock = ^(){
            self.selectedIndex = 0;
            
            [tabbar homeClick:nil];
        };
        
        [login setLogin:YES];
    };
    
    // Remember to own it strongly
    // Because delegate is weak reference, and it will be released after out of the function body.
    self.bubbleTransition = [[HYBBubbleTransition alloc] initWithPresented:^(UIViewController *presented, UIViewController *presenting, UIViewController *source, HYBBaseTransition *transition) {
        // You need to cast type to the real subclass type.
        HYBBubbleTransition *bubble = (HYBBubbleTransition *)transition;
        // If you want to use Spring animation, set to YES.
        // Default is NO.
        bubble.animatedWithSpring = YES;
        bubble.bubbleColor = presented.view.backgroundColor;
        
        // 由于一个控制器有导航，一个没有，导致会有64的误差，所以要记得处理这种情况
        CGPoint center = CGPointMake([UIScreen mainScreen].bounds.size.width * 0.5, [UIScreen mainScreen].bounds.size.height * 0.5);
        
        bubble.bubbleStartPoint = center;
    } dismissed:^(UIViewController *dismissed, HYBBaseTransition *transition) {
        // Do nothing and it is ok here.
        // If you really want to do something, here you can set the mode.
        // But inside the super class, it is set to be automally.
        // So you do this has no meaning.
        transition.transitionMode = kHYBTransitionDismiss;
    }];
    loginOn.transitioningDelegate = self.bubbleTransition;
    
    [self presentViewController:loginOn animated:YES completion:NULL];
    
}



//显示蒙板
- (void)createBlackView{
    
    if (!self.isPublish) {
        //移除fastpublish
        [self.fastPublish removeFromSuperview];
        
        
        //添加蒙版
        [self.view addSubview:self.blackView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self.blackView addGestureRecognizer:tap];
        
        //不能再懒加载里设置frame，会有动画
        self.blackView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView animateWithDuration:0.2 animations:^{
            self.blackView.alpha = 0.8;
        }];
        
        //添加fastpublish,让它放到最前面（之前的bringtofront方法失灵）
//        self.fastPublish.frame = CGRectMake(126, 492, self.fastPublishWitdh, self.fastPublishWitdh);
        [self.view addSubview:self.fastPublish];
        //添加约束
        self.fastPublish.translatesAutoresizingMaskIntoConstraints=NO;
        
        NSLayoutConstraint *FastWidth = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
        [self.fastPublish addConstraint:FastWidth];
        
        NSLayoutConstraint *FastHeight = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
        [self.fastPublish addConstraint:FastHeight];
        
        NSLayoutConstraint *FastTop = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.view.bounds.size.height - 27 - self.tabbar.bounds.size.height];
        [self.view addConstraint:FastTop];
        
        NSLayoutConstraint *fastMiddle = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-1.0];
        [self.view addConstraint:fastMiddle];
        
        
        
        //设置frame(为了保证弹出是圆形的)
        self.selectPeople.frame = CGRectMake(146, 512, 60, 60);
        self.selectThing.frame = CGRectMake(146, 512, 60, 60);
        
        //加到view上，不能在懒加载里面写[self.view addSubview:_selectPeople];
        [self.view addSubview:self.selectPeople];
        [self.view addSubview:self.selectThing];
        
        //添加约束
        self.selectPeople.translatesAutoresizingMaskIntoConstraints=NO;
        
        NSLayoutConstraint *peopleWidth = [NSLayoutConstraint constraintWithItem:self.selectPeople attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
        [self.selectPeople addConstraint:peopleWidth];
        
        NSLayoutConstraint *peopleHeight = [NSLayoutConstraint constraintWithItem:self.selectPeople attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
        [self.selectPeople addConstraint:peopleHeight];
        
        NSLayoutConstraint *peopleTop = [NSLayoutConstraint constraintWithItem:self.selectPeople attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.view.bounds.size.height - 27 - self.tabbar.bounds.size.height];
        [self.view addConstraint:peopleTop];
        
        NSLayoutConstraint *peopleMiddle = [NSLayoutConstraint constraintWithItem:self.selectPeople attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-1.0];
        [self.view addConstraint:peopleMiddle];
        
        
        //添加约束
        self.selectThing.translatesAutoresizingMaskIntoConstraints=NO;
        
        NSLayoutConstraint *thingWidth = [NSLayoutConstraint constraintWithItem:self.selectThing attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
        [self.selectThing addConstraint:thingWidth];
        
        NSLayoutConstraint *thingHeight = [NSLayoutConstraint constraintWithItem:self.selectThing attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:60];
        [self.selectThing addConstraint:thingHeight];
        
        NSLayoutConstraint *thingTop = [NSLayoutConstraint constraintWithItem:self.selectThing attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:self.view.bounds.size.height - 27 - self.tabbar.bounds.size.height];
        [self.view addConstraint:thingTop];
        
        NSLayoutConstraint *thingMiddle = [NSLayoutConstraint constraintWithItem:self.selectThing attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-1.0];
        [self.view addConstraint:thingMiddle];
        
        
        [self bounceOut];
        
        //已点击发布按钮
        self.isPublish = YES;
        
    }else{
        //移除蒙版
        [self.blackView removeFromSuperview];
        
        [self bounceBack];
    }
}


//点击blackView事件
- (void)tap:(UITapGestureRecognizer *)tap{
    
    self.isPublish = NO;
    
    [self.blackView removeFromSuperview];
    
    [self bounceBack];
}


//弹出动画
- (void)bounceOut{
    //设置弹出动画
    [UIView animateWithDuration:0.2 animations:^{
        
        self.selectPeople.transform = CGAffineTransformMakeTranslation(-82, -120);
        self.selectThing.transform = CGAffineTransformMakeTranslation(81, -120);
        
        
        self.selectPeople.alpha = 1.0;
        self.selectThing.alpha = 1.0;
        
        self.selectThing.layer.cornerRadius = self.selectThing.bounds.size.width * 0.5;
        self.selectPeople.layer.cornerRadius = self.selectThing.bounds.size.width * 0.5;
        
        self.fastPublish.transform = CGAffineTransformMakeRotation(M_PI_4);
        
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.selectPeople.transform = CGAffineTransformTranslate(self.selectPeople.transform, 10, 10);
            self.selectThing.transform = CGAffineTransformTranslate(self.selectThing.transform, -10, 10);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                self.selectPeople.transform = CGAffineTransformTranslate(self.selectPeople.transform, -2, -2);
                self.selectThing.transform = CGAffineTransformTranslate(self.selectThing.transform, 2, -2);
            }];
        }];
        
    }];
}

//收入动画
- (void)bounceBack{
    
    //设置收入动画
    [UIView animateWithDuration:0.2 animations:^{
        self.selectPeople.transform = CGAffineTransformTranslate(self.selectPeople.transform, 96, 120);
        self.selectThing.transform = CGAffineTransformTranslate(self.selectThing.transform, -64, 120);
        
        self.selectPeople.alpha = 0.0;
        self.selectThing.alpha = 0.0;
        
        self.fastPublish.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
        self.isPublish = NO;
    } completion:^(BOOL finished) {
        
        [self.selectPeople removeFromSuperview];
        [self.selectThing removeFromSuperview];
        
        [self.fastPublish removeFromSuperview];
//        self.fastPublish.frame = CGRectMake(126, -27, self.fastPublishWitdh, self.fastPublishWitdh);
        //添加发布按钮
        [self.tabbar addSubview:self.fastPublish];
        
        //添加约束
        self.fastPublish.translatesAutoresizingMaskIntoConstraints=NO;
        
        NSLayoutConstraint *FastWidth = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
        [self.fastPublish addConstraint:FastWidth];
        
        NSLayoutConstraint *FastHeight = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:0 multiplier:0 constant:self.fastPublishWitdh];
        [self.fastPublish addConstraint:FastHeight];
        
        NSLayoutConstraint *FastTop = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeTop multiplier:1.0 constant:-27];
        [self.tabbar addConstraint:FastTop];
        
        NSLayoutConstraint *fastMiddle = [NSLayoutConstraint constraintWithItem:self.fastPublish attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.tabbar attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:-1.0];
        [self.tabbar addConstraint:fastMiddle];
        
        
    }];
}


//点击人或物事件
- (void)jump2publish:(UIButton *)button{
    
    self.isPublish = NO;
    
    [self.blackView removeFromSuperview];
    
    [self bounceBack];
    
    if (button.tag == 1) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HMAddPublishNavController* addPublish =[story instantiateViewControllerWithIdentifier:@"addPublish"];
            
            [self presentViewController:addPublish animated:YES completion:nil];
        });
        
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIStoryboard * story =[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            HMAddSkillNavController* addSkill =[story instantiateViewControllerWithIdentifier:@"addSkill"];
            
            [self presentViewController:addSkill animated:YES completion:nil];
        });
        
    }
    
}


@end
