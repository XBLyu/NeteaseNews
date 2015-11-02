//
//  UIBarButtonItem+Extension.h
//  NeteaseNews
//
//  Created by Mac on 15/10/30.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName target:(id)target action:(SEL)action;
@end
