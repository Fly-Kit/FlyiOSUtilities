//
//  IntroView.m
//  引导页Sample
//
//  Created by fengly on 15/4/3.
//  Copyright (c) 2015年 fengly. All rights reserved.
//

#import "IntroView.h"
#import "SMPageControl.h"
#import "EPMacroConstant.h"
@interface IntroView ()
{
    NSMutableArray *pageViews;
    NSInteger LastPageIndex;
}

@property (nonatomic,strong) SMPageControl *smPageControl;

@end

@implementation IntroView

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 40.0f;
        [self buildUIWithFrame:frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 40.0f;
        [self buildUIWithFrame:self.frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pagesArray {
    self = [super initWithFrame:frame];
    if (self) {
        pageViews = [[NSMutableArray alloc] init];
        self.swipeToExit = YES;
        self.hideOffscreenPages = YES;
        self.titleViewY = 20.0f;
        self.pageControlY = 40.0f;
        _pages = [pagesArray copy];
        [self buildUIWithFrame:frame];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    }
    return self;
}

#pragma mark - UI building

- (void)buildUIWithFrame:(CGRect)frame {
    self.backgroundColor = DEFAULT_BACKGROUND_COLOR;
    
    [self buildBackgroundImage];
    [self buildScrollViewWithFrame:frame];
    
    [self buildFooterView];
    
    [self.bgImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.skipButton setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
}

- (void)buildBackgroundImage {
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.frame];
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    self.bgImageView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:self.bgImageView];
    
    self.titleImgFram = self.frame;
    self.bgImageView.backgroundColor = [UIColor clearColor];
    self.bgImageView.contentMode = UIViewContentModeScaleToFill;
    self.bgImageView.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.bgImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    self.pageBgBack = [[UIImageView alloc] initWithFrame:self.frame];
    self.pageBgBack.backgroundColor = [UIColor clearColor];
    self.pageBgBack.contentMode = UIViewContentModeScaleToFill;
    self.pageBgBack.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.pageBgBack.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.pageBgBack.alpha = 0;
    [self addSubview:self.pageBgBack];
    
    self.pageBgFront = [[UIImageView alloc] initWithFrame:self.frame];
    self.pageBgFront.backgroundColor = [UIColor clearColor];
    self.pageBgFront.contentMode = UIViewContentModeScaleToFill;
    self.pageBgFront.autoresizesSubviews = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.pageBgFront.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.pageBgFront.alpha = 0;
    [self addSubview:self.pageBgFront];
}

- (void)buildScrollViewWithFrame:(CGRect)frame {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    self.scrollView.bounces = NO;
    //A running x-coordinate. This grows for every page
    CGFloat contentXIndex = 0;
    for (int idx = 0; idx < _pages.count; idx++) {
        [pageViews addObject:[self viewForPage:_pages[idx] atXIndex:&contentXIndex]];
        [self.scrollView addSubview:pageViews[idx]];
    }
    
    [self makePanelVisibleAtIndex:0];
    
    if (self.swipeToExit) {
        [self appendCloseViewAtXIndex:&contentXIndex];
    }
    
    self.scrollView.contentSize = CGSizeMake(contentXIndex, self.scrollView.frame.size.height);
    [self addSubview:self.scrollView];
    
    [self.pageBgBack setAlpha:0];
    [self.pageBgBack setImage:[self bgForPage:1]];
    [self.pageBgFront setAlpha:1];
    [self.pageBgFront setImage:[self bgForPage:0]];
}

- (UIView *)viewForPage:(IntroPage *)page atXIndex:(CGFloat *)xIndex {
    
    UIView *pageView = [[UIView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height)];
    
    *xIndex += self.scrollView.frame.size.width;
    
    if(page.customView) {
        [pageView addSubview:page.customView];
        return pageView;
    }
    
    if(page.titleImage) {
        UIImageView *titleImageView = [[UIImageView alloc] initWithImage:page.titleImage];
        CGRect rect1 = self.titleImgFram;
        rect1.origin.x = (self.scrollView.frame.size.width - rect1.size.width)/2;
        rect1.origin.y = page.imgPositionY;
        [titleImageView setFrame:rect1];
        [pageView addSubview:titleImageView];
    }
    
    if([page.title length]) {
        CGFloat titleHeight;
        
        if ([page.title respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
            NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:page.title attributes:@{ NSFontAttributeName: page.titleFont }];
            CGRect rect = [attributedText boundingRectWithSize:(CGSize){self.scrollView.frame.size.width - 20, CGFLOAT_MAX} options:NSStringDrawingUsesLineFragmentOrigin context:nil];
            titleHeight = ceilf(rect.size.height);
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            titleHeight = [page.title sizeWithFont:page.titleFont constrainedToSize:CGSizeMake(self.scrollView.frame.size.width - 20, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping].height;
#pragma clang diagnostic pop
        }
        
        CGRect titleLabelFrame = CGRectMake(10, self.frame.size.height - page.titlePositionY, self.scrollView.frame.size.width - 20, titleHeight);
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleLabelFrame];
        titleLabel.text = page.title;
        titleLabel.font = page.titleFont;
        titleLabel.textColor = page.titleColor;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [pageView addSubview:titleLabel];
    }
    
    if([page.desc length]) {
        CGRect descLabelFrame = CGRectMake(0, self.frame.size.height - page.descPositionY, self.scrollView.frame.size.width, 500);
        
        UITextView *descLabel = [[UITextView alloc] initWithFrame:descLabelFrame];
        descLabel.text = page.desc;
        descLabel.scrollEnabled = NO;
        descLabel.font = page.descFont;
        descLabel.textColor = page.descColor;
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.userInteractionEnabled = NO;
        //[descLabel sizeToFit];
        [pageView addSubview:descLabel];
    }
    
    return pageView;
}

- (void)appendCloseViewAtXIndex:(CGFloat*)xIndex {
    UIView *closeView = [[UIView alloc] initWithFrame:CGRectMake(*xIndex, 0, self.frame.size.width, self.frame.size.height)];
    closeView.tag = 124;
    [self.scrollView addSubview:closeView];
    
    *xIndex += self.scrollView.frame.size.width;
}

- (void)removeCloseViewAtXIndex:(CGFloat*)xIndex {
    UIView *closeView = [self.scrollView viewWithTag:124];
    if(closeView) {
        [closeView removeFromSuperview];
    }
    
    *xIndex -= self.scrollView.frame.size.width;
}

- (void)buildFooterView {
    
    self.smPageControl = [[SMPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.pageControlY, self.frame.size.width, 20)];
    
    self.smPageControl.numberOfPages = _pages.count;
    self.smPageControl.indicatorMargin = 20.0f;
    self.smPageControl.indicatorDiameter = 10.0f;
    [self.smPageControl setPageIndicatorImage:[UIImage imageNamed:@"引导页未选中圆点"]];
    [self.smPageControl setCurrentPageIndicatorImage:[UIImage imageNamed:@"引导页选中圆点"]];
    //[self.smPageControl addTarget:self action:@selector(spacePageControl:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:self.smPageControl];
    self.smPageControl.userInteractionEnabled = NO;
    self.smPageControl.hidden = NO;
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - self.pageControlY, self.frame.size.width, 20)];
    self.pageControl.hidden = YES;
    [self.pageControl addTarget:self action:@selector(showPanelAtPageControl) forControlEvents:UIControlEventValueChanged];
    self.pageControl.numberOfPages = _pages.count;
    [self addSubview:self.pageControl];
    
    self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 45, SCREEN_WIDTH, 45)];
    self.skipButton.center = CGPointMake(self.center.x, self.skipButton.center.y);
    
    //button 的背景颜色
    self.skipButton.backgroundColor = UIColorFromHex(0x6ca6f7);
//    self.skipButton.layer.masksToBounds = YES;
//    self.skipButton.layer.cornerRadius = 5.f;
    
    [self.skipButton setTitle:@"立即开启" forState:UIControlStateNormal];
    //[self.skipButton setTitleEdgeInsets:UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f)];
    self.skipButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.f];
    
    self.skipButton.alpha = 0.f;
    if (SCREEN_HEIGHT < 568) {
//        [self.skipButton setBackgroundImage:[UIImage imageNamed:@"i4skipbut"] forState:UIControlStateNormal];
//        self.pageControl.frame = CGRectMake(0, self.frame.size.height - self.pageControlY + 10, self.frame.size.width, 20);
//        self.skipButton.center = CGPointMake(self.center.x, self.skipButton.center.y + 10);
    }
    else
    {
//        [self.skipButton setBackgroundImage:[UIImage imageNamed:@"i5skipbut"] forState:UIControlStateNormal];
    }
//    [self.skipButton setTitle:NSLocalizedString(@"Skip", nil) forState:UIControlStateNormal];
    [self.skipButton addTarget:self action:@selector(skipIntroduction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.skipButton];
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.skipButton setAutoresizingMask: UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin];
}

- (void)spacePageControl:(SMPageControl *)sender
{
//    NSLog(@"Current Page (SMPageControl): %d", sender.currentPage);
    
    LastPageIndex = sender.currentPage;
    self.currentPageIndex = sender.currentPage;
    
    [self makePanelVisibleAtIndex:(NSInteger)self.currentPageIndex];
    
    [self.scrollView setContentOffset:CGPointMake(self.currentPageIndex * SCREEN_WIDTH, 0) animated:YES];
     
}

#pragma mark - UIScrollView Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentPageIndex = scrollView.contentOffset.x/self.scrollView.frame.size.width;
    
    if (self.currentPageIndex == (pageViews.count)) {
        
        if ([(id)self.delegate respondsToSelector:@selector(introDidFinish)]) {
            [self.delegate introDidFinish];
            if (self.superview) {
                [self removeFromSuperview];
            }
        }
    } else {
        if (self.currentPageIndex == (pageViews.count -1)) {
            
            [self hiddenSkipButAlpha:1.0f duration:0.3f];
        }
        else
        {
            [self hiddenSkipButAlpha:0.0f duration:0.3f];
        }
        LastPageIndex = self.pageControl.currentPage;
        LastPageIndex = self.smPageControl.currentPage;
        
        self.pageControl.currentPage = self.currentPageIndex;
        self.smPageControl.currentPage = self.currentPageIndex;
        
        [self makePanelVisibleAtIndex:(NSInteger)self.currentPageIndex];
    }
}


- (void)hiddenSkipButAlpha:(CGFloat)alpha duration:(NSTimeInterval)duration
{
    typeof(self) __weak selfTmp = self;
    [UIView animateWithDuration:duration animations:^{
         selfTmp.skipButton.alpha = alpha;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float offset = scrollView.contentOffset.x / self.scrollView.frame.size.width;
    NSInteger page = (int)(offset);
    
    if (page == (pageViews.count - 1) && self.swipeToExit) {
        self.alpha = ((self.scrollView.frame.size.width*pageViews.count)-self.scrollView.contentOffset.x)/self.scrollView.frame.size.width;
    } else {
        [self crossDissolveForOffset:offset];
    }
}

- (void)crossDissolveForOffset:(float)offset {
    NSInteger page = (int)(offset);
    float alphaValue = offset - (int)offset;
    
    if (alphaValue < 0 && self.currentPageIndex == 0){
        [self.pageBgBack setImage:nil];
        [self.pageBgFront setAlpha:(1 + alphaValue)];
        return;
    }
    
    [self.pageBgFront setAlpha:1];
    [self.pageBgFront setImage:[self bgForPage:page]];
    [self.pageBgBack setAlpha:0];
    [self.pageBgBack setImage:[self bgForPage:page+1]];
    
    float backLayerAlpha = alphaValue;
    float frontLayerAlpha = (1 - alphaValue);
    
    [self.pageBgBack setAlpha:backLayerAlpha];
    [self.pageBgFront setAlpha:frontLayerAlpha];
}

- (UIImage *)bgForPage:(NSInteger)idx {
    if(idx >= _pages.count || idx < 0)
        return nil;
    
    return ((IntroPage *)_pages[idx]).bgImage;
}

#pragma mark - Custom setters

- (void)setPages:(NSArray *)pages {
    _pages = [pages copy];
    [self.scrollView removeFromSuperview];
    self.scrollView = nil;
    [self buildScrollViewWithFrame:self.frame];
}

- (void)setBgImage:(UIImage *)bgImage {
    _bgImage = bgImage;
    [self.bgImageView setImage:_bgImage];
}

- (void)setSwipeToExit:(bool)swipeToExit {
    if (swipeToExit != _swipeToExit) {
        CGFloat contentXIndex = self.scrollView.contentSize.width;
        if(swipeToExit) {
            [self appendCloseViewAtXIndex:&contentXIndex];
        } else {
            [self removeCloseViewAtXIndex:&contentXIndex];
        }
        self.scrollView.contentSize = CGSizeMake(contentXIndex, self.scrollView.frame.size.height);
    }
    _swipeToExit = swipeToExit;
    
}

- (void)setTitleView:(UIView *)titleView {
    [_titleView removeFromSuperview];
    _titleView = titleView;
    [_titleView setFrame:CGRectMake((self.frame.size.width-_titleView.frame.size.width)/2, self.titleViewY, _titleView.frame.size.width, _titleView.frame.size.height)];
    [self addSubview:_titleView];
}

- (void)setTitleViewY:(CGFloat)titleViewY {
    _titleViewY = titleViewY;
    [_titleView setFrame:CGRectMake((self.frame.size.width-_titleView.frame.size.width)/2, self.titleViewY, _titleView.frame.size.width, _titleView.frame.size.height)];
}

- (void)setPageControlY:(CGFloat)pageControlY {
    _pageControlY = pageControlY;
    [self.pageControl setFrame:CGRectMake(0, self.frame.size.height - pageControlY, self.frame.size.width, 20)];
}

- (void)setSkipButton:(UIButton *)skipButton {
    [_skipButton removeFromSuperview];
    _skipButton = skipButton;
    [_skipButton addTarget:self action:@selector(skipIntroduction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_skipButton];
}

#pragma mark - Actions

- (void)makePanelVisibleAtIndex:(NSInteger)panelIndex{
    [UIView animateWithDuration:0.3 animations:^{
        for (int idx = 0; idx < pageViews.count; idx++) {
            if (idx == panelIndex) {
                [pageViews[idx] setAlpha:1];
            }
            else {
                if(!self.hideOffscreenPages) {
                    [pageViews[idx] setAlpha:0];
                }
            }
        }
    }];
}

- (void)showPanelAtPageControl {
    LastPageIndex = self.pageControl.currentPage;
    self.currentPageIndex = self.pageControl.currentPage;
    
    [self makePanelVisibleAtIndex:(NSInteger)self.currentPageIndex];
    
    [self.scrollView setContentOffset:CGPointMake(self.currentPageIndex * SCREEN_WIDTH, 0) animated:YES];
}

- (void)skipIntroduction {
    if ([(id)self.delegate respondsToSelector:@selector(introDidFinish)]) {
        [self.delegate introDidFinish];
    }
    
    [self hideWithFadeOutDuration:0.3];
}

- (void)hideWithFadeOutDuration:(CGFloat)duration {
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

- (void)showInView:(UIView *)view animateDuration:(CGFloat)duration {
    self.alpha = 0;
    [self.scrollView setContentOffset:CGPointZero];
    [view addSubview:self];
    
    [UIView animateWithDuration:duration animations:^{
        self.alpha = 1;
    }];
}


- (void)dealloc
{
    NSLog(@"引导页释放");
}

@end
