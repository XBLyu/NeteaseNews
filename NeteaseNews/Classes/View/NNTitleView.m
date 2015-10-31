//
//  NNTitleView.m
//  NeteaseNews
//
//  Created by Mac on 15/10/31.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import "NNTitleView.h"

@implementation NNTitleView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        [self setImage:[UIImage imageNamed:@"navbar_netease"] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:22];
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        self.height = self.currentImage.size.height;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    
    [self setTitle:title forState:UIControlStateNormal];
    
    NSDictionary *attrs = @{NSFontAttributeName : self.titleLabel.font};
    // boundingRectWithSize 计算出titleLabel的尺寸
    CGFloat titleW = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size.width;
    
    self.width = titleW + self.titleEdgeInsets.left + self.currentImage.size.width;
}


@end
