//
//  IntroPage.m
//  引导页Sample
//
//  Created by fengly on 15/4/3.
//  Copyright (c) 2015年 fengly. All rights reserved.
//

#import "IntroPage.h"

@implementation IntroPage
+ (IntroPage *)page {
    IntroPage *newPage = [[IntroPage alloc] init];
    newPage.imgPositionY    = 0.0f;
    newPage.titlePositionY  = 160.0f;
    newPage.descPositionY   = 140.0f;
    newPage.title = @"";
    newPage.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.0];
    newPage.titleColor = [UIColor whiteColor];
    newPage.desc = @"";
    newPage.descFont = [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0];
    newPage.descColor = [UIColor whiteColor];
    
    return newPage;
}

+ (IntroPage *)pageWithCustomView:(UIView *)customV {
    IntroPage *newPage = [[IntroPage alloc] init];
    newPage.customView = customV;
    
    return newPage;
}
@end
