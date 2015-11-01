//
//  NNAdViewController.m
//  NeteaseNews
//
//  Created by Mac on 15/11/1.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNAdViewController.h"

@interface NNAdViewController ()

@end

@implementation NNAdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.背景图片
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"Default-568h@2x"];
    bg.frame = self.view.bounds;
    [self.view addSubview:bg];
    
    // 2.广告图片(真实的广告图片应该要先下载广告图片)
    UIImageView *ad = [[UIImageView alloc] init];
    ad.image = [UIImage imageNamed:@"ad"];
    ad.width = 152;
    ad.height = 284;
    ad.centerX = self.view.width * 0.5;
    ad.centerY = self.view.height * 0.4;
    [self.view addSubview:ad];
    
    // 3.2s后调到下一个主界面
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        window.rootViewController = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
