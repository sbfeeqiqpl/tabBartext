//
//  BaseTabBarViewController.h
//  YYAnimationTabBar
//
//  Created by 王园园 on 15/10/26.
//  Copyright © 2015年 王园园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarViewController : UITabBarController

+(BaseTabBarViewController*)shareTabBarController;

-(void)setTabBarSelectedIndex:(NSUInteger)selectedIndex;

@end
