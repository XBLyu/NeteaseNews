//
//  NNRightMenuCenterViewRow.h
//  NeteaseNews
//
//  Created by Mac on 15/11/1.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NNRightMenuCenterViewRow : UIView

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;

+ (instancetype)centerViewRow;

@end
