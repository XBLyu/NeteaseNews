//
//  NNNavgationController.m
//  NeteaseNews
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNNavgationController.h"

@interface NNNavgationController ()

@end

@implementation NNNavgationController

// 只执行一次的方法
+ (void)initialize
{ 
    UINavigationBar *appearance = [UINavigationBar appearance];
    
    // 设置导航栏背景
    [appearance setBackgroundImage:[UIImage imageNamed:@"top_navigation_background"] forBarMetrics:UIBarMetricsDefault];
}

@end
