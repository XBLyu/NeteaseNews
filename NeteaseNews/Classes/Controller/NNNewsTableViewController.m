//
//  NNNewsTableViewController.m
//  NeteaseNews
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNNewsTableViewController.h"
#import "NNTitleView.h"

@interface NNNewsTableViewController ()

@end

@implementation NNNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NNTitleView *titleView = [[NNTitleView alloc] init];
    titleView.title = @"adfa";
    self.navigationItem.titleView = titleView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
