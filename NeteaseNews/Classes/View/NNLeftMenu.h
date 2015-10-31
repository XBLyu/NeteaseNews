//
//  NNLeftMenu.h
//  NeteaseNews
//
//  Created by Mac on 15/10/30.
//  Copyright (c) 2015年 Moobye. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NNLeftMenu;
@protocol NNLeftMenuDelegate <NSObject>

@optional
- (void)leftMenu:(NNLeftMenu *)menu didSelecatedButtonFromIndex:(int)fromIndex toIndex:(int)toIndex;

@end

@interface NNLeftMenu : UIView

@property (nonatomic, weak) id<NNLeftMenuDelegate> delegate;

@end
