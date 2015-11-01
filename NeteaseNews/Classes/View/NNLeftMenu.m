//
//  NNLeftMenu.m
//  NeteaseNews
//
//  Created by Mac on 15/10/30.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNLeftMenu.h"
#import "NNLeftMenuButton.h"

@interface NNLeftMenu ()

@property (nonatomic, weak) NNLeftMenuButton *selectedBtn;

@end

@implementation NNLeftMenu

- (instancetype)init {
    self = [super init];
    if (self) {
        
        // 设置菜单frame
        self.backgroundColor = [UIColor clearColor];
        
        
        
        //添加按钮
        CGFloat alpha = 80;
        [self addButtonWithTitle:@"新闻" icon:@"sidebar_nav_news" bgColor:XBColorRGBA(202, 68, 73, alpha)];
        [self addButtonWithTitle:@"订阅" icon:@"sidebar_nav_reading" bgColor:XBColorRGBA(190, 111, 69, alpha)];
        [self addButtonWithTitle:@"图片" icon:@"sidebar_nav_photo" bgColor:XBColorRGBA(76, 132, 190, alpha)];
        [self addButtonWithTitle:@"视频" icon:@"sidebar_nav_video" bgColor:XBColorRGBA(101, 170, 78, alpha)];
        [self addButtonWithTitle:@"跟帖" icon:@"sidebar_nav_comment" bgColor:XBColorRGBA(170, 172, 73, alpha)];
        [self addButtonWithTitle:@"电台" icon:@"sidebar_nav_radio" bgColor:XBColorRGBA(190, 62, 119, alpha)];

        
    }
    return self;
}


- (void)setDelegate:(id<NNLeftMenuDelegate>)delegate
{
    _delegate = delegate;
    
    // 默认选中新闻按钮
//    [self btnClick:[self.subviews firstObject]];
    [self btnClick:self.subviews[0]];
}


/**
 *  添加按钮
 *
 *  @param title   标题
 *  @param icon    图标
 *  @param bgColor 选中背景色
 *
 *  @return 按钮
 */
- (NNLeftMenuButton *)addButtonWithTitle:(NSString *)title icon:(NSString *)icon bgColor:(UIColor *)bgColor {
    NNLeftMenuButton *btn = [NNLeftMenuButton buttonWithType:UIButtonTypeCustom];
    
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    // 设置图片
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    // 高亮图标不变色
    btn.adjustsImageWhenHighlighted = NO;
    
    // 调整位置
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 添加点击事件
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    // 加载
    [self addSubview:btn];
    btn.tag = self.subviews.count - 1;
    return btn;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮frame
    unsigned long btnCount = self.subviews.count;
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btnCount;
    
    for (int i = 0; i < btnCount; i++) {
        NNLeftMenuButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = btnH * i;
    }
}



- (void)btnClick:(NNLeftMenuButton *)button {
    
    // 先 通知代理
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelecatedButtonFromIndex:toIndex:)]) {
        [self.delegate leftMenu:self didSelecatedButtonFromIndex:(int)self.selectedBtn.tag toIndex:(int)button.tag];
    }

    // 按钮状态控制
    self.selectedBtn.selected = NO;
    button.selected = YES;
    self.selectedBtn = button;
    
    }

@end
