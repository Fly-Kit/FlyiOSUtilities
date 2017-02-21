//
//  IntroPage.h
//  引导页Sample
//
//  Created by fengly on 15/4/3.
//  Copyright (c) 2015年 fengly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface IntroPage : NSObject
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) UIImage *titleImage;
@property (nonatomic, assign) CGFloat imgPositionY;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, assign) CGFloat titlePositionY;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) UIFont *descFont;
@property (nonatomic, strong) UIColor *descColor;
@property (nonatomic, assign) CGFloat descPositionY;

@property (nonatomic, retain) UIView *customView;

+ (IntroPage *)page;
+ (IntroPage *)pageWithCustomView:(UIView *)customV;
@end
