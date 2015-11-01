//
//  NNRightMenuCenterViewRow.m
//  NeteaseNews
//
//  Created by Mac on 15/11/1.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNRightMenuCenterViewRow.h"

@interface NNRightMenuCenterViewRow ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UIButton *titleView;


@end

@implementation NNRightMenuCenterViewRow

+ (instancetype)centerViewRow {
    return [[NSBundle mainBundle] loadNibNamed:@"NNRightMenuCenterViewRow" owner:nil options:nil].lastObject;
}

- (void)setIcon:(NSString *)icon
{
    _icon = [icon copy];
    
    self.iconView.image = [UIImage imageNamed:icon];
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    [self.titleView setTitle:title forState:UIControlStateNormal];
}

@end
