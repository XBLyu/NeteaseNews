//
//  UIBarButtonItem+Extension.m
//  NeteaseNews
//
//  Created by Mac on 15/10/30.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    UIButton *button = [[UIButton alloc] init];
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    // 设置按钮的尺寸为背景图片的尺寸
    button.size = button.currentBackgroundImage.size;
    
    // 监听按钮点击
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
#warning tag 1;
//    item.tag = 1;
    return item;
}
@end
