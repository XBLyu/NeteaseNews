//
//  NNNavigationBar.m
//  NeteaseNews
//
//  Created by Mac on 15/11/1.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNNavigationBar.h"

@implementation NNNavigationBar


#warning layoutSubviews 后会statusBar背景色变黑 忘记[super layoutSubviews]了。。。。。
- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIButton *btn in self.subviews) {
        if (![btn isKindOfClass:[UIButton class]]) continue;
        
//        if ((btn.tag == 1)) {
//            btn.x = 0;
//        }
        
        if (btn.centerX < self.width * 0.5) { // 左边的按钮
            btn.x = 0;
        } else if (btn.centerX > self.width * 0.5) { // 右边的按钮
            btn.x = self.width - btn.width;
        }
    }
}

@end
