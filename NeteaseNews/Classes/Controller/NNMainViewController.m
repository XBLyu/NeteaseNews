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
#import "NNRightMenuViewController.h"


#define NNNavShowAnimDuration 0.25
#define NNCoverTag 100
#define NNArrowBtnTag 22
#define NNLeftMenuW 150
#define NNLeftMenuH 400
#define NNLeftMenuY 50


@interface NNMainViewController () <NNLeftMenuDelegate>

@property (nonatomic, weak) NNNavgationController *showingNavC;
@property (nonatomic, strong) NNRightMenuViewController *rightMenuVC;
@property (nonatomic, weak) NNLeftMenu *leftMenu;

@end

@implementation NNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.创建子控制器
    [self setupAllChildVcs];
    
    // 2.添加左菜单
    [self setupLeftMenu];
    
    // 3.添加右菜单
    [self setupRightMenu];
    
    // 4.添加arrow按钮
    [self setupArrowBtn];
    
    
}

/**
 *  添加arrow按钮
 */
- (void)setupArrowBtn {
    UIButton *arrowBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [arrowBtn setBackgroundImage:[UIImage imageNamed:@"sidebar_ad_arrow"] forState:UIControlStateNormal];
//    arrowBtn.backgroundColor = [UIColor redColor];
    arrowBtn.width = arrowBtn.currentBackgroundImage.size.width;
    arrowBtn.height = arrowBtn.currentBackgroundImage.size.height;
    arrowBtn.x = 0;
    arrowBtn.y = self.view.height - arrowBtn.currentBackgroundImage.size.height;
    arrowBtn.userInteractionEnabled = YES;
    [arrowBtn addTarget:self action:@selector(arrowBtnClick) forControlEvents:UIControlEventTouchDown];
//#warning tag = 22
//    arrowBtn.tag = NNArrowBtnTag;
    [self.view insertSubview:arrowBtn atIndex:1];
}

- (void)arrowBtnClick {
    [self coverClick:(UIButton *)[self.showingNavC.view viewWithTag:NNCoverTag]];
}

/**
 *  创建右菜单
 */
- (void)setupRightMenu {
    NNRightMenuViewController *rightMenuVC = [[NNRightMenuViewController alloc] init];
    rightMenuVC.view.x = self.view.width - rightMenuVC.view.width;
    [self.view insertSubview:rightMenuVC.view atIndex:1];
    self.rightMenuVC = rightMenuVC;
    
}

/**
 *  创建左菜单
 */
- (void)setupLeftMenu {
    NNLeftMenu *leftMenu = [[NNLeftMenu alloc] init];
    leftMenu.delegate = self;
    leftMenu.height = NNLeftMenuH;
    leftMenu.width = NNLeftMenuW;
    leftMenu.y = NNLeftMenuY;
    [self.view insertSubview:leftMenu atIndex:1];//插到背景imageView的上面
    self.leftMenu= leftMenu;
}

/**
 *  加载子控制器
 */
- (void)setupAllChildVcs {
    // 1.1.新闻控制器
    NNNewsTableViewController *news = [[NNNewsTableViewController alloc] init];
    [self setupVc:news title:@"新闻"];

    NNReadingTableViewController *reading = [[NNReadingTableViewController alloc] init];
    [self setupVc:reading title:@"阅读"];
    
    UIViewController *photo = [[UIViewController alloc] init];
    [self setupVc:photo title:@"图片"];
    
    UIViewController *video = [[UIViewController alloc] init];
    [self setupVc:video title:@"视频"];
    
    UIViewController *comment = [[UIViewController alloc] init];
    [self setupVc:comment title:@"跟帖"];
    
    UIViewController *radio = [[UIViewController alloc] init];
    [self setupVc:radio title:@"电台"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  状态栏样式
 */
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
    vc.view.backgroundColor = [UIColor grayColor];
    
    // 2.设置标题
    NNTitleView *titleView = [[NNTitleView alloc] init];
    titleView.title = title;
    vc.navigationItem.titleView = titleView;
     
    // 3.设置左右按钮
    vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_menuicon" target:self action:@selector(leftMenuClick)];
    vc.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"top_navigation_infoicon" target:self action:@selector(rightMenuClick)];
    
    // 4.包装一个导航控制器
    NNNavgationController *nav = [[NNNavgationController alloc] initWithRootViewController:vc];
    // 让newsNav成为self（NNMainViewController）的子控制器，能保证：self在，newsNav就在
    // 如果两个控制器互为父子关系，那么它们的view也应该互为父子关系
    [self addChildViewController:nav];
}

#pragma mark - 监听导航栏按钮点击

- (void)leftMenuClick
{
    self.leftMenu.hidden = NO;
    self.rightMenuVC.view.hidden = YES;
    
    [UIView animateWithDuration:NNNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavC.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * NNLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = NNLeftMenuW - leftMenuMargin;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = NNLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = NNCoverTag;
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

- (void)rightMenuClick
{
    self.leftMenu.hidden = YES;
    self.rightMenuVC.view.hidden = NO;
    
    [UIView animateWithDuration:NNNavShowAnimDuration animations:^{
        // 取出正在显示的导航控制器的view
        UIView *showingView = self.showingNavC.view;
        
        // 缩放比例
        CGFloat navH = [UIScreen mainScreen].bounds.size.height - 2 * NNLeftMenuY;
        CGFloat scale = navH / [UIScreen mainScreen].bounds.size.height;
        
        // 菜单左边的间距
        CGFloat leftMenuMargin = [UIScreen mainScreen].bounds.size.width * (1 - scale) * 0.5;
        CGFloat translateX = leftMenuMargin - self.rightMenuVC.view.width;
        
        CGFloat topMargin = [UIScreen mainScreen].bounds.size.height * (1 - scale) * 0.5;
        CGFloat translateY = NNLeftMenuY - topMargin;
        
        // 缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        // 平移
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX / scale, translateY / scale);
        
        showingView.transform = translateForm;
        
        // 添加一个遮盖
        UIButton *cover = [[UIButton alloc] init];
        cover.tag = NNCoverTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        cover.frame = showingView.bounds;
        [showingView addSubview:cover];
    } completion:^(BOOL finished) {
        [self.rightMenuVC didShow];
    }];
}


#pragma mark NNLeftMenuDelegate
- (void)leftMenu:(NNLeftMenu *)menu didSelecatedButtonFromIndex:(int)fromIndex toIndex:(int)toIndex {
    // 0.移除旧控制器的view
    NNNavgationController *oldNav = self.childViewControllers[fromIndex];
    [oldNav.view removeFromSuperview];
    
    // 1.显示新控制器的view
    NNNavgationController *newNav = self.childViewControllers[toIndex];
    
    [self.view addSubview:newNav.view];
    // 设置新控制的transform跟旧控制器一样
    newNav.view.transform = oldNav.view.transform;
    // 设置阴影
    newNav.view.layer.shadowColor = [UIColor blackColor].CGColor;
    newNav.view.layer.shadowOffset = CGSizeMake(-3, 0);
    newNav.view.layer.shadowOpacity = 0.2;
//    [self.view addSubview:newNav.view];
    // 一个导航控制器的view第一次显示到它的父控件上时，如果transform的缩放值被改了，上面的20高度当时是不会出来
    
    // 2.设置当前正在显示的控制器
    self.showingNavC = newNav;
    
    // 3.清空transform
    [self coverClick:(UIButton *)[self.showingNavC.view viewWithTag:NNCoverTag]];
}

@end
