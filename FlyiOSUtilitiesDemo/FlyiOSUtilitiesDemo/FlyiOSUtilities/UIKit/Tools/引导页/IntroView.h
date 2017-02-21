//
//  IntroView.h
//  引导页Sample
//
//  Created by fengly on 15/4/3.
//  Copyright (c) 2015年 fengly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroPage.h"

#define DEFAULT_BACKGROUND_COLOR [UIColor clearColor]
@protocol IntroDelegate
@optional
- (void)introDidFinish;
@end
@interface IntroView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id<IntroDelegate> delegate;
@property (nonatomic, assign) bool swipeToExit;
@property (nonatomic, assign) bool hideOffscreenPages;
@property (nonatomic, strong) UIImage *bgImage;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, assign) CGFloat titleViewY;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, assign) CGFloat pageControlY;
@property (nonatomic, strong) UIButton *skipButton;

@property (nonatomic, assign) NSInteger currentPageIndex;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIImageView *pageBgBack;
@property (nonatomic, strong) UIImageView *pageBgFront;
@property (nonatomic, strong) NSArray *pages;
@property (nonatomic, assign) CGRect titleImgFram;
- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray;

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration;
- (void)hideWithFadeOutDuration:(CGFloat)duration;
@end
