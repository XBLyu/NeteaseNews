//
//  NNRightMenuViewController.m
//  NeteaseNews
//
//  Created by Mac on 15/11/1.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNRightMenuViewController.h"
#import "NNRightMenuCenterViewRow.h"

@interface NNRightMenuViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIView *centerView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation NNRightMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCenterView];
    
    [self setupBottomView];
//    self.centerView.backgroundColor = [UIColor clearColor];
//    self.bottomView.backgroundColor = [UIColor clearColor];

}

/**
 *  填充中间的内容
 */
- (void)setupCenterView {
    NNRightMenuCenterViewRow *row =[self setupCenterViewRow:@"商城 能赚能花，土豪当家" icon:@"promoboard_icon_mall"];
    [self setupCenterViewRow:@"活动 4.0发布会粉丝招募" icon:@"promoboard_icon_activities"];
    [self setupCenterViewRow:@"应用 金币从来都是这送的" icon:@"promoboard_icon_apps"];
    
    self.centerView.height = self.centerView.subviews.count * (row.height + 10);
//    NSLog(@"%f",self.centerView.height);

}

- (NNRightMenuCenterViewRow *)setupCenterViewRow:(NSString *)title icon:(NSString *)icon
{
    NNRightMenuCenterViewRow *row = [NNRightMenuCenterViewRow centerViewRow];
    row.icon = icon;
    row.title = title;
    row.y = (row.height + 10) * self.centerView.subviews.count;
    [self.centerView addSubview:row];
    return row;
}

/**
 *  填充底部的内容
 */
- (void)setupBottomView {
    
}

/**
 *  头像3D旋转动画
 */
- (void)didShow {
//    NSLog(@"Function %s on line %d",__FUNCTION__,__LINE__);
    
    // 头像旋转
    
//    [UIView animateWithDuration:1.0 animations:^{
//    // 绕轴旋转
//        self.iconView.layer.transform = CATransform3DMakeRotation(M_PI_2, 0, 11, 0);
//    } completion:^(BOOL finished) {
//        self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];
//        [UIView animateWithDuration:1.0 animations:^{
//            self.iconView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 11, 0);
//        }];
//    }];
    
    // CATransition 3D动画
//    CATransition *anim = [CATransition animation];
//    anim.duration = 1.0;
//    anim.type = @"cube";
//    [self.iconView.layer addAnimation:anim forKey:nil];
    
    [UIView transitionWithView:self.iconView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
        self.iconView.image = [UIImage imageNamed:@"user_defaultgift"];
    } completion:^(BOOL finished) {
        // 中间停顿 GCD
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView transitionWithView:self.iconView duration:1.0 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                self.iconView.image = [UIImage imageNamed:@"default_avatar"];
            } completion:nil];
        });
    }];
}

@end
