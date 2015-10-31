//
//  NNMainViewController.m
//  NeteaseNews
//
//  Created by Mac on 15/10/30.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNMainViewController.h"
#import "NNLeftMenu.h"
#import "NNTitleView.h"
#import "NNNavgationController.h"
#import "NNNewsTableViewController.h"
#import "NNReadingTableViewController.h"



#define NNNavShowAnimDuration 0.25


@interface NNMainViewController () <NNLeftMenuDelegate>

@property (nonatomic, weak) NNNavgationController *showingNavC;

@end

@implementation NNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 1.创建子控制器
    // 1.1.新闻控制器
    NNNewsTableViewController *news = [[NNNewsTableViewController alloc] init];
    [self setupVc:news title:@"新闻"];
    
    // 1.2.订阅控制器
    NNReadingTableViewController *reading = [[NNReadingTableViewController alloc] init];
    [self setupVc:reading title:@"阅读"];
    
    // 1.3.图片控制器
    UIViewController *photo = [[UIViewController alloc] init];
    [self setupVc:photo title:@"图片"];
    
    // 1.4.视频控制器
    UIViewController *video = [[UIViewController alloc] init];
    [self setupVc:video title:@"视频"];
    
    // 1.5.跟帖控制器
    UIViewController *comment = [[UIViewController alloc] init];
    [self setupVc:comment title:@"跟帖"];
    
    // 1.6.电台控制器
    UIViewController *radio = [[UIViewController alloc] init];
    [self setupVc:radio title:@"电台"];

    // 2.添加左菜单 （必须先1，再2）
    NNLeftMenu *leftMenu = [[NNLeftMenu alloc] init];
    leftMenu.delegate = self;
    [self.view insertSubview:leftMenu atIndex:1];//插到后面

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

/**
 *  初始化一个控制器
 *
 *  @param vc      需要初始化的控制器
 *  @param title   控制器的标题
 */
- (void)setupVc:(UIViewController *)vc title:(NSString *)title
{
    // 1.设置背景色
    vc.view.backgroundColor = XBRandomColorRGBA;
    
    // 2.设置标题
    NNTitleView *titleView = [[NNTitleView alloc] init];
    titleView.title = title;
    vc.navigationItem.titleView = titleView;
     
    // 3.设置左右按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenu)];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenu)];
    
    // 4.包装一个导航控制器
    NNNavgationController *nav = [[NNNavgationController alloc] initWithRootViewController:vc];
    // 让newsNav成为self（NNMainViewController）的子控制器，能保证：self在，newsNav就在
    // 如果两个控制器互为父子关系，那么它们的view也应该互为父子关系
    [self addChildViewController:nav];
//    [self.view addSubview:nav.view];
//    self.showingNavC = nav;
}

#pragma mark - 监听导航栏按钮点击

- (void)leftMenu
{
    NSLog(@"Function %s on line %d",__FUNCTION__,__LINE__);
    [UIView animateWithDuration:NNNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavC.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * 60;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = 200 - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = topMargin - 60;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, -translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    }];
}

/**
 *  遮盖button
 *
 *  @param cover 传入的遮盖button
 */
- (void)coverClick:(UIButton *)cover
{
    [UIView animateWithDuration:NNNavShowAnimDuration animations:^{
        // 清空transform
        self.showingNavC.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        // 清除遮盖button
        [cover removeFromSuperview];
    }];
}

- (void)rightMenu
{
    NSLog(@"rightMenu");
}


#pragma mark NNLeftMenuDelegate
- (void)leftMenu:(NNLeftMenu *)menu didSelecatedButtonFromIndex:(int)fromIndex toIndex:(int)toIndex {
    // 0.移除旧控制器的view
    NNNavgationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    NSLog(@"%d,%d",fromIndex,toIndex);
    
    // 1.显示新控制器的view
    NNNavgationController *newNav = self.childViewControllers[toIndex];
    // 设置新控制的transform跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    // 设置阴影
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-3, 0);
    newNav.view.layer.shadowOpacity = 0.2;
    [self.view addSubview:newNav.view];
    
    // 2.设置当前正在显示的控制器
    self.showingNavC = newNav;
    
    // 3.清空transform
    [UIView animateWithDuration:NNNavShowAnimDuration animations:^{
        newNav.view.transform = CGAffineTransformIdentity;
    }];

}

@end
